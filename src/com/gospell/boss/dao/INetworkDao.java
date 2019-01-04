package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Network;

/**
 * 数据层接口
 */
public interface INetworkDao {
	
	/**
	 * 网络添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Network form);
	
	/**
	 * 网络更新
	 * 
	 * @param Network
	 * @return
	 */
	public Integer update(Network form);
	
	/**
	 * 网络删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 网络分页查询
	 * 
	 * @param Network
	 * @return
	 */
	public List<Network> findByList(Network form);
	
	/**
	 * 网络全部查询
	 * 
	 * @param Network
	 * @return
	 */
	public List<Network> queryByList(Network form);
	
	/**
	 * 网络分页总数
	 * 
	 * @param Network
	 * @return
	 */
	public Integer findByCount(Network form);
	
	/**
	 * 网络查询根据ID
	 * 
	 * @param Network
	 * @return
	 */
	public Network findById(Integer id);
	
	/**
	 * 网络查询根据网络ID
	 * 
	 * @param Network
	 * @return
	 */
	public Network findByNetid(Network form);
	
	/**
	 * 网络更新CODE
	 * 
	 * @param Network
	 * @return
	 */
	public Integer updateCode(Network network);
	
	/**
	 * 网络树形结构查询
	 * @param network
	 * @return
	 */
	public List<Network> findByTree(Network network);
	
	/**
	 * 根据PID查询网络
	 * 
	 * @param pid
	 * @return
	 */
	public List<Network> queryListByPid(Integer pid);
}
