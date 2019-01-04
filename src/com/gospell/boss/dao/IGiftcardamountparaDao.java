package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;
import com.gospell.boss.po.Giftcardamountpara;;

/**
 * 数据层接口
 */
public interface IGiftcardamountparaDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Giftcardamountpara form);
	
	/**
	 * 更新
	 * 
	 * @param Giftcardamountpara
	 * @return
	 */
	public Integer update(Giftcardamountpara form);
	
	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
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
	 * @param Giftcardamountpara
	 * @return
	 */
	public List<Giftcardamountpara> findByList(Giftcardamountpara form);
	
	/**
	 * 全部查询
	 * 
	 * @param Giftcardamountpara
	 * @return
	 */
	public List<Giftcardamountpara> queryByList(Giftcardamountpara form);
	
	/**
	 * 分页总数
	 * 
	 * @param Giftcardamountpara
	 * @return
	 */
	public Integer findByCount(Giftcardamountpara form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Giftcardamountpara
	 * @return
	 */
	public Giftcardamountpara findById(Integer id);
	
	/**
	 * 激活业务
	 * 
	 * @param Giftcardamountpara
	 * @return
	 */
	public Integer activeGiftcardamountpara(Giftcardamountpara form);
	
	/**
	 * 批量导入
	 * @param Giftcardamountpara
	 * @return
	 */
	public Integer saveBatch(ArrayList<Giftcardamountpara>services);
	
	
	/**
	 * 查询参数KEY
	 * 
	 * @param Giftcardamountpara
	 * @return
	 */
	public Giftcardamountpara findByParakey(String parakey);
}
