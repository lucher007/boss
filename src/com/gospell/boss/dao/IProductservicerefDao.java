package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Productserviceref;
import com.gospell.boss.po.Service;

/**
 * 数据层接口
 */
public interface IProductservicerefDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Productserviceref form);
	
	/**
	 * 更新
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public Integer update(Productserviceref form);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteByProductid(Productserviceref form);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteByNetid(Integer netid);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteByServiceid(Productserviceref form);
	
	/**
	 * 分页查询
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public List<Productserviceref> findByList(Productserviceref form);
	
	/**
	 * 全部查询
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public List<Productserviceref> queryByList(Productserviceref form);
	
	/**
	 * 分页总数
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public Integer findByCount(Productserviceref form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public Productserviceref findById(Integer id);
	
	/**
	 * 查询根据产品ID
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public List<Productserviceref> findByProductid(Productserviceref form);
	
	/**
	 * 查询根据业务ID
	 * 
	 * @param Productserviceref
	 * @return
	 */
	public List<Productserviceref> findByServiceid(Productserviceref form);
	
	/**
	 * 批量导入
	 * @param Productserviceref
	 * @return
	 */
	public Integer saveBatch(List<Productserviceref>  productservicerefs);
	
	
}
