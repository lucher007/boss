package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnblackstb;

/**
 * 数据层接口
 */
public interface ICaspnblackstbDao {
	
	/**
	 * 机顶盒黑名单添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnblackstb form);
	
	/**
	 * 机顶盒黑名单更新
	 * 
	 * @param Caspnblackstb
	 * @return
	 */
	public Integer update(Caspnblackstb form);
	
	/**
	 * 机顶盒黑名单删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 机顶盒黑名单分页查询
	 * 
	 * @param Caspnblackstb
	 * @return
	 */
	public List<Caspnblackstb> findByList(Caspnblackstb form);
	
	/**
	 * 机顶盒黑名单全部查询
	 * 
	 * @param Caspnblackstb
	 * @return
	 */
	public List<Caspnblackstb> queryByList(Caspnblackstb form);
	
	/**
	 * 机顶盒黑名单分页总数
	 * 
	 * @param Caspnblackstb
	 * @return
	 */
	public Integer findByCount(Caspnblackstb form);
	
	/**
	 * 机顶盒黑名单查询根据ID
	 * 
	 * @param Caspnblackstb
	 * @return
	 */
	public Caspnblackstb findById(Integer id);
	
}
