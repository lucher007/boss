package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userstb;

/**
 * 数据层接口
 */
public interface IUserstbDao {

	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Userstb form);

	/**
	 * 更新
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer update(Userstb form);

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
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> findByList(Userstb form);

	/**
	 * 分页查询
	 * 
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> findByListForUserquery(Userstb form);
	
	/**
	 * 全部查询
	 * 
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> queryByList(Userstb form);

	/**
	 * 全部查询
	 * 
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> queryNocardUserstbByUserid(Integer userid);

	/**
	 * 
	 * @param Integer  userId
	 * @return
	 */
	public List<Userstb> queryByUserid(Integer userid);

	
	/**
	 * 分页总数
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer findByCount(Userstb form);
	
	/**
	 * 分页总数
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer findByCountForUserquery(Userstb form);

	/**
	 * 分页总数
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer findUserstbCountByServerVersiontype(Userstb versiontype);

	/**
	 * 分页查询
	 * 
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> findUserstbListByServerVersiontype(Userstb form);

	/**
	 * 查询根据ID
	 * 
	 * @param Userstb
	 * @return
	 */
	public Userstb findById(Integer id);

	/**
	 * 查询根据机顶盒号
	 * 
	 * @param Userstb
	 * @return
	 */
	public Userstb findByStbno(Userstb form);
	
	/**
	 * 查询根据机顶盒号
	 * 
	 * @param Userstb
	 * @return
	 */
	public Userstb findByStbnoStr(String stbno);
     
	
	/**
	 * 更新订户机顶盒的区域信息-迁移业务
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer updateUserstbAreacode(Userstb form);
	
	/**
	 * 修改订户机顶盒的状态
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer updateStateByStbno(Userstb form);
	
	/**
	 * 查询根据主机号查询副机号
	 * 
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> findByMotherstbno(String motherstbno);
	
	/**
	 * 批量修改订户机顶盒的状态
	 * 
	 * @param Userstb
	 * @return
	 */
	public Integer updateState_batch(Userstb form);
	
	/**
	 * 批量查询根据机顶盒号
	 * 
	 * @param Userstb
	 * @return
	 */
	public List<Userstb> findByStbidStrBatch(String[] userstbidArr);
}
