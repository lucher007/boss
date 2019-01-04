package com.gospell.boss.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gospell.boss.common.MpsApi;
import com.gospell.boss.common.Tools;
import com.gospell.boss.dao.IHelpinfoDao;
import com.gospell.boss.dao.IServerDao;
import com.gospell.boss.dao.ISystemparaDao;
import com.gospell.boss.po.Helpinfo;
import com.gospell.boss.po.Product;
import com.gospell.boss.po.Server;

/**
 * 用户控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/databaserestore")
@Transactional
public class DatabaserestoreController extends BaseController{
	
	@Autowired 
	private ServletContext servletContext;
	private final String FILE_NAME = "jdbc.properties";
	
	/**
	 * 数据库备份初始化
	 * @return
	 */
	@RequestMapping(value="/databaserestoreInit")
	public String databaserestoreInit(Model form) {
		return "databaserestore/databaserestore";
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/saveDatabaserestore")
	public String saveDatabaserestore(@RequestParam("uploadfile") MultipartFile file,Model form) throws IOException{
		// 得到页面上传的临时文件
		// XML上传服务器流文件
		String filename = file.getOriginalFilename();
		if (filename == null || "".equals(filename)) {
			form.addAttribute("returninfo", getMessage("uploadify.filename.null"));
			return databaserestoreInit(form);
		}
		// 文件类型
		String[] strArray = filename.split("[.]");
		String type = strArray[strArray.length - 1];
		if (!"sql".equals(type)) {
			form.addAttribute("returninfo", getMessage("uploadify.filetype.error"));
			return databaserestoreInit(form);
		}
		
		String import_template_path = servletContext.getInitParameter("import_template_path");
		String fullpath = servletContext.getRealPath(File.separator) + import_template_path + File.separatorChar + Tools.getNowRandom() + filename;
		File tmpFile = new File(fullpath);
		file.transferTo(tmpFile);
		
		//获取服务器系统
		Properties props = getBackupProperties();
		String databaseIp = props.getProperty("databaseIp");
		String databasePort = props.getProperty("databasePort");
		String databaseUsername = props.getProperty("user");
		String databasePassword = props.getProperty("password");
		String databaseName = props.getProperty("databaseName");
		
		String fileSeparator = System.getProperty("file.separator");
		String lineSeparator = System.getProperty("line.separator");
		String osName = System.getProperty("os.name").toLowerCase();
		
		ProcessBuilder processBuilder = null;
		StringBuffer stringBuffer = new StringBuffer();
		
		String tempDatabaserestorePath = DatabaserestoreController.class.getResource("/")
				.getPath().replace("/", fileSeparator);
		String mysqlBinPath = tempDatabaserestorePath.substring(0,
				tempDatabaserestorePath.indexOf("WEB-INF"))
				+ "database_backup";
		
		if (osName.startsWith("win")) {
			mysqlBinPath = "\"" + mysqlBinPath.substring(1) + fileSeparator + "mysql\"";
			stringBuffer.append("@echo off" + lineSeparator);
			stringBuffer.append(mysqlBinPath + " -h" + databaseIp 
					                         + " -P" + databasePort 
					                         + " -u" + databaseUsername 
					                         + " -p" + databasePassword 
					                         + "   " + databaseName 
					                         + " < \"" + fullpath + "\""
					                         + lineSeparator);
			stringBuffer.append("@echo on" + lineSeparator);
			stringBuffer.append("exit" + lineSeparator);
			processBuilder = new ProcessBuilder("cmd");
			
		} else if (osName.startsWith("lin")) {
			mysqlBinPath = "\"" + mysqlBinPath + fileSeparator + "mysql\"";
			stringBuffer.append(mysqlBinPath + " -h" + databaseIp 
					                         + " -P" + databasePort 
					                         + " -u" + databaseUsername 
					                         + " -p" + databasePassword 
					                         + "   " + databaseName 
					                         + " < '" + fullpath + "'" 
					                         + lineSeparator);
			stringBuffer.append("exit" + lineSeparator);
			processBuilder = new ProcessBuilder("sh");
		} else {
			System.out.println("*****"+getMessage("databaserestore.serversystem.error"));
			form.addAttribute("returninfo", getMessage("databaserestore.serversystem.error"));
			return databaserestoreInit(form);
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
				System.out.println("*****"+getMessage("databaserestore.fail"));
				form.addAttribute("returninfo", getMessage("databaserestore.fail"));
				return databaserestoreInit(form);
			} else {
				System.out.println("*****"+getMessage("databaserestore.success"));
				form.addAttribute("returninfo", getMessage("databaserestore.success"));
				return databaserestoreInit(form);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("*****"+getMessage("databaserestore.fail"));
			form.addAttribute("returninfo", getMessage("databaserestore.fail"));
			return databaserestoreInit(form);
		} finally{
			tmpFile.delete();
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
	
}
