package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnblackcard;

/**
 * 数据层接口
 */
public interface ICaspnblackcardDao {
	
	/**
	 * 智能卡黑名单添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnblackcard form);
	
	/**
	 * 智能卡黑名单更新
	 * 
	 * @param Caspnblackcard
	 * @return
	 */
	public Integer update(Caspnblackcard form);
	
	/**
	 * 智能卡黑名单删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 智能卡黑名单分页查询
	 * 
	 * @param Caspnblackcard
	 * @return
	 */
	public List<Caspnblackcard> findByList(Caspnblackcard form);
	
	/**
	 * 智能卡黑名单全部查询
	 * 
	 * @param Caspnblackcard
	 * @return
	 */
	public List<Caspnblackcard> queryByList(Caspnblackcard form);
	
	/**
	 * 智能卡黑名单分页总数
	 * 
	 * @param Caspnblackcard
	 * @return
	 */
	public Integer findByCount(Caspnblackcard form);
	
	
	/**
	 * 根据REMARK中存的STBID和CARDID来查询
	 * 
	 * @param Caspnblackcard
	 * @return
	 */
	public Caspnblackcard findByRemark(Caspnblackcard blackStbRemark);
	
	/**
	 * 智能卡黑名单查询根据ID
	 * 
	 * @param Caspnblackcard
	 * @return
	 */
	public Caspnblackcard findById(Integer id);
	
	
	/**
	 * 智能卡黑名单删除根据智能卡号
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteByCardid(Caspnblackcard blackStbRemark);
}
