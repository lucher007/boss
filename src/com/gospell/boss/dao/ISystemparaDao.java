package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Systempara;

/**
 * 数据层接口
 */
public interface ISystemparaDao {
	
	/**
	 *  系统参数添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Systempara form);
	
	/**
	 *  系统参数更新
	 * 
	 * @param Systempara
	 * @return
	 */
	public Integer update(Systempara form);
	
	/**
	 *  系统参数删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 *  系统参数分页查询
	 * 
	 * @param Systempara
	 * @return
	 */
	public List<Systempara> findByList(Systempara form);
	
	/**
	 *  系统参数全部查询
	 * 
	 * @param Systempara
	 * @return
	 */
	public List<Systempara> queryByList(Systempara form);
	
	/**
	 *  系统参数分页总数
	 * 
	 * @param Systempara
	 * @return
	 */
	public Integer findByCount(Systempara form);
	
	/**
	 *  系统参数查询根据ID
	 * 
	 * @param Systempara
	 * @return
	 */
	public Systempara findById(Integer id);
	
	/**
	 *  系统参数查询根据 系统参数编号
	 * 
	 * @param Systempara
	 * @return
	 */
	public Systempara findByCode(Systempara form);
	
	/**
	 *  系统参数查询根据 系统参数编号
	 * 
	 * @param Systempara
	 * @return
	 */
	public Systempara findByCodeStr(String code);
	
}
