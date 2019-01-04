package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Authorize;

/**
 * 数据层接口
 */
public interface IAuthorizeDao {
    
	/**
	 * 授权记录添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Authorize form);
	
	/**
	 * 授权记录更新
	 * 
	 * @param Area
	 * @return
	 */
	public Integer update(Authorize form);
	
	/**
	 * 授权记录删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 授权记录分页查询
	 * 
	 * @param Authorize
	 * @return
	 */
	public List<Authorize> findByList(Authorize form);

	/**
	 * 授权记录分页总数
	 * 
	 * @param Authorize
	 * @return
	 */
	public Integer findByCount(Authorize form);
	
	/**
	 * 查询普安
	 * 
	 * @param Authorize
	 * @return
	 */
	public List<Authorize> queryByList(Authorize form);
	
	/**
	 *  授权记录批量添加
	 * @param Usercard
	 * @return
	 */
	public void saveBatch(List<Authorize> authorizelist);
	
}
