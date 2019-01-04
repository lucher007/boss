package com.gospell.boss.common;

/**
 * 读取配置文件
 */
public final class ConfigUtil {
	private ConfigUtil() {
	}
	
	/**
	 * 获得confi.properties相关树形
	 * 
	 * @param key
	 * @return
	 */
	public static String getConfigFilePath(String key,String propertyName) {
		PropertiesUtil propertiesUtil = PropertiesUtil
				.createPropertiesUtil(propertyName);
		return propertiesUtil.getProperty(key);
	}
}
