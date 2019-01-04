package test;


import java.sql.SQLException;

import org.apache.commons.lang.StringUtils;
import org.apache.ftpserver.ftplet.FtpException;

import com.gospell.boss.common.Tools;
public class LucheTest {
	public static void main(String[] strs) throws FtpException, ClassNotFoundException, SQLException {
//		String decodeEn = AesSecret.aesEncrypt("13232", "gospell");
//		System.out.println("加密后"+decodeEn);
//		String decodePass = AesSecret.aesDecrypt("z4sjZyjH6/1mxXxZo6Neew==", "gospell");
//		System.out.println("解密后"+decodePass);
		String str = "中国";
		System.out.println("GB:"+Tools.toCodeGB2312(str));
		System.out.println("BE:"+Tools.toUniCodeBE(str));
		System.out.println("LE:"+Tools.toUniCodeLE(str));
		
		String contentLenth=StringUtils.leftPad(Integer.toHexString(Tools.toCodeGB2312(str).length() / 2), 4, "0");
		System.out.println(contentLenth);
		
		String contentLenth1=StringUtils.leftPad(Integer.toHexString(Tools.toUniCodeBE(str).length() / 2), 4, "0");
		System.out.println(contentLenth1);
		
		String contentLenth2=StringUtils.leftPad(Integer.toHexString(Tools.toUniCodeLE(str).length() / 2), 4, "0");
		System.out.println(contentLenth2);
	}

}
