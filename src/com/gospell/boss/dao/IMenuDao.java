package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Menu;

/**
 * 用户数据层接口
 */
public interface IMenuDao {
	public Menu findById(Menu form);

	public Integer insert(Menu form);

	public Integer update(Menu form);

	public Integer delete(Menu form);

	public List<Menu> findByList(Menu form);

	public Integer findByCount(Menu form);

	public List<Menu> queryByList(Menu form);

	public List<Menu> querySecondMenuByPid(Menu form);
	
	public List<Menu> queryFirstMenuByRoleid(Integer roleid);
	
	
	public List<Menu> queryMenuByIds(List<Integer> ids);

	public List<Menu> queryRelatedSecondMenu(Menu form);
	
}
