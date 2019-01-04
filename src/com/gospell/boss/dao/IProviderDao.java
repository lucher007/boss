package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Provider;

/**
 * 数据层接口
 */
public interface IProviderDao {
	
	/**
	 * 供应商添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Provider form);
	
	/**
	 * 供应商更新
	 * 
	 * @param Provider
	 * @return
	 */
	public Integer update(Provider form);
	
	/**
	 * 供应商删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 供应商分页查询
	 * 
	 * @param Provider
	 * @return
	 */
	public List<Provider> findByList(Provider form);
	
	/**
	 * 供应商全部查询
	 * 
	 * @param Provider
	 * @return
	 */
	public List<Provider> queryByList(Provider form);
	
	/**
	 * 供应商分页总数
	 * 
	 * @param Provider
	 * @return
	 */
	public Integer findByCount(Provider form);
	
	/**
	 * 供应商查询根据ID
	 * 
	 * @param Provider
	 * @return
	 */
	public Provider findById(Integer id);
	
	/**
	 * 供应商查询根据供应商公司名称
	 * 
	 * @param Provider
	 * @return
	 */
	public Provider findByCompanyname(Provider form);
	
	/**
	 * 供应商查询根据型号
	 * 
	 * @param Provider
	 * @return
	 */
	public Provider findByModel(Provider form);
	
}
