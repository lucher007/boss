package com.gospell.boss.service;


import com.gospell.boss.po.Batchcmd;


/**
 * CA业务层接口
 */
public interface IBatchcmdService {
	
	
	/**
	 * 批量授权
	 * @param 
	 * @return
	 */
	public void saveBatchcmd_authorize(Batchcmd batchcmd);
	
	/**
	 * 批量关停
	 * @param 
	 * @return
	 */
	public void saveBatchcmd_stop(Batchcmd batchcmd);
	
	/**
	 * 批量授权刷新
	 * @param 
	 * @return
	 */
	public void saveBatchcmd_batchauthorizerefresh(Batchcmd batchcmd);
	
	/**
	 * 批量发卡
	 * @param 
	 * @return
	 */
	public void saveBatchcmd_batchsendcard(Batchcmd batchcmd);
	
}
