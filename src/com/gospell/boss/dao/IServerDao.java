package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Server;

/**
 * 数据层接口
 */
public interface IServerDao {
	
	/**
	 * 前端服务器添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Server form);
	
	/**
	 * 前端服务器更新
	 * 
	 * @param Server
	 * @return
	 */
	public Integer update(Server form);
	
	/**
	 * 前端服务器删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 前端服务器分页查询
	 * 
	 * @param Server
	 * @return
	 */
	public List<Server> findByList(Server form);
	
	/**
	 * 前端服务器全部查询
	 * 
	 * @param Server
	 * @return
	 */
	public List<Server> queryByList(Server form);
	
	/**
	 * 前端服务器分页总数
	 * 
	 * @param Server
	 * @return
	 */
	public Integer findByCount(Server form);
	
	/**
	 * 前端服务器查询根据ID
	 * 
	 * @param Server
	 * @return
	 */
	public Server findById(Integer id);
	
	/**
	 * 前端服务器查询根据服务器名称
	 * 
	 * @param Server
	 * @return
	 */
	public Server findByServername(Server form);
	
	/**
	 * 前端服务器查询根据网络和服务器版本类型
	 * 
	 * @param Server
	 * @return
	 */
	public Server findByServertypeAndVersiontype(Server form);
	
	
}
