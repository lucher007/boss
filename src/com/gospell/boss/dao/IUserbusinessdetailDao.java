package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.BusinessReport;
import com.gospell.boss.po.Userbusinessdetail;

/**
 * 数据层接口
 */
public interface IUserbusinessdetailDao {
	
	/**
	 * 添加
	 * 
	 * @param Userbusinessdetail
	 * @return
	 */
	public Integer save(Userbusinessdetail form);
	
	/**
	 * 更新
	 * 
	 * @param Userbusinessdetail
	 * @return
	 */
	public Integer update(Userbusinessdetail form);
	
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
	 * @param Userbusinessdetail
	 * @return
	 */
	public List<Userbusinessdetail> findByList(Userbusinessdetail form);
	
	/**
	 * 全部查询
	 * 
	 * @param Userbusinessdetail
	 * @return
	 */
	public List<Userbusinessdetail> queryByList(Userbusinessdetail form);
	
	/**
	 * 分页总数
	 * 
	 * @param Userbusinessdetail
	 * @return
	 */
	public Integer findByCount(Userbusinessdetail form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Integer
	 * @return
	 */
	public Userbusinessdetail findById(Integer id);
	
	
	/**
	 * 根据BusinessID查询
	 * 
	 * @param Integer
	 * @return
	 */
	public  List<Userbusinessdetail> findByBusinessid(Integer businessid);
	
	
	/**
	 * 查询根据userID
	 * 
	 * @param Userbusinessdetail
	 * @return
	 */
	public List<Userbusinessdetail> findByUserid(Integer userid);
	
	
	/**
	 * 根据营业员ID查询其经手的业务信息
	 * @param BusinessReport
	 * @return
	 */
	public List<BusinessReport> findOperatorReport(BusinessReport form);
	
	/**
	 * 根据营业员ID查询其经手的业务信息
	 * @param operatorid
	 * @return
	 */
	public List<Userbusinessdetail> findOperationByOperatorid(Userbusinessdetail form);

	/**
	 * 根据营业厅STOREID查询其经手的业务信息
	 * @param BusinessReport
	 * @return
	 */
	public List<BusinessReport> findStoreReport(BusinessReport form);
	
}
