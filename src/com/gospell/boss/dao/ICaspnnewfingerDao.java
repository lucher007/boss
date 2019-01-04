package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnnewfinger;

/**
 * 数据层接口
 */
public interface ICaspnnewfingerDao {
	
	/**
	 * 新指纹添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnnewfinger form);
	
	/**
	 * 新指纹更新
	 * 
	 * @param Caspnnewfinger
	 * @return
	 */
	public Integer update(Caspnnewfinger form);
	
	/**
	 * 新指纹删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 新指纹分页查询
	 * 
	 * @param Caspnnewfinger
	 * @return
	 */
	public List<Caspnnewfinger> findByList(Caspnnewfinger form);
	
	/**
	 * 新指纹全部查询
	 * 
	 * @param Caspnnewfinger
	 * @return
	 */
	public List<Caspnnewfinger> queryByList(Caspnnewfinger form);
	
	/**
	 * 新指纹分页总数
	 * 
	 * @param Caspnnewfinger
	 * @return
	 */
	public Integer findByCount(Caspnnewfinger form);
	
	/**
	 * 新指纹查询根据ID
	 * 
	 * @param Caspnnewfinger
	 * @return
	 */
	public Caspnnewfinger findById(Integer id);
	
}
