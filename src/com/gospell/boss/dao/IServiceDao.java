package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Service;
import com.gospell.boss.po.Stb;

/**
 * 数据层接口
 */
public interface IServiceDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Service form);
	
	/**
	 * 更新
	 * 
	 * @param Service
	 * @return
	 */
	public Integer update(Service form);
	
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
	 * 清空表
	 * 
	 * @param id
	 * @return
	 */
	public Integer emptyTable();
	
	/**
	 * 分页查询
	 * 
	 * @param Service
	 * @return
	 */
	public List<Service> findByList(Service form);
	
	/**
	 * 全部查询
	 * 
	 * @param Service
	 * @return
	 */
	public List<Service> queryByList(Service form);
	
	/**
	 * 分页总数
	 * 
	 * @param Service
	 * @return
	 */
	public Integer findByCount(Service form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Service
	 * @return
	 */
	public Service findById(Integer id);
	
	/**
	 * 查询根据业务ID
	 * 
	 * @param Service
	 * @return
	 */
	public Service findByServiceid(Service form);
	
	/**
	 * 激活业务
	 * 
	 * @param Service
	 * @return
	 */
	public Integer activeService(Service form);
	
	/**
	 * 批量导入
	 * @param Service
	 * @return
	 */
	public Integer saveBatch(ArrayList<Service>services);
	
	
}
