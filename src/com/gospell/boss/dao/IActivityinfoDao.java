package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Activityinfo;

/**
 * 数据层接口
 */
public interface IActivityinfoDao {
	
	/**
	 * 添加
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer save(Activityinfo form);
	
	/**
	 * 更新
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer update(Activityinfo form);
	
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
	public List<Activityinfo> findByList(Activityinfo form);
	
	/**
	 * 全部查询
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public List<Activityinfo> queryByList(Activityinfo form);
	
	/**
	 * 分页总数
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Integer findByCount(Activityinfo form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Activityinfo
	 * @return
	 */
	public Activityinfo findById(Integer id);
	
	/**
	 * 查询根据title
	 * 
	 * @param String
	 * @return
	 */
	public Activityinfo findByStr(String title);
	
}
