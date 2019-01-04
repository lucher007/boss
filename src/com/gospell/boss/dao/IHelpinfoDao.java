package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Helpinfo;

/**
 * 数据层接口
 */
public interface IHelpinfoDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Helpinfo form);
	
	/**
	 * 更新
	 * 
	 * @param Helpinfo
	 * @return
	 */
	public Integer update(Helpinfo form);
	
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
	 * @param Helpinfo
	 * @return
	 */
	public List<Helpinfo> findByList(Helpinfo form);
	
	/**
	 * 全部查询
	 * 
	 * @param Helpinfo
	 * @return
	 */
	public List<Helpinfo> queryByList(Helpinfo form);
	
	/**
	 * 分页总数
	 * 
	 * @param Helpinfo
	 * @return
	 */
	public Integer findByCount(Helpinfo form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Helpinfo
	 * @return
	 */
	public Helpinfo findById(Integer id);
	
}
