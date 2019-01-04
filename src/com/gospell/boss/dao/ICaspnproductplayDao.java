package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnproductplay;

/**
 * 数据层接口
 */
public interface ICaspnproductplayDao {
	
	/**
	 * 产品准播限播添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnproductplay form);
	
	/**
	 * 产品准播限播更新
	 * 
	 * @param Caspnproductplay
	 * @return
	 */
	public Integer update(Caspnproductplay form);
	
	/**
	 * 产品准播限播删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 产品准播限播分页查询
	 * 
	 * @param Caspnproductplay
	 * @return
	 */
	public List<Caspnproductplay> findByList(Caspnproductplay form);
	
	/**
	 * 产品准播限播全部查询
	 * 
	 * @param Caspnproductplay
	 * @return
	 */
	public List<Caspnproductplay> queryByList(Caspnproductplay form);
	
	/**
	 * 产品准播限播分页总数
	 * 
	 * @param Caspnproductplay
	 * @return
	 */
	public Integer findByCount(Caspnproductplay form);
	
	/**
	 * 产品准播限播查询根据ID
	 * 
	 * @param Caspnproductplay
	 * @return
	 */
	public Caspnproductplay findById(Integer id);
	
}
