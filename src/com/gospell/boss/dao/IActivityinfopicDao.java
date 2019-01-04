package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Activityinfo;
import com.gospell.boss.po.Activityinfopic;

/**
 * 数据层接口
 */
public interface IActivityinfopicDao {
	
	/**
	 * 添加
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer save(Activityinfopic form);
	
	/**
	 * 更新
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer update(Activityinfopic form);
	
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
	 * @param Activityinfo
	 * @return
	 */
	public List<Activityinfopic> findByList(Activityinfopic form);
	
	/**
	 * 全部查询
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public List<Activityinfopic> queryByList(Activityinfopic form);
	
	/**
	 * 分页总数
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer findByCount(Activityinfopic form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Activityinfopic findById(Integer id);
	
	/**
	 * 全部查询，通过活动信息ID
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public List<Activityinfopic> findPicListByActivityinfoid(Integer activityinfoid);
    
	/**
	 * 查询活动的图片个数
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer findActivityinfopicCount(Integer activityinfoid);
}
