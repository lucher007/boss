package com.gospell.boss.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IAuthorizehistoryDao;
import com.gospell.boss.dao.ISystemparaDao;


@Controller
@Scope("prototype")
@Transactional
@RequestMapping("/backupdata")
public class BackupDatabaseController {
	private final String FILE_NAME = "jdbc.properties";
    
	@Autowired
	private ISystemparaDao systemparaDao;
	@Autowired
	private IAuthorizehistoryDao authorizehistoryDao;
	
	public void executeBackup() {
		String fileSeparator = System.getProperty("file.separator");
		String lineSeparator = System.getProperty("line.separator");
		String osName = System.getProperty("os.name").toLowerCase();

		Properties props = getBackupProperties();
		String databaseIp = props.getProperty("databaseIp");
		String databasePort = props.getProperty("databasePort");
		String databaseUsername = props.getProperty("user");
		String databasePassword = props.getProperty("password");
		String backupFileNum = props.getProperty("backupFileNum");
		String databaseName = props.getProperty("databaseName");
		String datetime = Tools.getCurrentTime().replace(' ', '_')
				.replace(':', '.');
		String mysqlBinPath = props.getProperty("mysqlBinPath");
		if (mysqlBinPath == null || mysqlBinPath.trim().length() == 0) {
			
			String tempBackupPath = BackupDatabaseController.class.getResource("/")
					.getPath().replace("/", fileSeparator);
			mysqlBinPath = tempBackupPath.substring(0,
					tempBackupPath.indexOf("WEB-INF"))
					+ "database_backup";
			if (osName.startsWith("win")) {
				mysqlBinPath = "\"" + mysqlBinPath.substring(1) + fileSeparator + "mysqldump\"";
			} else if (osName.startsWith("lin")) {
				mysqlBinPath = "\"" + mysqlBinPath + fileSeparator + "mysqldump\"";
			}
		} else {
			mysqlBinPath = "\"" + mysqlBinPath + fileSeparator + "mysqldump\"";
		}
		//获取备份保存路径
		//String backupPath = props.getProperty("backupPath");
		String upload_extend_path = systemparaDao.findByCodeStr("upload_file_path").getValue();
		String backupPath = upload_extend_path + File.separatorChar + "database_backup";
		File folder = new File(backupPath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		if (backupPath == null || backupPath.trim().length() == 0) {
			String tempBackupPath = BackupDatabaseController.class.getResource("/")
					.getPath().replace("/", fileSeparator);
			backupPath = tempBackupPath.substring(0,
					tempBackupPath.indexOf("WEB-INF"))
					+ "database_backup";
			if (osName.startsWith("win")) {
				backupPath = backupPath.substring(1) + fileSeparator + "Windows";
			} else if (osName.startsWith("lin")) {
				backupPath = backupPath + fileSeparator + "Linux";
			}
		}
		String backupFile = backupPath + fileSeparator + databaseName + "_"
				+ datetime + ".sql";
		
		ProcessBuilder processBuilder = null;
		StringBuffer stringBuffer = new StringBuffer();
		
		if (osName.startsWith("win")) {
			stringBuffer.append("@echo off" + lineSeparator);
			stringBuffer.append("if not exist \"" + backupPath + "\" md \""
					+ backupPath + "\"" + lineSeparator);
			stringBuffer.append(mysqlBinPath + " -h" + databaseIp + " -P"
					+ databasePort + " -u" + databaseUsername + " -p"
					+ databasePassword + " --single-transaction "
					+ databaseName + " > \"" + backupFile + "\""
					+ lineSeparator);
			stringBuffer.append("FOR /F \"skip=" + backupFileNum
					+ " tokens=*\" %i IN ('DIR \"" + backupPath + "\\"
					+ databaseName + "*.sql\" /TC /O-D /B') DO DEL \""
					+ backupPath + "\\%i\" /Q /F" + lineSeparator);
			stringBuffer.append("@echo on" + lineSeparator);
			stringBuffer.append("exit" + lineSeparator);

			processBuilder = new ProcessBuilder("cmd");
		} else if (osName.startsWith("lin")) {
			stringBuffer.append("if [ ! -d '" + backupPath
					+ "' ]; then mkdir -p '" + backupPath + "'; fi"
					+ lineSeparator);
			stringBuffer.append(mysqlBinPath + " -h" + databaseIp + " -P"
					+ databasePort + " -u" + databaseUsername + " -p"
					+ databasePassword + " --single-transaction "
					+ databaseName + " > '" + backupFile + "'" + lineSeparator);
			stringBuffer.append("cd '" + backupPath + "'" + lineSeparator);
			stringBuffer.append("count=$(ls -B " + databaseName
					+ "*.sql | wc -l)" + lineSeparator);
			stringBuffer.append("del_count=$(($count - " + backupFileNum + "))"
					+ lineSeparator);
			stringBuffer
					.append("if [ $del_count -gt 0 ]; then for i in `ls -trB "
							+ databaseName
							+ "*.sql | head -$del_count`; do rm -f $i; done; fi"
							+ lineSeparator);
			stringBuffer.append("exit" + lineSeparator);
			processBuilder = new ProcessBuilder("sh");
		} else {
			System.out.println("操作系统不是Windows或Linux，数据库暂时无法备份！");
			return;
		}

		String command = stringBuffer.toString();
		
		System.out.println("------=command=\n"+command);
		
		try {
			Process process = processBuilder.start();
			OutputStreamWriter writer = new OutputStreamWriter(
					process.getOutputStream());
			writer.write(command);
			writer.flush();
			if (writer != null) {
				writer.close();
			}
			BufferedReader bufferReader = new BufferedReader(
					new InputStreamReader(process.getInputStream()));
			while (bufferReader.readLine() != null)
				;

			if (bufferReader != null) {
				bufferReader.close();
			}
			if (process.waitFor() != 0) {
				System.out.println("数据库备份出错！-------");
			} else {
				//数据库备份成功，删除授权成功的指令，防止数据库过大
				authorizehistoryDao.deleteAll();
				
				System.out.println("数据库备份成功！-------");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException ie) {
			ie.printStackTrace();
		}
	}

	private Properties getBackupProperties() {
		Resource res = new ClassPathResource(FILE_NAME);
		Properties props = new Properties();
		try {
			props.load(res.getInputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return props;
	}
	
	/**
	 * 数据库备份初始化
	 * @return
	 */
	@RequestMapping(value="/databasestoreInit")
	public String databaserestoreInit() {
		return "databaserestore/exportDataList";
	}
	
	/**
	 * 备份数据
	 */
	@RequestMapping(value = "/exportData")
	public void exportData(HttpServletResponse response) throws Exception {
		try {
			//备份数据
			String folderpath = exportBackupData();
			File sqlData = new File(folderpath);
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", "" + sqlData.length()); // XML文件大小
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("boss.sql", "UTF-8"));
			FileInputStream fis = new FileInputStream(sqlData);
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (fis.read(buffer) > 0) {
				toClient.write(buffer); // 输出数据
			}
			fis.close();
			toClient.flush();
			toClient.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	public String exportBackupData() {
		String fileSeparator = System.getProperty("file.separator");
		String lineSeparator = System.getProperty("line.separator");
		String osName = System.getProperty("os.name").toLowerCase();

		Properties props = getBackupProperties();
		String databaseIp = props.getProperty("databaseIp");
		String databasePort = props.getProperty("databasePort");
		String databaseUsername = props.getProperty("user");
		String databasePassword = props.getProperty("password");
		String backupFileNum = props.getProperty("backupFileNum");
		String databaseName = props.getProperty("databaseName");
		String datetime = Tools.getCurrentTime().replace(' ', '_')
				.replace(':', '.');
		String mysqlBinPath = props.getProperty("mysqlBinPath");
		if (mysqlBinPath == null || mysqlBinPath.trim().length() == 0) {
			
			String tempBackupPath = BackupDatabaseController.class.getResource("/")
					.getPath().replace("/", fileSeparator);
			mysqlBinPath = tempBackupPath.substring(0,
					tempBackupPath.indexOf("WEB-INF"))
					+ "database_backup";
			if (osName.startsWith("win")) {
				mysqlBinPath = "\"" + mysqlBinPath.substring(1) + fileSeparator + "mysqldump\"";
			} else if (osName.startsWith("lin")) {
				mysqlBinPath = "\"" + mysqlBinPath + fileSeparator + "mysqldump\"";
			}
		} else {
			mysqlBinPath = "\"" + mysqlBinPath + fileSeparator + "mysqldump\"";
		}
		String backupPath = null;
		String tempBackupPath = BackupDatabaseController.class.getResource("/")
				.getPath().replace("/", fileSeparator);
		backupPath = tempBackupPath.substring(0,
				tempBackupPath.indexOf("WEB-INF"))
				+ "database_backup";
		if (osName.startsWith("win")) {
			backupPath = backupPath.substring(1) + fileSeparator + "Windows";
		} else if (osName.startsWith("lin")) {
			backupPath = backupPath + fileSeparator + "Linux";
		}
		String backupFile = backupPath + fileSeparator + databaseName + "_"
				+ datetime + ".sql";
		
		ProcessBuilder processBuilder = null;
		StringBuffer stringBuffer = new StringBuffer();
		
		if (osName.startsWith("win")) {
			stringBuffer.append("@echo off" + lineSeparator);
			stringBuffer.append("if not exist \"" + backupPath + "\" md \""
					+ backupPath + "\"" + lineSeparator);
			stringBuffer.append(mysqlBinPath + " -h" + databaseIp + " -P"
					+ databasePort + " -u" + databaseUsername + " -p"
					+ databasePassword + " --single-transaction "
					+ databaseName + " > \"" + backupFile + "\""
					+ lineSeparator);
			stringBuffer.append("FOR /F \"skip=" + backupFileNum
					+ " tokens=*\" %i IN ('DIR \"" + backupPath + "\\"
					+ databaseName + "*.sql\" /TC /O-D /B') DO DEL \""
					+ backupPath + "\\%i\" /Q /F" + lineSeparator);
			stringBuffer.append("@echo on" + lineSeparator);
			stringBuffer.append("exit" + lineSeparator);

			processBuilder = new ProcessBuilder("cmd");
		} else if (osName.startsWith("lin")) {
			stringBuffer.append("if [ ! -d '" + backupPath
					+ "' ]; then mkdir -p '" + backupPath + "'; fi"
					+ lineSeparator);
			stringBuffer.append(mysqlBinPath + " -h" + databaseIp + " -P"
					+ databasePort + " -u" + databaseUsername + " -p"
					+ databasePassword + " --single-transaction "
					+ databaseName + " > '" + backupFile + "'" + lineSeparator);
			stringBuffer.append("cd '" + backupPath + "'" + lineSeparator);
			stringBuffer.append("count=$(ls -B " + databaseName
					+ "*.sql | wc -l)" + lineSeparator);
			stringBuffer.append("del_count=$(($count - " + backupFileNum + "))"
					+ lineSeparator);
			stringBuffer
					.append("if [ $del_count -gt 0 ]; then for i in `ls -trB "
							+ databaseName
							+ "*.sql | head -$del_count`; do rm -f $i; done; fi"
							+ lineSeparator);
			stringBuffer.append("exit" + lineSeparator);
			processBuilder = new ProcessBuilder("sh");
		} else {
			return null;
		}

		String command = stringBuffer.toString();
		
		
		try {
			Process process = processBuilder.start();
			OutputStreamWriter writer = new OutputStreamWriter(
					process.getOutputStream());
			writer.write(command);
			writer.flush();
			if (writer != null) {
				writer.close();
			}
			BufferedReader bufferReader = new BufferedReader(
					new InputStreamReader(process.getInputStream()));
			while (bufferReader.readLine() != null)
				;

			if (bufferReader != null) {
				bufferReader.close();
			}
			if (process.waitFor() != 0) {
				System.out.println("数据库备份出错！-------");
			} else {
				System.out.println("数据库备份成功！-------");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException ie) {
			ie.printStackTrace();
		}
		return backupFile;
	}
}
