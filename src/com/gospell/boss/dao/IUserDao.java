package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Operator;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Userproduct;

/**
 * 数据层接口
 */
public interface IUserDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(User form);
	
	/**
	 * 更新
	 * 
	 * @param User
	 * @return
	 */
	public Integer update(User form);
	
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
	 * @param User
	 * @return
	 */
	public List<User> findByList(User form);
	
	/**
	 * 分页查询
	 * 
	 * @param User
	 * @return
	 */
	public List<User> findByUserinfo(User form);
	
	/**
	 * 全部查询
	 * 
	 * @param User
	 * @return
	 */
	public List<User> queryByList(User form);
	
	/**
	 * 分页总数
	 * 
	 * @param User
	 * @return
	 */
	public Integer findByCount(User form);
	
	/**
	 * 分页总数
	 * 
	 * @param User
	 * @return
	 */
	public Integer countByUserinfo(User form);
	
	
	/**
	 * 查询根据ID
	 * 
	 * @param User
	 * @return
	 */
	public User findById(Integer id);
	
	/**
	 * 查询根据ID
	 * 
	 * @param User
	 * @return
	 */
	public User findByAnyInfo(User form);
	
	
	
	/**
	 * 查询根据用户code
	 * 
	 * @param User
	 * @return
	 */
	public User findByUsercode(User form);
	
	/**
	 * 激活产品
	 * 
	 * @param User
	 * @return
	 */
	public Integer activeUser(User form);
	
	
	/**
	 * 查询统计-用户状态查询
	 * 
	 * @param User
	 * @return
	 */
	public Integer findUserStateReportByCount(User form);
	
	/**
	 * 查询统计-用户状态查询
	 * @param 
	 * @return
	 */
	public List<User> findUserStateReport(User form);
	
	
	/**
	 * 账户余额充值
	 * 
	 * @param User
	 * @return
	 */
	public Integer rechargeAccount(User form);
	
	/**
	 * 用户修改登录密码
	 * 
	 * @param User
	 * @return
	 */
	public Integer updatePassword(User form);
	
	/**
	 * 用户修改支付密码
	 * 
	 * @param User
	 * @return
	 */
	public Integer updatePaypassword(User form);
	
	
}
