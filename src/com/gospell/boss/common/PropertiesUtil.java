package com.gospell.boss.common;

import java.io.IOException;
import java.util.Properties;

/**
 * 动态读取配置文件
 */
public final class PropertiesUtil {
	private static Properties properties = new Properties();

	private static PropertiesUtil propertiesUtil;

	private PropertiesUtil() {
	}

	private static void loadFile(String filename) {
		try {
			properties.load(PropertiesUtil.class.getResourceAsStream("/"
					+ filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static synchronized PropertiesUtil createPropertiesUtil(
			String filename) {
		if (propertiesUtil == null) {
			propertiesUtil = new PropertiesUtil();
		}
		loadFile(filename);
		return propertiesUtil;
	}

	public String getProperty(String key) {
		return properties.getProperty(key);
	}
}