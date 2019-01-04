package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Productserviceref;

/**
 * 数据层接口
 */
public interface IProductDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Product form);
	
	/**
	 * 更新
	 * 
	 * @param Product
	 * @return
	 */
	public Integer update(Product form);
	
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
	public Integer deleteByNetid(Integer netid);
	
	/**
	 * 分页查询
	 * 
	 * @param Product
	 * @return
	 */
	public List<Product> findByList(Product form);
	
	/**
	 * 全部查询
	 * 
	 * @param Product
	 * @return
	 */
	public List<Product> queryByList(Product form);
	
	/**
	 * 分页总数
	 * 
	 * @param Product
	 * @return
	 */
	public Integer findByCount(Product form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Product
	 * @return
	 */
	public Product findById(Integer id);
	
	/**
	 * 查询根据产品ID
	 * 
	 * @param Product
	 * @return
	 */
	public Product findByProductid(Product form);
	
	/**
	 * 激活产品
	 * 
	 * @param Product
	 * @return
	 */
	public Integer activeProduct(Product form);


	/**
	 * 不分页查询EXCEL所需条目
	 * 
	 * @param Product
	 * @return
	 */
	public List<Product> findForExcel(Product form);
	
	/**
	 * 批量导入
	 * @param Product
	 * @return
	 */
	public Integer saveBatch(ArrayList<Product> products);
	
	
	
}
