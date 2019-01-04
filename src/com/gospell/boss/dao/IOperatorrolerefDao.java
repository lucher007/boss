package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;

import com.gospell.boss.po.Operatorroleref;
import com.gospell.boss.po.Role;
import com.gospell.boss.po.Stb;

/**
 * 数据层接口
 */
public interface IOperatorrolerefDao {
	
	/**
	 * 区域添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Operatorroleref form);
	
	/**
	 * 区域更新
	 * 
	 * @param Operatorroleref
	 * @return
	 */
	public Integer update(Operatorroleref form);
	
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
	 * @param Operatorroleref
	 * @return
	 */
	public List<Operatorroleref> findByList(Operatorroleref form);
	
	/**
	 * 区域全部查询
	 * 
	 * @param Operatorroleref
	 * @return
	 */
	public List<Operatorroleref> queryByList(Operatorroleref form);
	
	/**
	 * 区域分页总数
	 * 
	 * @param Operatorroleref
	 * @return
	 */
	public Integer findByCount(Operatorroleref form);
	
	/**
	 * 区域查询根据ID
	 * 
	 * @param Operatorroleref
	 * @return
	 */
	public Operatorroleref findById(Integer id);

	/**
	 * 区域查询根据ID
	 * 
	 * @param Operatorroleref
	 * @return
	 */
	public List<Operatorroleref> findByRoleid(Integer roleid);
	
	/**
	 * 区域查询根据ID
	 * 
	 * @param Operatorroleref
	 * @return
	 */
	public Operatorroleref findByOperatorid(Integer id);


	
	
	
}
