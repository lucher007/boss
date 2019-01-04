package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userstb;

/**
 * 数据层接口
 */
public interface IUsercardDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Usercard form);
	
	/**
	 * 更新
	 * 
	 * @param Usercard
	 * @return
	 */
	public Integer update(Usercard form);
	
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
	 * @param Usercard
	 * @return
	 */
	public List<Usercard> findByList(Usercard form);
	
	/**
	 * 分页查询
	 * 
	 * @param Usercard
	 * @return
	 */
	public List<Usercard> findByListForUserquery(Usercard form);
	
	/**
	 * 全部查询
	 * 
	 * @param Usercard
	 * @return
	 */
	public List<Usercard> queryByList(Usercard form);
	
	/**
	 * 分页总数
	 * 
	 * @param Usercard
	 * @return
	 */
	public Integer findByCount(Usercard form);
	
	/**
	 * 分页总数
	 * 
	 * @param Usercard
	 * @return
	 */
	public Integer findByCountForUserquery(Usercard form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Usercard
	 * @return
	 */
	public Usercard findById(Integer id);
	
	
	/**
	 * 查询根据userid
	 * 
	 * @param Usercard
	 * @return
	 */
	public List<Usercard> findByUserid(Integer userid);
	/**
	 * 查询根据智能卡号
	 * 
	 * @param Usercard
	 * @return
	 */
	public Usercard findByCardid(Usercard form);
	
	/**
	 * 查询根据智能卡号
	 * 
	 * @param Usercard
	 * @return
	 */
	public Usercard findByCardidStr(String cardid);
	
	
	/**
	 * 根据绑定机顶盒号查询智能卡
	 * 
	 * @param Usercard
	 * @return
	 */
	public Usercard findByStbno(Usercard form);
	
	/**
	 * 根据绑定机顶盒号查询智能卡
	 * 
	 * @param Usercard
	 * @return
	 */
	public Usercard findByStbnoStr(String stbno);
	
	/**
	 * 修改智能卡的绑定机顶盒号
	 * 
	 * @param Usercard
	 * @return
	 */
	public Integer updateStbno(Usercard form);
	
	
	/**
	 * 更新订户智能卡的区域信息-迁移业务
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer updateUsercardAreacode(Usercard form);
	
	/**
	 * 修改订户智能卡的状态
	 * 
	 * @param Usercard
	 * @return
	 */
	public Integer updateStateByCardid(Usercard form);
	
	/**
	 * 查询根据母卡号查询子机
	 * 
	 * @param Usercard
	 * @return
	 */
	public List<Usercard> findByMothercardid(String mothercardid);
	
	/**
	 * 批量更新
	 * 
	 * @param Usercard
	 * @return
	 */
	public Integer updateState_batch(Usercard form);
	
	/**
	 * 批量查询根据智能卡号
	 * 
	 * @param Usercard
	 * @return
	 */
	public List<Usercard> findByCardidStrBatch(String[] usercardidArr);
}
