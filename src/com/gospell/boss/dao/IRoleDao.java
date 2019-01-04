package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Role;
import com.gospell.boss.po.Stb;

/**
 * 数据层接口
 */
public interface IRoleDao {
	
	/**
	 * 区域添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Role form);
	
	/**
	 * 区域更新
	 * 
	 * @param Role
	 * @return
	 */
	public Integer update(Role form);
	
	/**
	 * 区域删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 区域分页查询
	 * 
	 * @param Role
	 * @return
	 */
	public List<Role> findByList(Role form);
	
	/**
	 * 区域全部查询
	 * 
	 * @param Role
	 * @return
	 */
	public List<Role> queryByList(Role form);
	
	/**
	 * 区域分页总数
	 * 
	 * @param Role
	 * @return
	 */
	public Integer findByCount(Role form);
	
	/**
	 * 区域查询根据ID
	 * 
	 * @param Role
	 * @return
	 */
	public Role findById(Integer id);

	/**
	 * 
	 * @param String
	 * @return
	 */
	public Role findByRolecode(String rolecode);
	

	
	
	
}
