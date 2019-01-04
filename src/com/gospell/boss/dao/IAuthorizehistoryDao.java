package com.gospell.boss.dao;

import java.math.BigInteger;
import java.util.List;

import com.gospell.boss.po.Authorizehistory;

/**
 * 数据层接口
 */
public interface IAuthorizehistoryDao {
    
	/**
	 * 授权历史记录添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Long save(Authorizehistory form);
	
	/**
	 * 授权历史记录更新
	 * 
	 * @param Area
	 * @return
	 */
	public Integer update(Authorizehistory form);
	
	/**
	 * 授权历史记录删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(BigInteger id);
	
	/**
	 * 授权历史记录分页查询
	 * 
	 * @param Authorizehistory
	 * @return
	 */
	public List<Authorizehistory> findByList(Authorizehistory form);

	/**
	 * 授权历史记录分页总数
	 * 
	 * @param Authorizehistory
	 * @return
	 */
	public Integer findByCount(Authorizehistory form);
	
	/**
	 * 清除授权历史记录
	 * 
	 * @param Authorizehistory
	 * @return
	 */
	public Integer deleteAll();
}
