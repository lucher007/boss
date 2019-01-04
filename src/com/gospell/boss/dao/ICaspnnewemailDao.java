package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Caspnnewemail;

/**
 * 数据层接口
 */
public interface ICaspnnewemailDao {
	
	/**
	 * 新邮件添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Caspnnewemail form);
	
	/**
	 * 新邮件更新
	 * 
	 * @param Caspnnewemail
	 * @return
	 */
	public Integer update(Caspnnewemail form);
	
	/**
	 * 新邮件删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 新邮件分页查询
	 * 
	 * @param Caspnnewemail
	 * @return
	 */
	public List<Caspnnewemail> findByList(Caspnnewemail form);
	
	/**
	 * 新邮件全部查询
	 * 
	 * @param Caspnnewemail
	 * @return
	 */
	public List<Caspnnewemail> queryByList(Caspnnewemail form);
	
	/**
	 * 新邮件分页总数
	 * 
	 * @param Caspnnewemail
	 * @return
	 */
	public Integer findByCount(Caspnnewemail form);
	
	/**
	 * 新邮件查询根据ID
	 * 
	 * @param Caspnnewemail
	 * @return
	 */
	public Caspnnewemail findById(Integer id);
	
}
