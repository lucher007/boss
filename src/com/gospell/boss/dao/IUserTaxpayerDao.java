package com.gospell.boss.dao;

import com.gospell.boss.po.UserTaxpayer;

/**
 * 纳税人dao
 * @author Administrator
 *
 */
public interface IUserTaxpayerDao {
	/**
	 * 保存
	 */
	public void save(UserTaxpayer usertaxpayer);
	
	/**
	 * 根据id查询
	 * @param usertaxpayer
	 * @return
	 */
	public UserTaxpayer findByUserid(Integer userid);
	/**
	 * 修改
	 * @param usertaxpayer
	 */
	public void update(UserTaxpayer usertaxpayer);
}
