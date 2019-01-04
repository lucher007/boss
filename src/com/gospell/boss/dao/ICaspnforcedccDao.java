package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnforcedcc;

/**
 * 数据层接口
 */
public interface ICaspnforcedccDao {
	
	/**
	 * 强制换台添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnforcedcc form);
	
	/**
	 * 强制换台更新
	 * 
	 * @param Caspnforcedcc
	 * @return
	 */
	public Integer update(Caspnforcedcc form);
	
	/**
	 * 强制换台删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 强制换台分页查询
	 * 
	 * @param Caspnforcedcc
	 * @return
	 */
	public List<Caspnforcedcc> findByList(Caspnforcedcc form);
	
	/**
	 * 强制换台全部查询
	 * 
	 * @param Caspnforcedcc
	 * @return
	 */
	public List<Caspnforcedcc> queryByList(Caspnforcedcc form);
	
	/**
	 * 强制换台分页总数
	 * 
	 * @param Caspnforcedcc
	 * @return
	 */
	public Integer findByCount(Caspnforcedcc form);
	
	/**
	 * 强制换台查询根据ID
	 * 
	 * @param Caspnforcedcc
	 * @return
	 */
	public Caspnforcedcc findById(Integer id);
	
}
