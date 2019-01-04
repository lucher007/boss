package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Computer;

/**
 * 数据层接口
 */
public interface IComputerDao {
	
	/**
	 * 计算机添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Computer form);
	
	/**
	 * 计算机更新
	 * 
	 * @param Computer
	 * @return
	 */
	public Integer update(Computer form);
	
	/**
	 * 计算机删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 计算机分页查询
	 * 
	 * @param Computer
	 * @return
	 */
	public List<Computer> findByList(Computer form);
	
	/**
	 * 计算机全部查询
	 * 
	 * @param Computer
	 * @return
	 */
	public List<Computer> queryByList(Computer form);
	
	/**
	 * 计算机分页总数
	 * 
	 * @param Computer
	 * @return
	 */
	public Integer findByCount(Computer form);
	
	/**
	 * 计算机查询根据ID
	 * 
	 * @param Computer
	 * @return
	 */
	public Computer findById(Integer id);
	
	/**
	 * 计算机查询根据计算机MAC地址
	 * 
	 * @param Computer
	 * @return
	 */
	public Computer findByMacaddress(Computer form);
	
}
