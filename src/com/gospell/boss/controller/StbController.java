package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.ICardDao;
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.IStbDao;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Stb;

/**
 * 机顶盒控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/stb")
@Transactional
public class StbController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IStbDao stbDao;
	@Autowired
	private ICardDao cardDao;
	@Autowired
	private IProviderDao providerDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IServerDao serverDao;

	/**
	 * 查询机顶盒信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Stb form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(stbDao.findByCount(form));
		List<Stb> stblist = stbDao.findByList(form);
		for (Stb stb : stblist) {
			stb.setProvider(providerDao.findById(stb.getProviderid()));
			stb.setNetwork(networkDao.findById(stb.getNetid()));
			stb.setServer(serverDao.findById(stb.getServerid()));
			Card card = cardDao.findByStbnoStr(stb.getStbno());
			if(card != null){
				stb.setPaircardid(card.getCardid());
			}
		}
		form.setStblist(stblist);

		return "stb/findStbList";
	}

	/**
	 * 添加机顶盒信息初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Stb form) {
		// 构建机顶盒规格型号列表
		Provider stbproviderform = new Provider();
		stbproviderform.setQuerytype("0");
		List<Provider> stbproviderlist = providerDao.queryByList(stbproviderform);
		form.setProviderlist(stbproviderlist);
		// 构建网络Map对象
		List<Network> netlist = networkDao.queryByList(new Network());
		form.setNetworklist(netlist);
		
		return "stb/addStb";
	}

	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Stb form) {
		
		Server serverForm = new Server();
		serverForm.setServertype("cas");
		serverForm.setNetid(form.getNetid());
		serverForm.setVersiontype(form.getVersiontype());
		
		//根据页面输入的网络ID和CAS版本类型，查询数据库中唯一的cas服务器
		Server server = serverDao.findByServertypeAndVersiontype(serverForm);
		
		if(server == null || server.getId() ==null){
			form.setReturninfo(getMessage("stb.server.notexist"));
			return addInit(form);
		}
		
		//设置CAS服务器ID
		form.setServerid(server.getId());
		
		// 判断机顶盒不能为空
		if ("".equals(form.getStbno())) {
			form.setReturninfo(getMessage("stb.stbno.empty"));
			return addInit(form);
		} else {
			Stb oldStb = stbDao.findByStbno(form);
			if (oldStb != null) {
				form.setReturninfo(getMessage("stb.stbno.existed"));
				return addInit(form);
			}
		}
		// state默认设为1-库存
		form.setState("0");
		form.setInputtime(Tools.getCurrentTime());
		stbDao.save(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updateInit")
	public String updateInit(Stb form) {
		form.setStb(stbDao.findById(form.getId()));
		// 构建机顶盒规格型号列表
		Provider stbproviderform = new Provider();
		stbproviderform.setQuerytype("0");
		List<Provider> stbproviderlist = providerDao.queryByList(stbproviderform);
		form.setProviderlist(stbproviderlist);
		// 构建网络Map对象
		List<Network> netlist = networkDao.queryByList(new Network());
		form.setNetworklist(netlist);
		return "stb/updateStb";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Stb form) {
		if ("".equals(form.getStbno())) {
			form.setReturninfo(getMessage("stb.stbno.empty"));
			return updateInit(form);
		}else{
			Stb newstb = stbDao.findByStbno(form);
			if (newstb != null && !newstb.getId().equals(form.getId())) {
				form.setReturninfo(getMessage("stb.stbno.existed"));
				return updateInit(form);
			}
		}
		
		Server serverForm = new Server();
		serverForm.setServertype("cas");
		serverForm.setNetid(form.getNetid());
		serverForm.setVersiontype(form.getVersiontype());
		
		//根据页面输入的网络ID和CAS版本类型，查询数据库中唯一的cas服务器
		Server server = serverDao.findByServertypeAndVersiontype(serverForm);
		if(server == null || server.getId() ==null){
			form.setReturninfo(getMessage("stb.server.notexist"));
			return updateInit(form);
		}
		
		//设置CAS服务器ID
		form.setServerid(server.getId());
		
		//设置入库时间
		Stb oldStb = stbDao.findById(form.getId());
		form.setInputtime(oldStb.getInputtime());
		// 修改网络信息
		stbDao.update(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Stb form) {
		// 删除网络，实际上就是修改state为0-无效
		//Stb stbdmp = stbDao.findById(form.getId());
		//stbdmp.setState("0");
		stbDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}

	/**
	 * 文件导入添加初始页面
	 */
	@RequestMapping(value = "/addByImportFileInit")
	public String addByImportFileInit(Stb form) {
		// 构建机顶盒规格型号列表
		Provider stbproviderform = new Provider();
		stbproviderform.setQuerytype("0");
		List<Provider> stbproviderlist = providerDao.queryByList(stbproviderform);
		form.setProviderlist(stbproviderlist);
		// 构建网络Map对象
		List<Network> netlist = networkDao.queryByList(new Network());
		form.setNetworklist(netlist);
		return "stb/addByImportFile";
	}

	/**
	 * 导入文件信息
	 */
	@RequestMapping(value = "/saveByImportFile")
	public String saveByImportFile(Stb form, @RequestParam("uploadfile") MultipartFile file) throws IOException {
		
		Server serverForm = new Server();
		serverForm.setServertype("cas");
		serverForm.setNetid(form.getNetid());
		serverForm.setVersiontype(form.getVersiontype());
		//根据页面输入的网络ID和CAS版本类型，查询数据库中唯一的cas服务器
		Server server = serverDao.findByServertypeAndVersiontype(serverForm);
		if(server == null || server.getId() ==null){
			form.setReturninfo(getMessage("stb.server.notexist"));
			return addByImportFileInit(form);
		}
		
		// 得到页面上传的临时文件
		// XML上传服务器流文件
		String filename = file.getOriginalFilename();
		if (filename == null || "".equals(filename)) {
			form.setReturninfo(getMessage("uploadify.filename.null"));
			return addByImportFileInit(form);
		}
		// 文件类型
		String[] strArray = filename.split("[.]");
		String type = strArray[strArray.length - 1];
		if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type) && !"txt".equals(type) && !"TXT".equals(type)) {
			form.setReturninfo(getMessage("uploadify.filetype.error"));
			return addByImportFileInit(form);
		}

		String import_template_path = servletContext.getInitParameter("import_template_path");
		String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
		File tmpFile = new File(fullpath);
		file.transferTo(tmpFile);
		try {
			FileInputStream fis = new FileInputStream(tmpFile);
			ArrayList<Stb> stbList = new ArrayList<Stb>();
			if("xls".equals(type) || "XLS".equals(type)){
				HSSFWorkbook excel = new HSSFWorkbook(fis);
				HSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Stb stbRow = fillStbData(row,"0");//解析单独导入机顶盒文件
					/*** 提示机顶盒读取出错地点 ***/
					String returnInfo = stbRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
						form.setReturninfo(returnInfo);
						tmpFile.delete();
						return addByImportFileInit(form);
					} else {
						stbRow.setProviderid(form.getProviderid());
						stbRow.setNetid(form.getNetid());
						stbRow.setVersiontype(form.getVersiontype());
						//设置CAS服务器ID
						stbRow.setServerid(server.getId());
						stbRow.setIncardflag(form.getIncardflag());
						stbRow.setInputtime(Tools.getCurrentTime());
						stbRow.setState("0");
						stbList.add(stbRow);
						
						//每2000个保存一次数据库
						if(stbList.size() >=2000){
							stbDao.saveBatch(stbList);
							stbList.clear();
						}
					}
				}
			}else if("xlsx".equals(type) || "XLSX".equals(type)){
				XSSFWorkbook excel = new XSSFWorkbook(fis);
				XSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Stb stbRow = fillStbData(row,"0");//解析单独导入机顶盒文件
					/*** 提示机顶盒读取出错地点 ***/
					String returnInfo = stbRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
						form.setReturninfo(returnInfo);
						tmpFile.delete();
						return addByImportFileInit(form);
					} else {
						stbRow.setProviderid(form.getProviderid());
						stbRow.setNetid(form.getNetid());
						stbRow.setVersiontype(form.getVersiontype());
						//设置CAS服务器ID
						stbRow.setServerid(server.getId());
						stbRow.setIncardflag(form.getIncardflag());
						stbRow.setInputtime(Tools.getCurrentTime());
						stbRow.setState("0");
						stbList.add(stbRow);
						
						//每2000个保存一次数据库
						if(stbList.size() >=2000){
							stbDao.saveBatch(stbList);
							stbList.clear();
						}
					}
				}
			}else if("txt".equals(type) || "TXT".equals(type)){
				 InputStreamReader read = new InputStreamReader(fis,"UTF-8");//考虑到编码格式
                  BufferedReader bufferedReader = new BufferedReader(read);
                  String lineTxt = null;
                  long curLineNo = 0;
                  while((lineTxt = bufferedReader.readLine()) != null){
                	  if(curLineNo  > 0) {//去掉第一行标题
                	  	Stb stbRow = new Stb();
                	  	stbRow.setProviderid(form.getProviderid());
						stbRow.setNetid(form.getNetid());
						stbRow.setVersiontype(form.getVersiontype());
						//设置CAS服务器ID
						stbRow.setServerid(server.getId());
						stbRow.setIncardflag(form.getIncardflag());
						stbRow.setInputtime(Tools.getCurrentTime());
						stbRow.setState("0");
						stbRow.setStbno(Tools.getStr(lineTxt));
						stbList.add(stbRow);
						
						//每2000个保存一次数据库
						if(stbList.size() >=2000){
							stbDao.saveBatch(stbList);
							stbList.clear();
						}
						
                	  }else{
                		  curLineNo +=1;
                	  }
                  }
			}
			
			if(stbList.size() > 0){
				stbDao.saveBatch(stbList);
			}
			
			form.setReturninfo(getMessage("page.execution.success"));
		} catch (Exception e) {
			e.printStackTrace();
			form.setReturninfo(getMessage("page.execution.failure"));
			tmpFile.delete();
			return addByImportFileInit(form);
		}
		tmpFile.delete();
		return addByImportFileInit(form);
	}

	/**
	 * 下载导入模板
	 */
	@RequestMapping(value = "/downloadTemplate")
	public String downloadTemplate(Stb form, HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + "stbinfo_template.xls";
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("stbinfo_template.xls", "UTF-8"));
			FileInputStream fis = new FileInputStream(excelTemplate);
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (fis.read(buffer) > 0) {
				toClient.write(buffer);
			}
			fis.close();
			toClient.flush();
			toClient.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 通过机卡配对关系文件导入添加初始页面
	 */
	@RequestMapping(value = "/addStbpaircardByImportFileInit")
	public String addStbpaircardByImportFileInit(Stb form) {
		// 构建机顶盒规格型号列表
		Provider stbproviderform = new Provider();
		stbproviderform.setQuerytype("0");
		List<Provider> stbproviderlist = providerDao.queryByList(stbproviderform);
		form.setProviderlist(stbproviderlist);
		
		// 构建机顶盒规格型号列表
		Provider cardproviderform = new Provider();
		cardproviderform.setQuerytype("1");
		List<Provider> cardproviderlist = providerDao.queryByList(cardproviderform);
		form.setCardproviderlist(cardproviderlist);
		
		// 构建网络Map对象
		List<Network> netlist = networkDao.queryByList(new Network());
		form.setNetworklist(netlist);
		return "stb/addStbpaircardByImportFile";
	}
	
	/**
	 * 导入文件信息-通过机卡配对关系
	 */
	@RequestMapping(value = "/saveStbpaircardByImportFile")
	public String saveStbpaircardByImportFile(Stb form, @RequestParam("uploadfile") MultipartFile file) throws IOException {
		
		Server serverForm = new Server();
		serverForm.setServertype("cas");
		serverForm.setNetid(form.getNetid());
		serverForm.setVersiontype(form.getVersiontype());
		//根据页面输入的网络ID和CAS版本类型，查询数据库中唯一的cas服务器
		Server server = serverDao.findByServertypeAndVersiontype(serverForm);
		if(server == null || server.getId() ==null){
			form.setReturninfo(getMessage("stb.server.notexist"));
			return addStbpaircardByImportFileInit(form);
		}
		
		// 得到页面上传的临时文件
		// XML上传服务器流文件
		String filename = file.getOriginalFilename();
		if (filename == null || "".equals(filename)) {
			form.setReturninfo(getMessage("uploadify.filename.null"));
			return addStbpaircardByImportFileInit(form);
		}
		// 文件类型
		String[] strArray = filename.split("[.]");
		String type = strArray[strArray.length - 1];
		if (!"xls".equals(type) && !"XLS".equals(type) && !"xlsx".equals(type) && !"XLSX".equals(type)) {
			form.setReturninfo(getMessage("uploadify.filetype.error"));
			return addStbpaircardByImportFileInit(form);
		}

		String import_template_path = servletContext.getInitParameter("import_template_path");
		String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
		File tmpFile = new File(fullpath);
		file.transferTo(tmpFile);
		try {
			FileInputStream fis = new FileInputStream(tmpFile);
			ArrayList<Stb> stbList = new ArrayList<Stb>();
			ArrayList<Card> cardList = new ArrayList<Card>();
			if("xls".equals(type) || "XLS".equals(type)){
				HSSFWorkbook excel = new HSSFWorkbook(fis);
				HSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Stb stbRow = fillStbData(row,"1");//解析导入机卡配对文件
					/*** 提示机顶盒读取出错地点 ***/
					String returnInfo = stbRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
//						form.setReturninfo(returnInfo);
//						tmpFile.delete();
//						return addByImportFileInit(form);
						//遇到空行，跳出此循环，自动保存下一行
						continue;
					} else {
						stbRow.setProviderid(form.getProviderid());
						stbRow.setNetid(form.getNetid());
						stbRow.setVersiontype(form.getVersiontype());
						//设置CAS服务器ID
						stbRow.setServerid(server.getId());
						stbRow.setIncardflag(form.getIncardflag());
						stbRow.setInputtime(Tools.getCurrentTime());
						stbRow.setState("0");
						stbList.add(stbRow);
						
						Card cardRow = new Card();
						cardRow.setProviderid(form.getCardproviderid());
						cardRow.setNetid(form.getNetid());
						cardRow.setVersiontype(form.getVersiontype());
						cardRow.setIncardflag(form.getIncardflag());
						//设置CAS服务器ID
						cardRow.setServerid(server.getId());
						cardRow.setInputtime(Tools.getCurrentTime());
						cardRow.setState("0");
						cardRow.setCardid(stbRow.getCardid());
						cardRow.setStbno(stbRow.getStbno());
						
						cardList.add(cardRow);
						
						//每2000个保存一次数据库
						if(stbList.size() >=2000){
							//插入机顶盒
							stbDao.saveBatch(stbList);
							stbList.clear();
							//插入智能卡
							cardDao.saveBatch(cardList);
							cardList.clear();
						}
					}
				}
			}else if("xlsx".equals(type) || "XLSX".equals(type)){
				XSSFWorkbook excel = new XSSFWorkbook(fis);
				XSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排表头跳过不读
					}
					Stb stbRow = fillStbData(row,form.getIncardflag());
					/*** 提示机顶盒读取出错地点 ***/
					String returnInfo = stbRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
