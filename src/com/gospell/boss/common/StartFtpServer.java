package com.gospell.boss.common;

import java.io.File;

import org.apache.ftpserver.FtpServer;
import org.apache.ftpserver.FtpServerFactory;
import org.apache.ftpserver.ftplet.FtpException;
import org.apache.ftpserver.listener.ListenerFactory;
import org.apache.ftpserver.usermanager.PasswordEncryptor;
import org.apache.ftpserver.usermanager.PropertiesUserManagerFactory;

public class StartFtpServer {
	/**
	 * @throws FtpException
	 */
	public static void start() throws FtpException {
		// TODO Auto-generated method stub
		FtpServerFactory serverFactory = new FtpServerFactory();
		ListenerFactory factory = new ListenerFactory();
		factory.setPort(21);
		// define SSL configuration
		/**
		 * 使用ssl会导致客户端无法连接 SslConfigurationFactory ssl = new
		 * SslConfigurationFactory(); ssl.setKeystoreFile(new
		 * File(System.getProperty("user.dir")+"/conf/ftpserver.jks"));
		 * ssl.setKeystorePassword("password"); // set the SSL configuration for
		 * the listener
		 * factory.setSslConfiguration(ssl.createSslConfiguration());
		 * factory.setImplicitSsl(true);
		 */
		// replace the default listener
		serverFactory.addListener("default", factory.createListener());
		PropertiesUserManagerFactory userManagerFactory = new PropertiesUserManagerFactory();
		userManagerFactory.setFile(new File(System.getProperty("user.dir") + "/config/ftpUsersConfig.properties"));
		userManagerFactory.setPasswordEncryptor(new PasswordEncryptor() {
			public String encrypt(String pwd) {
			// TODO Auto-generated method stub
				return null;
			}
			// storedPassword 配置文件中配置的密码 passwordToCheck 是用户输入的密码
			public boolean matches(java.lang.String passwordToCheck, java.lang.String storedPassword) {
				if (passwordToCheck.equals(storedPassword))
					return true;
				return false;
			}
		});
		serverFactory.setUserManager(userManagerFactory.createUserManager());
		// start the server
		FtpServer server = serverFactory.createServer();
		server.start();
		System.out.println("***********ftp_server_stated_now***********");
	}
}
