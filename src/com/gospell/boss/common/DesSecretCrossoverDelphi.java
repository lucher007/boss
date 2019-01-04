package com.gospell.boss.common;

import java.security.SecureRandom;  

import javax.crypto.Cipher;  
import javax.crypto.SecretKey;  
import javax.crypto.SecretKeyFactory;  
import javax.crypto.spec.DESKeySpec; 

/**
 * 
 * Java与Delphi交叉DES加解密的问题
 * ——Java加密、Delphi解密，或 Delphi加密、Java解密。
 * 近日，手头上当前的项目进展到优化、完善阶段，其中一点是需要增强服务端与客户端通信的安全性，考虑采用对报文进行DES加密的方法来实现。
 * 服务端是Java编写的，客户端是Delphi编写的，原以为两端各自coding完进行个联调就OK了，结果发现同样的明文、密钥通过Delphi、Java所产生的密文是不同的。
 * 在网上搜索相关资源，得出结论：
 * 原来这是个普遍存在的问题，主要原因是不同的语言在明文的长度不够8byte倍数时，补充的字节各不相同所致。
 */

/** 
 * DES加解密,支持与delphi交互(字符串编码需统一为UTF-8) 
 *  
 * @author wym 
 */  
public class DesSecretCrossoverDelphi {
	/** 
     * 密钥 
     */  
    public static final String KEY = "GOSPELL_CHENDU";
  
    private final static String DES = "DES";  
    
    /** 
     * 加密 
     *  
     * @param src 
     *            明文(字节) 
     * @param key 
     *            密钥，长度必须是8的倍数 
     * @return 密文(字节) 
     * @throws Exception 
     */  
    public static byte[] encrypt(byte[] src, byte[] key) throws Exception {  
        // DES算法要求有一个可信任的随机数源  
        SecureRandom sr = new SecureRandom();  
        // 从原始密匙数据创建DESKeySpec对象  
        DESKeySpec dks = new DESKeySpec(key);  
        // 创建一个密匙工厂，然后用它把DESKeySpec转换成  
        // 一个SecretKey对象  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);  
        SecretKey securekey = keyFactory.generateSecret(dks);  
        // Cipher对象实际完成加密操作  
        Cipher cipher = Cipher.getInstance(DES);  
        // 用密匙初始化Cipher对象  
        cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);  
        // 现在，获取数据并加密  
        // 正式执行加密操作  
        return cipher.doFinal(src);  
    }  
  
    /** 
     * 解密 
     *  
     * @param src 
     *            密文(字节) 
     * @param key 
     *            密钥，长度必须是8的倍数 
     * @return 明文(字节) 
     * @throws Exception 
     */  
    public static byte[] decrypt(byte[] src, byte[] key) throws Exception {  
        // DES算法要求有一个可信任的随机数源  
        SecureRandom sr = new SecureRandom();  
        // 从原始密匙数据创建一个DESKeySpec对象  
        DESKeySpec dks = new DESKeySpec(key);  
        // 创建一个密匙工厂，然后用它把DESKeySpec对象转换成  
        // 一个SecretKey对象  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);  
        SecretKey securekey = keyFactory.generateSecret(dks);  
        // Cipher对象实际完成解密操作  
        Cipher cipher = Cipher.getInstance(DES);  
        // 用密匙初始化Cipher对象  
        cipher.init(Cipher.DECRYPT_MODE, securekey, sr);  
        // 现在，获取数据并解密  
        // 正式执行解密操作  
        return cipher.doFinal(src);  
    }  
  
    /** 
     * 加密 
     *  
     * @param src 
     *            明文(字节) 
     * @return 密文(字节) 
     * @throws Exception 
     */  
    public static byte[] encrypt(byte[] src) throws Exception {  
        return encrypt(src, KEY.getBytes());  
    }  
  
    /** 
     * 解密 
     *  
     * @param src 
     *            密文(字节) 
     * @return 明文(字节) 
     * @throws Exception 
     */  
    public static byte[] decrypt(byte[] src) throws Exception {  
        return decrypt(src, KEY.getBytes());  
    }  
  
    /** 
     * 加密 
     *  
     * @param src 
     *            明文(字符串) 
     * @return 密文(16进制字符串) 
     * @throws Exception 
     */  
    public final static String encrypt(String src) {  
        try {  
            return byte2hex(encrypt(src.getBytes(), KEY.getBytes()));  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
  
    /** 
     * 解密 
     *  
     * @param src 
     *            密文(字符串) 
     * @return 明文(字符串) 
     * @throws Exception 
     */  
    public final static String decrypt(String src) {  
        try {  
            return new String(decrypt(hex2byte(src.getBytes()), KEY.getBytes()));  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
  
    /** 
     * 加密 
     *  
     * @param src 
     *            明文(字节) 
     * @return 密文(16进制字符串) 
     * @throws Exception 
     */  
    public static String encryptToString(byte[] src) throws Exception {  
        return encrypt(new String(src));  
    }  
  
    /** 
     * 解密 
     *  
     * @param src 
     *            密文(字节) 
     * @return 明文(字符串) 
     * @throws Exception 
     */  
    public static String decryptToString(byte[] src) throws Exception {  
        return decrypt(new String(src));  
    }  
  
    public static String byte2hex(byte[] b) {  
        String hs = "";  
        String stmp = "";  
        for (int n = 0; n < b.length; n++) {  
            stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));  
            if (stmp.length() == 1)  
                hs = hs + "0" + stmp;  
            else  
                hs = hs + stmp;  
        }  
        return hs.toUpperCase();  
    }  
  
    public static byte[] hex2byte(byte[] b) {  
        if ((b.length % 2) != 0)  
            throw new IllegalArgumentException("长度不是偶数");  
        byte[] b2 = new byte[b.length / 2];  
        for (int n = 0; n < b.length; n += 2) {  
            String item = new String(b, n, 2);  
            b2[n / 2] = (byte) Integer.parseInt(item, 16);  
        }  
        return b2;  
    }  
  
    public static void main(String[] args) {  
        try {  
            String src = "雷震";  
            String crypto = encrypt(src);  
            System.out.println("密文[" + src + "]:" + crypto);  
            System.out.println("解密后:" + decrypt(crypto));  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  

}
