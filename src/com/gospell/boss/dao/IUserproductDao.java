package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;

/**
 * 数据层接口
 */
public interface IUserproductDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Userproduct form);
	
	/**
	 * 批量添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer saveBatch(List<Userproduct> userproductlist);
	
	/**
	 * 更新
	 * 
	 * @param Userproduct
	 * @return
	 */
	public Integer update(Userproduct form);
	
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
	 * @param Userproduct
	 * @return
	 */
	public List<Userproduct> findByList(Userproduct form);
	
	/**
	 * 全部查询
	 * 
	 * @param Userproduct
	 * @return
	 */
	public List<Userproduct> queryByList(Userproduct form);
	
	/**
	 * 分页总数
	 * 
	 * @param Userproduct
	 * @return
	 */
	public Integer findByCount(Userproduct form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Userproduct
	 * @return
	 */
	public Userproduct findById(Integer id);
	
	/**
	 * 查询根据userID
	 * 
	 * @param Userproduct
	 * @return
	 */
	public List<Userproduct>  findByUserid(Integer userid);
	/**
	 * 查询智能卡下某一产品的最后授权记录
	 * 
	 * @param Userproduct
	 * @return
	 */
	public String findLastEndTimeByProductid(Userproduct form);
	
	
	/**
	 * 查询产品信息
	 * @param BusinessReport
	 * @return
	 */
	public List<BusinessReport> findUserProductReport(Userproduct form);
	
	/**
	 * 查询根据终端号terminalid
	 * 
	 * @param Userproduct
	 * @return
	 */
	public List<Userproduct>  findByTerminalid(Userproduct form);
	
	/**
	 * 查询根据终端号terminalid
	 * 
	 * @param Userproduct
	 * @return
	 */
	public List<Userproduct>  findByTerminalidStr(String terminalid);
	
	/**
	 * 更新订户产品的区域信息-迁移业务
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer updateUserproductAreacode(Userproduct form);
	
	/**
	 * 查询该产品在某个时间段内的有交叉的购买记录
	 * 
	 * @param Userstb
	 * @return 
	 */
	public List<Userproduct> findPurchasedProductInTimePeriod (Userproduct form);
	
	/**
	 * 查询终端在产品购买包含了某段时间的记录
	 * 
	 * @param Userstb
	 * @return 
	 */
	public List<Userproduct> findPurchasedProductOutTimePeriod (Userproduct form);
	/**
	 * 查询报停终端的每个产品剩余收视天数之和
	 * 
	 * @param Userstb
	 * @return 
	 */
	public List<Userproduct> findPauseProductRestday (Userproduct form);
	
	/**
	 * 删除报停的智能卡的所有有效值的产品
	 * 
	 * @param Userstb
	 * @return 
	 */
	public Integer deletePauseProduct_batch (Userproduct form);
	
	/**
	 * 批量删除无效的到期的产品
	 * 
	 * @param Userstb
	 * @return 
	 */
	public Integer deleteInvalidProduct (Userproduct form);
	
	
	/**
	 * 批量查询根据IDS
	 * 
	 * @param Userstb
	 * @return 
	 */
	public List<Userproduct> findByIdBatch (String[] userproductidArr);
	
	/**
	 * 授权截止时间
	 * 
	 * @param 
	 * @return 
	 */
	public Userproduct findMaxEndtimeProduct (Userproduct form);
	
}
