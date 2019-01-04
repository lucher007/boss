package com.gospell.boss.dao;


import java.util.List;

import com.gospell.boss.po.Operator;

/**
 * 用户数据层接口
 */
public interface IOperatorDao {
	/**
	 * 操作员添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Operator form);
	
	/**
	 * 操作员更新
	 * 
	 * @param Operator
	 * @return
	 */
	public Integer update(Operator form);
	
	/**
	 * 操作员删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 操作员分页查询
	 * 
	 * @param Operator
	 * @return
	 */
	public List<Operator> findByList(Operator form);
	
	/**
	 * 操作员全部查询
	 * 
	 * @param Operator
	 * @return
	 */
	public List<Operator> queryByList(Operator form);
	
	/**
	 * 操作员分页总数
	 * 
	 * @param Operator
	 * @return
	 */
	public Integer findByCount(Operator form);
	
	/**
	 * 操作员查询根据ID
	 * 
	 * @param Operator
	 * @return
	 */
	public Operator findById(Integer id);
	
	/**
	 * 查询根据多种信息
	 * 
	 * @param Operator
	 * @return
	 */
	public Operator findByAnyInfo(Operator form);
	
	
	/**
	 * 操作员查询根据操作员登录名称
	 * 
	 * @param Operator
	 * @return
	 */
	public Operator findByLoginname(Operator form);
	
	/**
	 * 操作员修改登录密码
	 * 
	 * @param Operator
	 * @return
	 */
	public Integer updatePassword(Operator form);
	
	
	/**
	 * 操作员分页查询-页面按照旧版分页查询（不是easyui分页）
	 * 
	 * @param Operator
	 * @return
	 */
	public List<Operator> findByListForOldPage(Operator form);
}
