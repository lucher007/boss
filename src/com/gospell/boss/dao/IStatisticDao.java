package com.gospell.boss.dao;

import java.util.List;

import com.gospell.boss.po.Authorizehistory;
import com.gospell.boss.po.BusinessReport;

/**
 * 数据层接口
 */
public interface IStatisticDao {

	/**
	 * @param BusinessReport
	 * @return Integer
	 */
	public Integer findEntitlementAdded(BusinessReport form);

	/**
	 * @param BusinessReport
	 * @return Integer
	 */
	public Integer findEntitlementExpired(BusinessReport form);

	/**
	 * @param BusinessReport
	 * @return Integer
	 */
	public Integer findEntitlementRemoved(BusinessReport form);

	/**
	 * @param BusinessReport
	 * @return Integer
	 */
	public Integer findOpeningBalance(BusinessReport form);

	/**
	 * @param BusinessReport
	 * @return Integer
	 */
	public Integer findClosingBalance(BusinessReport form);

}
