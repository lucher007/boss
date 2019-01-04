package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.From;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
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
import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProviderDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.ICardDao;
import com.gospell.boss.dao.IStbDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Server;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Stb;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/card")
@Transactional
public class CardController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private ICardDao cardDao;
	@Autowired
	private IStbDao stbDao;
	@Autowired
	private IProviderDao providerDao;
	@Autowired
	private INetworkDao networkDao;
	@Autowired
	private IServerDao serverDao;

	/**
	 * 查询用户信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Card form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(cardDao.findByCount(form));
		List<Card> cardlist = cardDao.findByList(form);
		for (Card card : cardlist) {
			card.setProvider(providerDao.findById(card.getProviderid()));
			card.setNetwork(networkDao.findById(card.getNetid()));
			card.setServer(serverDao.findById(card.getServerid()));
		}
		form.setCardlist(cardlist);
		return "card/findCardList";
	}

	/**
	 * 添加用户信息初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Card form) {
		// 构建供应商List对象
		Provider providerform = new Provider();
		providerform.setQuerytype("1");
		List<Provider> providerlist = providerDao.queryByList(providerform);
		form.setProviderlist(providerlist);
		// 构建网络List对象
		List<Network> networklist = networkDao.queryByList(new Network());
		form.setNetworklist(networklist);

		return "card/addCard";
	}

	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Card form, HttpServletRequest request) {
		String mode = String.valueOf(form.getAddmode());
		
		Server serverForm = new Server();
		serverForm.setServertype("cas");
		serverForm.setNetid(form.getNetid());
		serverForm.setVersiontype(form.getVersiontype());
		
		//根据页面输入的网络ID和CAS版本类型，查询数据库中唯一的cas服务器
		Server server = serverDao.findByServertypeAndVersiontype(serverForm);
		if(server == null || server.getId() ==null){
			form.setReturninfo(getMessage("card.server.notexist"));
			return addInit(form);
		}
		//设置CAS服务器ID
		form.setServerid(server.getId());
		
		if ("".equals(form.getCardid())) {
			form.setReturninfo(getMessage("card.cardid.empty"));
			return addInit(form);
		} else {
			//判断智能表中智能卡号重复
			Card oldCard = cardDao.findByCardid(form);
			if (oldCard != null) {
				form.setReturninfo(getMessage("card.cardid.existed"));
				return addInit(form);
			}
		}
		// state默认设为1-库存
		form.setState("0");
		form.setInputtime(Tools.getCurrentTime());
		
		if(StringUtils.isEmpty(form.getStbno())){
			form.setStbno(null);
		}else{
			Card card = cardDao.findByStbnoStr(form.getStbno());
			if(card != null){
				form.setReturninfo(getMessage("card.stb.paired"));
				return addInit(form);
			}
		}
		
		cardDao.save(form);
		
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	/**
	 * 更新初始化
	 */
	@RequestMapping(value = "/updateInit")
	public String updateInit(Card form) {

		form.setCard(cardDao.findById(form.getId()));

		// 构建供应商List对象
		Provider providerform = new Provider();
		providerform.setQuerytype("1");
		List<Provider> providerlist = providerDao.queryByList(providerform);
		form.setProviderlist(providerlist);
		// 构建网络List对象
		List<Network> networklist = networkDao.queryByList(new Network());
		form.setNetworklist(networklist);

		return "card/updateCard";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Card form) {
		if ("".equals(form.getCardid())) {
			form.setReturninfo(getMessage("card.cardid.empty"));
			return updateInit(form);
		}else{
			//判断卡号是否重复
			Card newCard = cardDao.findByCardid(form);
			if (newCard != null && !newCard.getId().equals(form.getId())) {
				form.setReturninfo(getMessage("card.cardid.existed"));
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
			form.setReturninfo(getMessage("card.server.notexist"));
			return updateInit(form);
		}
		//设置CAS服务器ID
		form.setServerid(server.getId());
		
		//设置入库时间
		Card oldCard = cardDao.findById(form.getId());
		form.setInputtime(oldCard.getInputtime());
		
		if(StringUtils.isEmpty(form.getStbno())){
			form.setStbno(null);
		}else{
			Card card = cardDao.findByStbnoStr(form.getStbno());
			if(card != null && !card.getCardid().equals(form.getCardid())){
				form.setReturninfo(getMessage("card.stb.paired"));
				return updateInit(form);
			}
		}
		
		// 修改网络信息
		cardDao.update(form);

		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Card form) {

		// 删除网络，实际上就是修改state为0-无效
		//Card carddmp = cardDao.findById(form.getId());
		//carddmp.setState("0");
		cardDao.delete(form.getId());

		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}

	/**
	 * 下载导入文件模板
	 */
	@RequestMapping(value = "/downloadTemplate")
	public String downloadTemplate(HttpServletResponse response) {
		try {
			String import_template_path = servletContext.getInitParameter("import_template_path");
			String folderpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + "cardinfo_template.txt";
			File excelTemplate = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + excelTemplate.length()); // XML文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("cardinfo_template.txt", "UTF-8"));
			FileInputStream fis = new FileInputStream(excelTemplate);
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (fis.read(buffer) > 0) {
				toClient.write(buffer); // 输出数据
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
	 * 文件导入页面初始化
	 */
	@RequestMapping(value = "/addByImportFileInit")
	public String addByImportFileInit(Card form) {
		// 构建供应商List对象
		Provider providerform = new Provider();
		providerform.setQuerytype("1");
		List<Provider> providerlist = providerDao.queryByList(providerform);
		form.setProviderlist(providerlist);
		// 构建网络List对象
		List<Network> networklist = networkDao.queryByList(new Network());
		form.setNetworklist(networklist);
		return "card/addByImportFile";
	}

	/**
	 * 导入文件信息
	 */
	@RequestMapping(value = "/saveByImportFile")
	public String saveByImportFile(Card form, @RequestParam("uploadfile") MultipartFile file) throws IOException {
		Server serverForm = new Server();
		serverForm.setServertype("cas");
		serverForm.setNetid(form.getNetid());
		serverForm.setVersiontype(form.getVersiontype());
		//根据页面输入的网络ID和CAS版本类型，查询数据库中唯一的cas服务器
		Server server = serverDao.findByServertypeAndVersiontype(serverForm);
		if(server == null || server.getId() ==null){
			form.setReturninfo(getMessage("card.server.notexist"));
			return addByImportFileInit(form);
		}
		
		// 得到页面上传的临时文件
		// XML上传服务器流文件
		String import_template_path = servletContext.getInitParameter("import_template_path");
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
		String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
		File tmpFile = new File(fullpath);
		file.transferTo(tmpFile);
		try {
			// 封装保存的Event对象
			FileInputStream fis = new FileInputStream(tmpFile);
			ArrayList<Card> cardList = new ArrayList<Card>();
			if("xls".equals(type) || "XLS".equals(type)){
				HSSFWorkbook excel = new HSSFWorkbook(fis);
				HSSFSheet sheet0 = excel.getSheetAt(0);
				for (Row row : sheet0) {
					if (row.getRowNum() == 0) {
						continue; // 第一排不读
					}
					Card cardRow = fillCardData(row);
					/*** 提示用户读取出错地点 ***/
					String returnInfo = cardRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
//						form.setReturninfo(returnInfo);
//						tmpFile.delete();
//						return addByImportFileInit(form);
						//遇到空行，跳出此循环，自动保存下一行
						continue;
					} else {
						cardRow.setProviderid(form.getProviderid());
						cardRow.setNetid(form.getNetid());
						cardRow.setVersiontype(form.getVersiontype());
						cardRow.setIncardflag(form.getIncardflag());
						//设置CAS服务器ID
						cardRow.setServerid(server.getId());
						cardRow.setInputtime(Tools.getCurrentTime());
						cardRow.setState("0");
						cardList.add(cardRow);
						//每2000个保存一次数据库
						if(cardList.size() >=2000){
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
					Card cardRow = fillCardData(row);
					/*** 提示机顶盒读取出错地点 ***/
					String returnInfo = cardRow.getReturninfo();
					if (returnInfo != null && returnInfo != "") {
//						form.setReturninfo(returnInfo);
//						tmpFile.delete();
//						return addByImportFileInit(form);
						//遇到空行，跳出此循环，自动保存下一行
						continue;
					} else {
						cardRow.setProviderid(form.getProviderid());
						cardRow.setNetid(form.getNetid());
						cardRow.setVersiontype(form.getVersiontype());
						cardRow.setIncardflag(form.getIncardflag());
						//设置CAS服务器ID
						cardRow.setServerid(server.getId());
						cardRow.setInputtime(Tools.getCurrentTime());
						cardRow.setState("0");
						cardList.add(cardRow);
						
						//每2000个保存一次数据库
						if(cardList.size() >=2000){
							cardDao.saveBatch(cardList);
							cardList.clear();
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
                		//去空行
  						if(Tools.getStr(lineTxt).isEmpty()){
  							continue;
  						}
                		  
                		Card cardRow = new Card();
                		cardRow.setProviderid(form.getProviderid());
						cardRow.setNetid(form.getNetid());
						cardRow.setVersiontype(form.getVersiontype());
						cardRow.setIncardflag(form.getIncardflag());
						//设置CAS服务器ID
						cardRow.setServerid(server.getId());
						cardRow.setInputtime(Tools.getCurrentTime());
						cardRow.setState("0");
						cardRow.setCardid(Tools.getStr(lineTxt));
						cardList.add(cardRow);
						
						//每2000个保存一次数据库
						if(cardList.size() >=2000){
							cardDao.saveBatch(cardList);
							cardList.clear();
						}
						
                	  }else{
                		  curLineNo +=1;
                	  }
                  }
			}
			
			if(cardList.size() > 0){
				cardDao.saveBatch(cardList);
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
	 * 取得EXCEL单元格的值
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
	 * 封装CARD信息
	 */
	private Card fillCardData(Row row) {
		Card card = new Card();
		Cell cell0 = row.getCell(0);
		String cardid_val = this.cellValue(cell0);
		if (cardid_val == "" || cardid_val == null) {
			card.setReturninfo(getMessage("card.cardid.empty"));
			return card;
		}else{
			card.setCardid(cardid_val);
		}
		
		return card;
	}

}