//						form.setReturninfo(returnInfo);
//						tmpFile.delete();
//						return addByImportFileInit(form);
						//遇到空行，跳出此循环，自动保存下一行
						continue;
					} else {
						stbRow.setProviderid(form.getProviderid());
						stbRow.setNetid(form.getNetid());
						stbRow.setVersiontype(form.getVersiontype());
						//设置CAS服务器ID
						stbRow.setServerid(server.getId());
						stbRow.setIncardflag(form.getIncardflag());
						stbRow.setInputtime(Tools.getCurrentTime());
						stbRow.setState("0");
						stbList.add(stbRow);
						
						Card cardRow = new Card();
						cardRow.setProviderid(form.getCardproviderid());
						cardRow.setNetid(form.getNetid());
						cardRow.setVersiontype(form.getVersiontype());
						cardRow.setIncardflag(form.getIncardflag());
						//设置CAS服务器ID
						cardRow.setServerid(server.getId());
						cardRow.setInputtime(Tools.getCurrentTime());
						cardRow.setState("0");
						cardRow.setCardid(stbRow.getCardid());
						cardRow.setStbno(stbRow.getStbno());
						
						cardList.add(cardRow);
						
						//每2000个保存一次数据库
						if(stbList.size() >=2000){
							//插入机顶盒
							stbDao.saveBatch(stbList);
							stbList.clear();
							//插入智能卡
							cardDao.saveBatch(cardList);
							cardList.clear();
						}
					}
				}
			}
			
			if(stbList.size() > 0){
				//插入机顶盒
				stbDao.saveBatch(stbList);
				//插入智能卡
				cardDao.saveBatch(cardList);
			}
			
			form.setReturninfo(getMessage("page.execution.success"));
		} catch (Exception e) {
			e.printStackTrace();
			form.setReturninfo(getMessage("page.execution.failure"));
			tmpFile.delete();
			return addStbpaircardByImportFileInit(form);
		}
		tmpFile.delete();
		return addStbpaircardByImportFileInit(form);
	}
	
	/**
	 * 下载导入模板-机卡配对关系
	 */
	@RequestMapping(value = "/downloadTemplateForStbpaircard")
	public String downloadTemplateForStbpaircard(Stb form, HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + "stbpaircardinfo_template.xls";
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("stbpaircardinfo_template.xls", "UTF-8"));
			FileInputStream fis = new FileInputStream(excelTemplate);
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (fis.read(buffer) > 0) {
				toClient.write(buffer);
			}
			fis.close();
			toClient.flush();
			toClient.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 读取EXCEL单元值
	 */
	private String cellValue(Cell cell) {
		String cellValue = "";
		if (cell != null) {
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_NUMERIC:
				double temp = cell.getNumericCellValue();
				cellValue = temp == (int) temp ? String.valueOf((int) temp) : String.valueOf(temp);
				break;
			case HSSFCell.CELL_TYPE_STRING:
				cellValue = cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				cellValue = String.valueOf(cell.getBooleanCellValue());
				break;
			}
		}
		return cellValue;
	}

	/**
	 * 封装EXCEL中的STB信息
	 * importtype 0-只单独导入机顶盒；1-导入机卡配对关系
	 */
	private Stb fillStbData(Row row,String importtype) {
		Stb stb = new Stb();
		//获取机顶盒号
		Cell cell0 = row.getCell(0);
		String stbno_val = this.cellValue(cell0);
		if (stbno_val == "" || stbno_val == null) {
			stb.setReturninfo(getMessage("stb.stbno.empty"));
			return stb;
		}else{
			stb.setStbno(stbno_val);
		}
		
		if("1".equals(importtype)){
			Cell cell1 = row.getCell(1);
			String cardid = this.cellValue(cell1);
			if (cardid == "" || cardid == null) {
				stb.setReturninfo(getMessage("stb.cardid.empty"));
				return stb;
			}else{
				stb.setCardid(cardid);
			}
		}
		
		return stb;
	}
    
	@RequestMapping(value="/findStbListForDialog")
	public String findStbListForDialog(Stb form) {
		Network network = networkDao.findById(Integer.parseInt(form.getQuerynetid()));
		form.setNetwork(network);
		form.setPager_openset(5);
		form.setPager_count(stbDao.findByCount(form));
		List<Stb> stblist = stbDao.findByList(form);
		for (Stb stb : stblist) {
			stb.setProvider(providerDao.findById(stb.getProviderid()));
			stb.setNetwork(networkDao.findById(stb.getNetid()));
			stb.setServer(serverDao.findById(stb.getServerid()));
			Card card = cardDao.findByStbnoStr(stb.getStbno());
			if(card != null){
				stb.setPaircardid(card.getCardid());
			}
		}
		form.setStblist(stblist);
		return "stb/findStbListForDialog";
	}
	
}
