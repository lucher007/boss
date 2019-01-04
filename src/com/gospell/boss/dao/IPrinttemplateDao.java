package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Printpara;
import com.gospell.boss.po.Printtemplate;
import com.gospell.boss.po.Problemcomplaint;

/**
 * 数据层接口
 */
public interface IPrinttemplateDao {

	/**
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Printtemplate form);
	
	/**
	 * 
	 * @param Printtemplate
	 * @return
	 */
	public Integer update(Printtemplate form);
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 
	 * @param Printtemplate
	 * @return
	 */
	public List<Printtemplate> findByList(Printtemplate form);

	/**
	 * 查询根据ID
	 * 
	 * @param Printtemplate
	 * @return
	 */
	public Printtemplate findById(Integer id);
	
	/**
	 * 
	 * @param Printtemplate
	 * @return
	 */
	public Integer findByCount(Printtemplate form);
	
	/**
	 * 
	 * @param Printtemplate
	 * @return
	 */
	public List<Printtemplate> queryByList(Printtemplate form);	
	
	/**
	 * 
	 * @param 
	 * @return
	 */
	public List<Printpara> queryPrintpara();	
	
	/**
	 * 
	 * @param 
	 * @return
	 */
	public Printtemplate findByCode(String code);	
	
	/**
	 * 
	 * @param 
	 * @return
	 */
	public Printtemplate findByName(String name);	

}
