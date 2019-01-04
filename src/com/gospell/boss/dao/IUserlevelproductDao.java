package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Userlevelproduct;

/**
 * 数据层接口
 */
public interface IUserlevelproductDao {
	/**
	 * 分页查询
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public List<Userlevelproduct> findByList(Userlevelproduct form);
	
	/**
	 * 全部查询
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public List<Userlevelproduct> queryByList(Userlevelproduct form);
	
	/**
	 * 分页总数
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public Integer findByCount(Userlevelproduct form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public Userlevelproduct findById(Integer id);
	
	/**
	 * 查询根据产品ID
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public List<Userlevelproduct> findByUserlevelid(String userlevelid);
	
	/**
	 * 查询根据业务ID
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public List<Userlevelproduct> findByProductid(String productid);
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Userlevelproduct form);
	
	/**
	 * 更新
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public Integer update(Userlevelproduct form);
	
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
	public Integer deleteByUserlevelid(Integer userlevelid);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteByProductid(String productid);
	
	/**
	 * 批量导入
	 * @param Userlevelproduct
	 * @return
	 */
	public Integer saveBatch(List<Userlevelproduct>  userlevelproductlist);
	
	/**
	 * 查询有效产品
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public List<Userlevelproduct> queryeffectiveproduct(Userlevelproduct userlevelproduct);
	
	/**
	 * 查询有效产品数目
	 * @param Userlevelproduct
	 * @return
	 */
	public Integer findeffectiveproductCount(Userlevelproduct userlevelproduct);
	
	/**
	 * 查询有效产品
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public Userlevelproduct findeffectiveproduct(Userlevelproduct userlevelproduct);
	
	/**
	 * 根据用户级别和产品id查询
	 * 
	 * @param Userlevelproduct
	 * @return
	 */
	public Userlevelproduct findByProductidAndUserlevelid(Userlevelproduct userlevelproduct);
	
	
}
