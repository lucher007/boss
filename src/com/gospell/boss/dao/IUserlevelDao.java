package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Userlevel;

/**
 * 数据层接口
 */
public interface IUserlevelDao {
	
	/**
	 * 添加
	 * 
	 * @param Userlevel
	 * @return
	 */
	public Integer save(Userlevel form);
	
	/**
	 * 更新
	 * 
	 * @param Userlevel
	 * @return
	 */
	public Integer update(Userlevel form);
	
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
	 * @param Userlevel
	 * @return
	 */
	public List<Userlevel> findByList(Userlevel form);
	
	/**
	 * 全部查询
	 * 
	 * @param Userlevel
	 * @return
	 */
	public List<Userlevel> queryByList(Userlevel form);
	
	/**
	 * 分页总数
	 * 
	 * @param Userlevel
	 * @return
	 */
	public Integer findByCount(Userlevel form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Userlevel
	 * @return
	 */
	public Userlevel findById(Integer id);
	
	/**
	 * 查询根据级别名称
	 * 
	 * @param Userlevel
	 * @return
	 */
	public Userlevel findByLevelname(String levelname);
	
}
