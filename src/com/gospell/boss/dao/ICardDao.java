package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.Usercard;

/**
 * 数据层接口
 */
public interface ICardDao {
	
	/**
	 * 添加
	 * 
	 * @param Card
	 * @return
	 */
	public Integer save(Card form);
	
	/**
	 * 更新
	 * 
	 * @param Card
	 * @return
	 */
	public Integer update(Card form);
	
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
	 * @param Card
	 * @return
	 */
	public List<Card> findByList(Card form);
	
	/**
	 * 全部查询
	 * 
	 * @param Card
	 * @return
	 */
	public List<Card> queryByList(Card form);
	
	/**
	 * 分页总数
	 * 
	 * @param Card
	 * @return
	 */
	public Integer findByCount(Card form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Card
	 * @return
	 */
	public Card findById(Integer id);
	
	/**
	 * 查询根据智能卡号
	 * 
	 * @param Card
	 * @return
	 */
	public Card findByCardid(Card form);
	
	/**
	 * 查询根据智能卡号
	 * 
	 * @param Usercard
	 * @return
	 */
	public Card findByCardidStr(String cardid);
	
	/**
	 * 更新智能卡状态
	 * 
	 * @param cardid
	 * @return
	 */
	public Integer updateCardState(Card form);
	
	/**
	 * 批量更新智能卡状态
	 * 
	 * @param cardid
	 * @return
	 */
	public Integer updateCardStateBatch(Card form);
	
	/**
	 * 更新智能卡配对机顶盒
	 * 
	 * @param cardid
	 * @return
	 */
	public Integer updateStbno(Card form);
	
	/**
	 * 批量导入
	 * @param Card
	 * @return
	 */
	public Integer saveBatch(ArrayList<Card>cardlist);
	
	/**
	 * 查询根据机卡配对机顶盒号查询智能卡信息
	 * 
	 * @param cardid
	 * @return
	 */
	public Card findByStbnoStr(String stbno);
	
	/**
	 * 批量查询
	 * 
	 * @param Card
	 * @return
	 */
	public List<Card> findBatchCardByList(Card form);
	
}
