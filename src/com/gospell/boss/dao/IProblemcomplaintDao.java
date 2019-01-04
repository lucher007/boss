package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Problemcomplaint;
import com.gospell.boss.po.Problemcomplaintdetail;

/**
 * 数据层接口
 */
public interface IProblemcomplaintDao {

	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Problemcomplaint form);

	/**
	 * 添加Detail
	 * 
	 */
	public Integer saveDetail(Problemcomplaintdetail form);

	/**
	 * 更新
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public Integer update(Problemcomplaint form);

	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);

	/**
	 * 更新State
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public Integer updateState(Problemcomplaint form);

	/**
	 * 分页查询
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public List<Problemcomplaint> findByList(Problemcomplaint form);

	/**
	 * 全部查询
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public List<Problemcomplaint> queryByList(Problemcomplaint form);

	/**
	 * 分页总数
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public Integer findByCount(Problemcomplaint form);

	/**
	 * 查询根据ID
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public Problemcomplaint findById(Integer id);

	/**
	 * 查询根据userID
	 * 
	 * @param Problemcomplaint
	 * @return
	 */
	public List<Problemcomplaint> findByUserid(Integer userid);

	/**
	 * 根据complaintid查询对应的文件
	 * 
	 * @param Integer
	 * @return
	 */
	public List<Problemcomplaintdetail> findDetailByComplaintid(Integer complaintid);
	
	/**
	 * 根据complaintdetailid查询对应的文件
	 * 
	 * @param Integer
	 * @return
	 */
	public Problemcomplaintdetail findDetailByDetailid(Integer complaintdetailid);

}
