package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IBusinesstypeDao;
import com.gospell.boss.dao.IOperatorDao;
import com.gospell.boss.dao.IOperatorrolerefDao;
import com.gospell.boss.dao.IPrinttemplateDao;
import com.gospell.boss.dao.IUserTaxpayerDao;
import com.gospell.boss.dao.IUserbusinessDao;
import com.gospell.boss.dao.IUserbusinessdetailDao;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Dispatch;
import com.gospell.boss.po.Menu;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.Printpara;
import com.gospell.boss.po.Printtemplate;
import com.gospell.boss.po.Problemcomplaint;
import com.gospell.boss.po.Store;
import com.gospell.boss.po.User;
import com.gospell.boss.po.UserTaxpayer;
import com.gospell.boss.po.Userbusiness;
import com.gospell.boss.po.Userbusinessdetail;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.service.ISystemparaService;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/print")
@Transactional
public class PrintController extends BaseController {

	@Autowired
	private ServletContext servletContext;

	@Autowired
	private IPrinttemplateDao printtemplateDao;
	
	@Autowired
	private IUserbusinessdetailDao userbusinessdetailDao;
	
	@Autowired
	private IUserbusinessDao userbusinessDao;
	@Autowired
	private IUserTaxpayerDao userTaxpayerDao;
	@Autowired
	private ISystemparaService systemparaService;

	@RequestMapping(value="/findBusinessByList")
	public String findBusinessByList(Userbusiness form, Printtemplate printtemplate) {
		/*form.setPager_openset(8);
		form.setPager_count(userbusinessDao.findByCount(form));
		List<Userbusiness> userbusinesses = userbusinessDao.findByList(form);
		form.setUserbusinesslist(userbusinesses);*/
		//template对象
		List<Printtemplate> list = printtemplateDao.queryByList(printtemplate);
		Map<String, String> map = new HashMap<String, String>();
		for (Printtemplate template : list) {
			System.out.println("template:" + template.getName());
			map.put(template.getName(),template.getValue());
		}
		printtemplate.setTemplateMap(map);
		
		printtemplate.setPrinttemplatelist(list);
		
		return "invoice/findUserbusinessList";
	}
	
	
	/**
	 *  获取用户信息
	 * @return
	 */
	@RequestMapping(value="/getPrintInfo")
	public String getPrintInfo(Userbusinessdetail form, HttpServletRequest request) {
		String businessid = request.getParameter("businessid");
		if (businessid == "") {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			List<Userbusinessdetail> list = userbusinessdetailDao.findByBusinessid(Integer.valueOf(businessid));
			form.setUserbusinessdetaillist(list);
		}
		return "invoice/printInfo";
	}

	@RequestMapping(value = "/findDetailListForDialog")
	public String findDetailListForDialog(Userbusinessdetail form,HttpServletRequest request) {
		String businessid = request.getParameter("businessid");
	
		if (businessid == "") {
			form.setReturninfo(getMessage("page.select.empty"));
		} else {
			List<Userbusinessdetail> list = userbusinessdetailDao.findByBusinessid(Integer.valueOf(businessid));
			form.setUserbusinessdetaillist(list);
			form.setBusinessid(Integer.valueOf(businessid));
		}
		
		return "invoice/findDetailListForDialog";
	}
	
	@RequestMapping(value = "/findByList")
	public String findByList(Printtemplate form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(printtemplateDao.findByCount(form));
		form.setPrinttemplatelist(printtemplateDao.findByList(form));
		return "invoice/findInvoiceTemplate";
	}
	
	@RequestMapping(value = "/test")
	public String test(Printtemplate form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(printtemplateDao.findByCount(form));
		form.setPrinttemplatelist(printtemplateDao.findByList(form));
		//template对象
		List<Printtemplate> list = printtemplateDao.queryByList(form);
		Map<String, String> map = new HashMap<String, String>();
		for (Printtemplate template : list) {
			map.put(template.getValue(),template.getName());
		}
		form.setTemplateMap(map);
		return "invoice/test";
	}

	@RequestMapping(value = "/addInit")
	public String addInit(Printtemplate form) {
		List<Printpara> list = printtemplateDao.queryPrintpara();
		Map<Integer, String> map = new HashMap<Integer, String>();
		for (Printpara printpara : list) {
			map.put(printpara.getId(), printpara.getName());
		}
		form.setPrintParaMap(map);
		return "invoice/addInvoiceTemplate";
	}
	
	@RequestMapping(value = "/saveTemplate")
	public String saveTemplate(Printtemplate form) {
		if ( printtemplateDao.findByName(form.getName()) != null){
			form.setReturninfo(getMessage("print.name.exist"));
			return addInit(form);
		}
		form.setAddtime(Tools.getCurrentTime());
		printtemplateDao.save(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value = "/updateInit")
	public String updateInit(Printtemplate form) {
		form.setPrinttemplate(printtemplateDao.findById(form.getId()));
		return "invoice/updateTemplate";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Printtemplate form) {

		form.setAddtime(Tools.getCurrentTime());
		printtemplateDao.update(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Printtemplate form) {
		printtemplateDao.delete(form.getId());
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}

	
	@ResponseBody
	@RequestMapping(value = "/getParaJson")
	public List<Map<String, Object>> getParaJson(Printtemplate form) {
		List<Printpara> paraList = printtemplateDao.queryPrintpara();
		List<Map<String, Object>> paraJson = new ArrayList<Map<String, Object>>();
		// 封装区域属性结构信息
		for (Printpara printpara : paraList) {
			HashMap<String, Object> areaMap = new HashMap<String, Object>();
			areaMap.put("code", printpara.getCode());
			areaMap.put("text", getMessage("print."+printpara.getCode()));
			paraJson.add(areaMap);
		}
		return paraJson;
	}

	/**
	 * 打印插件传输
	 */
	@RequestMapping(value = "/printPluginInstall")
	public String printPluginInstall(User form, HttpServletResponse response, HttpServletRequest request) {
		String plugin_version = request.getParameter("plugin_version");
		String plugin_folder_path = servletContext.getRealPath(File.separator) + "js" + File.separatorChar + "lodop" + File.separatorChar;
		String plugin_file_path = plugin_folder_path + plugin_version;
		try {
			File plugin = new File(plugin_file_path);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + plugin.length()); // 文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("printPlugin.exe", "UTF-8"));
			FileInputStream fis = new FileInputStream(plugin);
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
     * 初始化发票打印模板的下拉列表框值
     */
	@ResponseBody //此标签表示返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
	@RequestMapping(value="/initInvoiceTmpJson")
    public Map<String,Object> initInvoiceTmpJson(Printtemplate form) {
		//封装返回给页面的json对象
		HashMap<String,Object> invoiceTmpJson = new HashMap<String,Object>();
 		List<Printtemplate> invoicelist = printtemplateDao.queryByList(form);
 		for (Iterator iterator = invoicelist.iterator(); iterator.hasNext();) {
 			Printtemplate printtemplate = (Printtemplate) iterator.next();
 			invoiceTmpJson.put(printtemplate.getCode(), printtemplate.getName());
 		}
 		return invoiceTmpJson;
    }
	
	@RequestMapping(value="/findInvoiceTmp")
	public String findInvoiceTmp(Userbusiness form, Printtemplate printtemplate) {
		//template对象
		List<Printtemplate> list = printtemplateDao.queryByList(printtemplate);
		Map<String, String> map = new HashMap<String, String>();
		for (Printtemplate template : list) {
			map.put(template.getName(),template.getValue());
		}
		printtemplate.setTemplateMap(map);
		return "invoice/printInfo";
	}
}
