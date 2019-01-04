package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnforcedosd;

/**
 * 数据层接口
 */
public interface ICaspnforcedosdDao {
	
	/**
	 * 强制OSD添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnforcedosd form);
	
	/**
	 * 强制OSD更新
	 * 
	 * @param Caspnforcedosd
	 * @return
	 */
	public Integer update(Caspnforcedosd form);
	
	/**
	 * 强制OSD删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 强制OSD分页查询
	 * 
	 * @param Caspnforcedosd
	 * @return
	 */
	public List<Caspnforcedosd> findByList(Caspnforcedosd form);
	
	/**
	 * 强制OSD全部查询
	 * 
	 * @param Caspnforcedosd
	 * @return
	 */
	public List<Caspnforcedosd> queryByList(Caspnforcedosd form);
	
	/**
	 * 强制OSD分页总数
	 * 
	 * @param Caspnforcedosd
	 * @return
	 */
	public Integer findByCount(Caspnforcedosd form);
	
	/**
	 * 强制OSD查询根据ID
	 * 
	 * @param Caspnforcedosd
	 * @return
	 */
	public Caspnforcedosd findById(Integer id);
	
}
