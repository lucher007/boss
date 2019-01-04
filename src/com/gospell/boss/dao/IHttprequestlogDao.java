package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Httprequestlog;

/**
 * 数据层接口
 */
public interface IHttprequestlogDao {
	
	/**
	 * 新邮件添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Httprequestlog form);
	
	/**
	 * 更新
	 * 
	 * @param Httprequestlog
	 * @return
	 */
	public Integer update(Httprequestlog form);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 分页查询
	 * 
	 * @param Httprequestlog
	 * @return
	 */
	public List<Caspnnewemail> findByList(Httprequestlog form);
	
	/**
	 * 全部查询
	 * 
	 * @param Httprequestlog
	 * @return
	 */
	public List<Caspnnewemail> queryByList(Httprequestlog form);
	
	/**
	 * 分页总数
	 * 
	 * @param Httprequestlog
	 * @return
	 */
	public Integer findByCount(Httprequestlog form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Httprequestlog
	 * @return
	 */
	public Caspnnewemail findById(Integer id);
	
}
