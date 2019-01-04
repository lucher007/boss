package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Useraccountlog;
import com.gospell.boss.po.Userbusiness;

/**
 * 数据层接口
 */
public interface IUseraccountlogDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Useraccountlog form);
	
	/**
	 * 更新
	 * 
	 * @param Useraccountlog
	 * @return
	 */
	public Integer update(Useraccountlog form);
	
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
	 * @param Useraccountlog
	 * @return
	 */
	public List<Useraccountlog> findByList(Useraccountlog form);
	
	/**
	 * 全部查询
	 * 
	 * @param Useraccountlog
	 * @return
	 */
	public List<Useraccountlog> queryByList(Useraccountlog form);
	
	/**
	 * 分页总数
	 * 
	 * @param Useraccountlog
	 * @return
	 */
	public Integer findByCount(Useraccountlog form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Useraccountlog
	 * @return
	 */
	public Useraccountlog findById(Integer id);
	
	/**
	 * 查询根据userID
	 * 
	 * @param Userbusiness
	 * @return
	 */
	public List<Useraccountlog> findByUserid(Integer userid);
	
}
