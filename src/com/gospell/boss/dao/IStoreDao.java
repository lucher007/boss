package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Store;

/**
 * 数据层接口
 */
public interface IStoreDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Store form);
	
	/**
	 * 更新
	 * 
	 * @param Store
	 * @return
	 */
	public Integer update(Store form);
	
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
	 * @param Store
	 * @return
	 */
	public List<Store> findByList(Store form);
	
	/**
	 * 全部查询
	 * 
	 * @param Store
	 * @return
	 */
	public List<Store> queryByList(Store form);
	
	/**
	 * 分页总数
	 * 
	 * @param Store
	 * @return
	 */
	public Integer findByCount(Store form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Store
	 * @return
	 */
	public Store findById(Integer id);
	
	/**
	 * 查询根据营业厅编号
	 * 
	 * @param Store
	 * @return
	 */
	public Store findByStorecode(Store form);
	
	
}
