package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Businesstype;

/**
 * 数据层接口
 */
public interface IBusinesstypeDao {
	
	/**
	 * 业务类型添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Businesstype form);
	
	/**
	 * 业务类型更新
	 * 
	 * @param Businesstype
	 * @return
	 */
	public Integer update(Businesstype form);
	
	/**
	 * 业务类型删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 业务类型分页查询
	 * 
	 * @param Businesstype
	 * @return
	 */
	public List<Businesstype> findByList(Businesstype form);
	
	/**
	 * 业务类型全部查询
	 * 
	 * @param Businesstype
	 * @return
	 */
	public List<Businesstype> queryByList(Businesstype form);
	
	/**
	 * 业务类型分页总数
	 * 
	 * @param Businesstype
	 * @return
	 */
	public Integer findByCount(Businesstype form);
	
	/**
	 * 业务类型查询根据ID
	 * 
	 * @param Businesstype
	 * @return
	 */
	public Businesstype findById(Integer id);
	
	/**
	 * 业务类型查询根据typekey
	 * 
	 * @param Businesstype
	 * @return
	 */
	public Businesstype findByTypekey(Businesstype form);
	
	/**
	 * 业务类型查询根据typekey
	 * 
	 * @param Businesstype
	 * @return
	 */
	public Businesstype findByTypekeyStr(String typekey);
}
