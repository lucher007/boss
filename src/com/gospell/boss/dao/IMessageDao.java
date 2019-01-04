package com.gospell.boss.dao;

import java.util.List;
import com.gospell.boss.po.Message;

/**
 * 数据层接口
 */
public interface IMessageDao {
	
	/**
	 * 添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Message form);
	
	/**
	 * 更新
	 * 
	 * @param Message
	 * @return
	 */
	public Integer update(Message form);
	
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
	 * @param Message
	 * @return
	 */
	public List<Message> findByList(Message form);
	
	/**
	 * 全部查询
	 * 
	 * @param Message
	 * @return
	 */
	public List<Message> queryByList(Message form);
	
	/**
	 * 分页总数
	 * 
	 * @param Message
	 * @return
	 */
	public Integer findByCount(Message form);
	
	/**
	 * 查询根据ID
	 * 
	 * @param Message
	 * @return
	 */
	public Message findById(Integer id);
	
}
