package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Dispatch;;


/**
 * 数据层接口
 */
public interface IDispatchDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Dispatch form);
	
	/**
	 * 更新
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Integer update(Dispatch form);
	
	/**
	 * 派发工单
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Integer saveAssign(Dispatch form);
	
	/**
	 * 更新回单信息
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Integer updateReturnInfo(Dispatch form);
	
	/**
	 * 更新状态信息
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Integer updateState(Dispatch form);
	
	
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
	 * @param Dispatch
	 * @return
	 */
	public List<Dispatch> findByList(Dispatch form);
	
	/**
	 * 全部查询
	 * 
	 * @param Dispatch
	 * @return
	 */
	public List<Dispatch> queryByList(Dispatch form);
	
	
	
	/**
	 * 分页总数
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Integer findByCount(Dispatch form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Dispatch findById(Integer id);
	
	
	/**
	 * 查询根据userID
	 * 
	 * @param Dispatch
	 * @return
	 */
	public List<Dispatch> findByUserid(Integer userid);
	
	/**
	 * 查询根据dispatcherID
	 * 
	 * @param Dispatch
	 * @return
	 */
	public List<Dispatch> findByDispatherid(Integer dispatcherid);
	
	
	
	/**
	 * 查询根据complaintId
	 * 
	 * @param Dispatch
	 * @return
	 */
	public Dispatch findByComplaintid(Integer complaintid);
	
	

		
	
}
