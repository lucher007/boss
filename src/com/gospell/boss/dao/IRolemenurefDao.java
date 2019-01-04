package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Role;
import com.gospell.boss.po.Rolemenuref;
import com.gospell.boss.po.Stb;

/**
 * 数据层接口
 */
public interface IRolemenurefDao {
	
	/**
	 * 区域添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Rolemenuref form);
	
	/**
	 * 区域更新
	 * 
	 * @param Rolemenuref
	 * @return
	 */
	public Integer update(Rolemenuref form);
	
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
	 * @param Rolemenuref
	 * @return
	 */
	public List<Rolemenuref> findByList(Rolemenuref form);
	
	/**
	 * 区域全部查询
	 * 
	 * @param Rolemenuref
	 * @return
	 */
	public List<Rolemenuref> queryByList(Rolemenuref form);
	
	/**
	 * 区域分页总数
	 * 
	 * @param Rolemenuref
	 * @return
	 */
	public Integer findByCount(Rolemenuref form);
	
	/**
	 * 区域查询根据ID
	 * 
	 * @param Rolemenuref
	 * @return
	 */
	public Rolemenuref findById(Integer id);
	
	/**
	 * @param roleid
	 * @return
	 */
	public List<Rolemenuref> findByRoleid(Integer roleid);
	

	/**
	 * 批量导入
	 * @param Rolemenuref
	 * @return
	 */
	public Integer saveBatch(ArrayList<Rolemenuref>reflist);
	
	
	/**
	 * 区域删除
	 * 
	 * @param id
	 * @return
	 */
	public  Integer deleteByRoleid(Integer roleid);
	
	
	
}
