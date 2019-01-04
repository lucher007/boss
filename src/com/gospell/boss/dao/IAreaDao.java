package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Area;
import com.gospell.boss.po.Server;

/**
 * 数据层接口
 */
public interface IAreaDao {
	
	/**
	 * 区域添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Area form);
	
	/**
	 * 区域更新
	 * 
	 * @param Area
	 * @return
	 */
	public Integer update(Area form);
	
	/**
	 * 区域删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 区域分页查询
	 * 
	 * @param Area
	 * @return
	 */
	public List<Area> findByList(Area form);
	
	/**
	 * 根区域分页查询
	 * 
	 * @param Area
	 * @return
	 */
	public List<Area> findRootArea(Area form);

	
	/**
	 * 区域全部查询
	 * 
	 * @param Area
	 * @return
	 */
	public List<Area> queryByList(Area form);
	
	/**
	 * 区域分页总数
	 * 
	 * @param Area
	 * @return
	 */
	public Integer findByCount(Area form);
	
	/**
	 * 区域查询根据ID
	 * 
	 * @param Area
	 * @return
	 */
	public Area findById(Integer id);
	
	/**
	 * 区域查询根据PID
	 * 
	 * @param Area
	 * @return
	 */
	public List<Area> findByPid(Integer pid);
	
	/**
	 * 区域查询根据区域编号
	 * 
	 * @param Area
	 * @return
	 */
	public Area findByAreacode(Area form);
	
	/**
	 * 区域查询根据cas分区号
	 * 
	 * @param Area
	 * @return
	 */
	public Area findByRemark(Area form);
	/**
	 * 查询区域根据前端服务器
	 * 
	 * @param Server
	 * @return
	 */
	public List<Server> findServerListByNetid(Server form);
	
	/**
	 * 查询父亲根据区域
	 * 
	 * @param Server
	 * @return
	 */
	public List<Area> queryListByPid(Area form);
	
	/**
	 * 区域批量删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteBatchByCode(Area form);
	
}
