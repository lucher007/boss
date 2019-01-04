package com.gospell.boss.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gospell.boss.dao.INetworkDao;
import com.gospell.boss.dao.IProductDao;
import com.gospell.boss.dao.IUserDao;
import com.gospell.boss.dao.IUserlevelDao;
import com.gospell.boss.dao.IUserlevelproductDao;
import com.gospell.boss.po.Network;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productserviceref;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userlevel;
import com.gospell.boss.po.Userlevelproduct;

/**
 * 用户等级控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/userlevel")
@Transactional
public class UserlevelController extends BaseController {

	@Autowired
	private ServletContext servletContext;
	@Autowired
	private IUserlevelDao userlevelDao;
	@Autowired
	private IUserlevelproductDao userlevelproductDao;
	@Autowired
	private IProductDao productDao;
	@Autowired
	private IUserDao userDao;
	@Autowired
	private INetworkDao networkDao;
	

	/**
	 * 查询用户等级信息
	 */
	@RequestMapping(value = "/findByList")
	public String findByList(Userlevel form) {
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(userlevelDao.findByCount(form));
		List<Userlevel> userlevellist = userlevelDao.findByList(form);
		form.setUserlevellist(userlevellist);
		return "userlevel/findUserlevelList";
	}

	/**
	 * 添加用户等级信息初始化
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addInit")
	public String addInit(Userlevel form) {
		return "userlevel/addUserlevel";
	}
	
	
	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	public String save(Userlevel form) {
		if ("".equals(form.getLevelname())) {
			form.setReturninfo(getMessage("userlevel.levelname.empty"));
			return addInit(form);
		} else {
			Userlevel oldUserlevel = userlevelDao.findByLevelname(form.getLevelname());
			if (oldUserlevel != null) {
				form.setReturninfo(getMessage("userlevel.levelname.existed"));
				return addInit(form);
			}
		}
		
		Integer userlevelid = userlevelDao.save(form);

		//修改订单关联的产品信息
		String productJson = form.getProductJson();
		JSONArray productJsonArry = JSONArray.fromObject(productJson);
		for (int i = 0; i < productJsonArry.size(); i++){
            JSONObject userproductJsonObject = productJsonArry.getJSONObject(i);
            String netid = userproductJsonObject.getString("netid");
            String productid = userproductJsonObject.getString("productid");
			String pricepermonth = userproductJsonObject.getString("pricepermonth");
			String priceperday = userproductJsonObject.getString("priceperday");
			String subpricepermonth = userproductJsonObject.getString("subpricepermonth");
			String subpriceperday = userproductJsonObject.getString("subpriceperday");
			if(StringUtils.isEmpty(pricepermonth)){
				pricepermonth = "0";
			}
			
			if(StringUtils.isEmpty(priceperday)){
				priceperday = "0";
			}
			if(StringUtils.isEmpty(subpricepermonth)){
				subpricepermonth = "0";
			}
			
			if(StringUtils.isEmpty(subpriceperday)){
				subpriceperday = "0";
			}
			
			//修改订单的产品标识
			Userlevelproduct userlevelproduct = new Userlevelproduct();
			userlevelproduct.setUserlevelid(form.getId());
			userlevelproduct.setNetid(Integer.parseInt(netid));
			userlevelproduct.setProductid(productid);
			userlevelproduct.setPricepermonth(new BigDecimal(pricepermonth));
			userlevelproduct.setPriceperday(new BigDecimal(priceperday));
			userlevelproduct.setSubpricepermonth(new BigDecimal(subpricepermonth));
			userlevelproduct.setSubpriceperday(new BigDecimal(subpriceperday));
			userlevelproductDao.save(userlevelproduct);
		}
		
		form.setReturninfo(getMessage("page.execution.success"));
		return addInit(form);
	}

	
	
	/**
	 * 查询订单产品信息Json
	 */
	@ResponseBody
	@RequestMapping(value = "/findUserlevelproductListJson")
	public Map<String, Object> findUserlevelproductListJson(Userlevel form) {
		//封装JSon的Map
		Map<String, Object> result = new HashMap<String, Object>(); 
		
		List<HashMap<String, Object>> objectlist = new ArrayList<HashMap<String, Object>>();
		
		
		Integer total = productDao.findByCount(new Product());
		List<Product> productlist = productDao.queryByList(new Product());
		
		Userlevelproduct userlevelproductform = new Userlevelproduct();
		userlevelproductform.setUserlevelid(form.getId());
		List<Userlevelproduct> userlevelproductlist = userlevelproductDao.queryByList(userlevelproductform);
		
		for (Product product : productlist) {
			HashMap<String, Object> objectMap = new HashMap<String, Object>();
			//产品信息
			objectMap.put("id", product.getId());
			objectMap.put("netid", product.getNetid());
			Network network = networkDao.findById(product.getNetid());
			if(network == null){
				network = new Network();
			}
			objectMap.put("netname", network.getNetname());
			objectMap.put("productid", product.getProductid());
			objectMap.put("productname", product.getProductname());
			objectMap.put("pricepermonth", product.getPricepermonth());
			objectMap.put("priceperday", product.getPriceperday());
			objectMap.put("subpricepermonth", product.getSubpricepermonth());
			objectMap.put("subpriceperday", product.getSubpriceperday());
			for (Userlevelproduct userlevelproduct : userlevelproductlist) {
				if((userlevelproduct.getNetid() == product.getNetid()) && (userlevelproduct.getProductid().equals(product.getProductid()))){
					objectMap.put("checkedFlag", "1");//默认选中
					objectMap.put("pricepermonth", userlevelproduct.getPricepermonth());
					objectMap.put("priceperday", userlevelproduct.getPriceperday());
					objectMap.put("subpricepermonth", userlevelproduct.getSubpricepermonth());
					objectMap.put("subpriceperday", userlevelproduct.getSubpriceperday());
				}
			}
			
			objectlist.add(objectMap);
			
		}
		
		result.put("total", total);//页面总数
		result.put("rows", objectlist);
		return result;
	}
	
	/**
	 * 更新初始化
	 */
	@RequestMapping(value = "/updateInit")
	public String updateInit(Userlevel form) {

		form.setUserlevel(userlevelDao.findById(form.getId()));

		return "userlevel/updateUserlevel";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update")
	public String update(Userlevel form) {

		if ("".equals(form.getLevelname())) {
			form.setReturninfo(getMessage("userlevel.levelname.empty"));
			return updateInit(form);
		} else {
			Userlevel oldUserlevel = userlevelDao.findByLevelname(form.getLevelname());
			if (oldUserlevel != null && !oldUserlevel.getId().equals(form.getId())) {
				form.setReturninfo(getMessage("userlevel.levelname.existed"));
				return updateInit(form);
			}
		}

		// 修改网络信息
		userlevelDao.update(form);
		
		//删除关联的旧产品信息
		userlevelproductDao.deleteByUserlevelid(form.getId());
		
		//修改关联的产品信息
		String productJson = form.getProductJson();
		JSONArray productJsonArry = JSONArray.fromObject(productJson);
		for (int i = 0; i < productJsonArry.size(); i++){
            JSONObject userproductJsonObject = productJsonArry.getJSONObject(i);
            String netid = userproductJsonObject.getString("netid");
            String productid = userproductJsonObject.getString("productid");
			String pricepermonth = userproductJsonObject.getString("pricepermonth");
			String priceperday = userproductJsonObject.getString("priceperday");
			String subpricepermonth = userproductJsonObject.getString("subpricepermonth");
			String subpriceperday = userproductJsonObject.getString("subpriceperday");
			if(StringUtils.isEmpty(pricepermonth)){
				pricepermonth = "0";
			}
			if(StringUtils.isEmpty(priceperday)){
				priceperday = "0";
			}
			if(StringUtils.isEmpty(subpricepermonth)){
				subpricepermonth = "0";
			}
			if(StringUtils.isEmpty(subpriceperday)){
				subpriceperday = "0";
			}
			//修改订单的产品标识
			Userlevelproduct userlevelproduct = new Userlevelproduct();
			userlevelproduct.setUserlevelid(form.getId());
			userlevelproduct.setNetid(Integer.parseInt(netid));
			userlevelproduct.setProductid(productid);
			userlevelproduct.setPricepermonth(new BigDecimal(pricepermonth));
			userlevelproduct.setPriceperday(new BigDecimal(priceperday));
			userlevelproduct.setSubpricepermonth(new BigDecimal(subpricepermonth));
			userlevelproduct.setSubpriceperday(new BigDecimal(subpriceperday));
			userlevelproductDao.save(userlevelproduct);
		}
		

		form.setReturninfo(getMessage("page.execution.success"));
		return updateInit(form);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public String delete(Userlevel form) {
		
		Userlevel userlevel = userlevelDao.findById(form.getId());
		
		//查询该订户级别下有没有订户
		User userForm = new User();
		userForm.setQueryuserlevelid(String.valueOf(form.getId()));
		List<User> userList = userDao.queryByList(userForm);
		
		if(userList != null && userList.size() > 0){
			form.setReturninfo(getMessage("userlevel.delete.userexisted"));
			return findByList(form);
		}
		
		// 删除该级别
		userlevelDao.delete(form.getId());
        
		// 删除原来关联的产品
		userlevelproductDao.deleteByUserlevelid(form.getId());
		
		form.setReturninfo(getMessage("page.execution.success"));
		return findByList(form);
	}
}
