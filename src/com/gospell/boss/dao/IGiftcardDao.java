package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;

import com.gospell.boss.po.Card;
import com.gospell.boss.po.Giftcard;

/**
 * 数据层接口
 */
public interface IGiftcardDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Giftcard form);
	
	/**
	 * 更新
	 * 
	 * @param Giftcard
	 * @return
	 */
	public Integer update(Giftcard form);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 分页查询
	 * 
	 * @param Giftcard
	 * @return
	 */
	public List<Giftcard> findByList(Giftcard form);
	
	/**
	 * 全部查询
	 * 
	 * @param Giftcard
	 * @return
	 */
	public List<Giftcard> queryByList(Giftcard form);
	
	/**
	 * 分页总数
	 * 
	 * @param Giftcard
	 * @return
	 */
	public Integer findByCount(Giftcard form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Giftcard
	 * @return
	 */
	public Giftcard findById(Integer id);
	
	/**
	 * 查询根据充值卡号
	 * 
	 * @param Giftcard
	 * @return
	 */
	public Giftcard findByGiftcardnoStr(String giftcardno);
	
	/**
	 * 查询最大的序列号
	 * 
	 * @param Giftcard
	 * @return
	 */
	public String findMaxSerialno(Giftcard form);
	
	/**
	 * 批量插入
	 * @param Card
	 * @return
	 */
	public Integer saveBatch(ArrayList<Giftcard> giftcardlist);
	
}
