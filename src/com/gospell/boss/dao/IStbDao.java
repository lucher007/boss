package com.gospell.boss.dao;

import java.util.ArrayList;
import java.util.List;

import com.gospell.boss.po.Card;
import com.gospell.boss.po.Stb;
import com.gospell.boss.po.Userstb;

/**
 * 数据层接口
 */
public interface IStbDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Stb form);
	
	/**
	 * 更新
	 * 
	 * @param Stb
	 * @return
	 */
	public Integer update(Stb form);
	
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
	 * @param Stb
	 * @return
	 */
	public List<Stb> findByList(Stb form);
	
	/**
	 * 全部查询
	 * 
	 * @param Stb
	 * @return
	 */
	public List<Stb> queryByList(Stb form);
	
	/**
	 * 分页总数
	 * 
	 * @param Stb
	 * @return
	 */
	public Integer findByCount(Stb form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Stb
	 * @return
	 */
	public Stb findById(Integer id);
	
	/**
	 * 查询根据机顶盒号
	 * 
	 * @param Stb
	 * @return
	 */
	public Stb findByStbno(Stb form);
	
	/**
	 * 查询根据机顶盒号
	 * 
	 * @param stbno
	 * @return
	 */
	public Stb findByStbnoStr(String stbno);
	
	/**
	 * 批量导入
	 * @param Stb
	 * @return
	 */
	public Integer saveBatch(ArrayList<Stb>stblist);
	
	/**
	 * 更新机顶盒状态
	 * 
	 * @param stbno
	 * @return
	 */
	public Integer updateStbState(Stb form);
	
	/**
	 * 批量更新机顶盒状态
	 * 
	 * @param stbno
	 * @return
	 */
	public Integer updateStbStateBatch(Stb form);
	
	/**
	 * 查询根据批量机顶盒号
	 * 
	 * @param stbno
	 * @return
	 */
	public List<Stb> findByStbnosStr(Stb form);
	
}
