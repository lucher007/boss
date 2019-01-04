package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Package;

/**
 * 数据层接口
 */
public interface IPackageDao {
	
	/**
	 * 添加
	 * 
	 * @param Package
	 * @return
	 */
	public Integer save(Package form);
	
	/**
	 * 更新
	 * 
	 * @param Package
	 * @return
	 */
	public Integer update(Package form);
	
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
	 * @param Package
	 * @return
	 */
	public List<Package> findByList(Package form);
	
	/**
	 * 全部查询
	 * 
	 * @param Package
	 * @return
	 */
	public List<Package> queryByList(Package form);
	
	/**
	 * 分页总数
	 * 
	 * @param Package
	 * @return
	 */
	public Integer findByCount(Package form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Package
	 * @return
	 */
	public Package findById(Integer id);
	
}
