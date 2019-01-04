package com.gospell.boss.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.common.AesSecret;
import com.gospell.boss.common.ExportExcel;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IGiftcardamountparaDao;
import com.gospell.boss.dao.IGiftcardDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Giftcardamountpara;
import com.gospell.boss.po.Giftcard;
import com.gospell.boss.po.Product;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/giftcard")
@Transactional
public class GiftcardController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private IGiftcardDao giftcardDao; 
	@Autowired 
	private IGiftcardamountparaDao giftcardamountparaDao;
	@Autowired
	private ISystemparaDao systemparaDao;
   
	/*
     * 特殊的instance变量
     * 注：零长度的byte数组对象创建起来将比任何对象都经济――查看编译后的字节码：
     * 生成零长度的byte[]对象只需3条操作码，而Object lock = new Object()则需要7行操作码。
     */
    private static byte[] lock = new byte[0];    
	
	/**
	 * 查询用户信息
	 */
	@RequestMapping(value="/findByList")
	public String findByList(Giftcard form) {
		if(StringUtils.isEmpty(form.getQuerystate())){
			form.setQuerystate("1");//默认查有效的
		}
		if(StringUtils.isEmpty(form.getQueryusedflag())){
			form.setQueryusedflag("0");//默认查未使用的
		}
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(giftcardDao.findByCount(form));
		List<Giftcard> giftcardlist = giftcardDao.findByList(form);
		form.setGiftcardlist(giftcardlist);
		
		// 构建面额参数LIST
		Giftcardamountpara amountparaForm = new Giftcardamountpara();
		amountparaForm.setQuerystate("1");
		List<Giftcardamountpara> amountparalist = giftcardamountparaDao.queryByList(amountparaForm);
		
		form.setAmountparalist(amountparalist);
		
		
		return "giftcard/findGiftcardList";
	}
	
	/**
	 * 添加用户信息初始化
	 * @return
	 */
	@RequestMapping(value="/addInit")
	public String addInit(Giftcard form) {
		//初始化批次号
		if(StringUtils.isEmpty(form.getBatchno())){
			form.setBatchno(Tools.getCurrentTimeByFormat("yyyyMMdd"));
		}
		
		// 构建面额参数LIST
		Giftcardamountpara amountparaForm = new Giftcardamountpara();
		amountparaForm.setQuerystate("1");
		List<Giftcardamountpara> amountparalist = giftcardamountparaDao.queryByList(amountparaForm);
		
		form.setAmountparalist(amountparalist);
		
		return "giftcard/addGiftcard";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public String save(Giftcard form){
		//获取运营商ID
		String operators_areaid = systemparaDao.findByCodeStr("operators_areaid").getValue();
		//自动补齐5位，填充0
		operators_areaid = StringUtils.leftPad(operators_areaid, 5, "0");
		//加锁
		synchronized(lock) {
			
			if ("".equals(form.getBatchno())) {
				form.setReturninfo(getMessage("giftcard.batchno.empty"));
				return addInit(form);
			} else if ("".equals(form.getAmountpara())) {
				form.setReturninfo(getMessage("giftcard.amountpara.empty"));
				return addInit(form);
			}  else if (form.getNumber() == null) {
				form.setReturninfo(getMessage("giftcard.number.empty"));
				return addInit(form);
			} else {
				Giftcardamountpara giftcardamountpara = giftcardamountparaDao.findByParakey(form.getAmountpara());
				if(giftcardamountpara == null){
					giftcardamountpara = new Giftcardamountpara();
				}
				//数据库存在最大的充值卡号
				DecimalFormat serialnoformatter = new DecimalFormat("000000");
				String maxSerialno = giftcardDao.findMaxSerialno(form);
				String currectSerialno = "000001";//默认序列号
				if(StringUtils.isNotEmpty(maxSerialno)){
					currectSerialno = serialnoformatter.format(1 + Integer.parseInt(maxSerialno));
				}
				
				//保存数据库的充值卡列表
				ArrayList<Giftcard> giftcardlist = new ArrayList<Giftcard>();
				for (int i = 0; i < form.getNumber(); i++) {
					Integer serialnoInt = Integer.parseInt(currectSerialno) + i;//自增加的序列号
					String serialnoStr = serialnoformatter.format(serialnoInt);
					//修改增加与运营商ID
					String giftcardno = operators_areaid + form.getBatchno() + form.getAmountpara() + serialnoStr;
					Giftcard giftcard = new Giftcard();
					giftcard.setGiftcardno(giftcardno);
					//获取随机密码
					String password = Tools.getRandomPass(6,("0123456789").toCharArray());
					//通过AES加密
					String passwordEncrypt = AesSecret.aesEncrypt(password, AesSecret.key);
					giftcard.setPassword(passwordEncrypt);
					giftcard.setBatchno(form.getBatchno());
					giftcard.setSerialno(serialnoStr);
					giftcard.setAmount(giftcardamountpara.getAmount());
					giftcard.setAmountpara(form.getAmountpara());
					giftcard.setPrice(form.getPrice());
					giftcard.setState("1");
					giftcard.setPrintflag("0");
					giftcard.setUsedflag("0");
					giftcard.setAddtime(Tools.getCurrentTime());
					giftcardlist.add(giftcard);
					
				}
				giftcardDao.saveBatch(giftcardlist);
			}
			form.setReturninfo(getMessage("page.execution.success"));
			return addInit(form);
		} 
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value="/updateInit")
	public String updateInit(Giftcard form){
		
		form.setGiftcard(giftcardDao.findById(form.getId()));
		
		return "giftcard/updateGiftcard";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public String update(Giftcard form){
		Giftcard oldGiftcard = giftcardDao.findById(form.getId());
		oldGiftcard.setState(form.getState());
        //修改信息
		Integer id = giftcardDao.update(form);
		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public String delete(Giftcard form) {
		// 删除网络，实际上就是修改state为0-无效
		Giftcard giftcarddmp = giftcardDao.findById(form.getId());
		giftcarddmp.setState("0");
		giftcardDao.update(giftcarddmp);
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
	
	/**
	 * 导出礼品卡
	 */
	@RequestMapping(value = "/exportGiftcardForExcel")
	public String exportGiftcardForExcel(Giftcard form, HttpServletResponse response) throws Exception {
		
		List<Giftcard> list = giftcardDao.queryByList(form);
		if (list != null) {
			for (Giftcard giftcard : list) {
				// 构建填充EXCEL文件所需资源包括数据库数据和国际化字段
				Map<String, String> excelmap = new HashMap<String, String>();
				// 初始化国际化表头以及对应的表值
				//充值卡号
				excelmap.put(getMessage("giftcard.giftcardno"), giftcard.getGiftcardno());
				//加密的密码
				String enpassword = giftcard.getPassword();
				//解密的密码
				String passwordDecrypt = AesSecret.aesDecrypt(enpassword, AesSecret.key);
				//解密的密码
				excelmap.put(getMessage("giftcard.password"), passwordDecrypt);
				//充值卡面额
				excelmap.put(getMessage("giftcard.amount"), giftcard.getAmount().toString());
				giftcard.setExcelMap(excelmap);
			}
			
			//封装数据
			form.setGiftcardlist(list);
			
			String[] columntitle = { getMessage("giftcard.giftcardno"), getMessage("giftcard.password"), getMessage("giftcard.amount") };
			form.setReturninfo(ExportExcel.resultSetToExcel(form, columntitle, "GiftcardReport_giftcard", response));
		}
		return null;
	}
	
}
