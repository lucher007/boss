package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Userfeedback;

/**
 * 数据层接口
 */
public interface IUserfeedbackDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Userfeedback form);
	
	/**
	 * 更新
	 * 
	 * @param Userfeedback
	 * @return
	 */
	public Integer update(Userfeedback form);
	
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
	 * @param Userfeedback
	 * @return
	 */
	public List<Userfeedback> findByList(Userfeedback form);
	
	/**
	 * 全部查询
	 * 
	 * @param Userfeedback
	 * @return
	 */
	public List<Userfeedback> queryByList(Userfeedback form);
	
	/**
	 * 分页总数
	 * 
	 * @param Userfeedback
	 * @return
	 */
	public Integer findByCount(Userfeedback form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Userfeedback
	 * @return
	 */
	public Userfeedback findById(Integer id);
	
	/**
	 * 查询根据userID
	 * 
	 * @param Userfeedback
	 * @return
	 */
	public List<Userfeedback> findByUserid(Integer userid);
}
