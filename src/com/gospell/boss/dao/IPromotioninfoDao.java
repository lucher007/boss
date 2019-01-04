package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Event;
import com.gospell.boss.po.Eventextend;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productextend;
import com.gospell.boss.po.Provider;
import com.gospell.boss.po.Service;
import com.gospell.boss.po.Serviceextend;

/**
 * 数据层接口
 */
public interface IPromotioninfoDao {

	/**
	 * 添加
	 * 
	 * @return
	 */
	public Integer saveProductextend(Productextend form);

	
	/**
	 * 查询所有productextend条目
	 * 
	 * @return
	 */
	public List<Productextend> findAllProductExtend();
	
	
	/**
	 * 添加
	 * 
	 * @return
	 */
	public Integer saveEventextend(Eventextend form);

	/**
	 * 添加
	 * 
	 * @return
	 */
	public Integer saveServiceextend(Serviceextend form);

	/**
	 * 查询根据产品ID
	 * 
	 * @param productid
	 * @return
	 */
	public List<Productextend> findByProduct(Productextend form);

	/**
	 * 查询根据事件ID
	 * 
	 * @param eventid
	 * @return
	 */
	public List<Eventextend> findByEvent(Eventextend form);

	/**
	 * 查询根据服务ID
	 * 
	 * @param serviceid
	 * @return
	 */
	public List<Serviceextend> findByService(Serviceextend form);
	
	/**
	 * 供应商分页总数
	 * 
	 * @param Service
	 * @return
	 */
	public Integer findServiceextendCount(Service form);
	
	/**
	 * 供应商分页总数
	 * 
	 * @param Product
	 * @return
	 */
	public Integer findProductextendCount(Product form);
	
	/**
	 * 供应商分页总数
	 * 
	 * @param Event
	 * @return
	 */
	public Integer findEventextendCount(Event form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Serviceextend
	 * @return
	 */
	public Serviceextend findServiceextendById(Integer id);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Productextend
	 * @return
	 */
	public Productextend findProductextendById(Integer id);
	
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteProductextend(Integer id);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteServiceextend(Integer id);

}
