package com.gospell.boss.common;

import java.awt.Image;
import java.awt.Label;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.Inet4Address;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;

public class Tools {
    private Calendar c = Calendar.getInstance();

    //工具
    public static String getDateMonthStr() {
        return (new SimpleDateFormat("yyyy-MM")).format(new Date());
    }

    public static String getDateYear() {
        return (new SimpleDateFormat("yyyy")).format(new Date());
    }

    public static String getNowRandom() {
        return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date())
                + random(16);
    }

    public static String getNowRandomTwo() {
        return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date())
                + random(2);
    }

    public static String getNowRandomThree() {
        return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date());
    }

    public static String getCurrentTime() {
        return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
    }
    
    public static String getCurrentTimeByFormat(String format) {
    	if(StringUtils.isEmpty(format)){
    		format = "yyyy-MM-dd HH:mm:ss";
    	}
        return (new SimpleDateFormat(format)).format(new Date());
    }

    public static String getDateMonthDayStr() {
        return (new SimpleDateFormat("yyyyMMdd")).format(new Date());
    }

    public static String getDateMonthDayStrTwo() {
        return (new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
    }

    public static String getLastYear() {
        Calendar curr = Calendar.getInstance();
        curr.set(Calendar.YEAR, curr.get(Calendar.YEAR) - 1);
        Date date = curr.getTime();
        return (new SimpleDateFormat("yyyy")).format(date);
    }

    
    
    public static String getDateUnix() {
        return String.valueOf(System.currentTimeMillis()).substring(0, 10);
    }
    
    /** 
     * 获取当前时间的前一天时间 
     * @param cl 
     * @return 
     */  
    @SuppressWarnings("unused")
	private static Calendar getBeforeDay(Calendar cl){  
        //使用roll方法进行向前回滚  
        //cl.roll(Calendar.DATE, -1);  
        //使用set方法直接进行设置  
        int day = cl.get(Calendar.DATE);  
        cl.set(Calendar.DATE, day-1);  
        return cl;  
    }  
      
    /** 
     * 获取当前时间的后一天时间 
     * @param cl 
     * @return 
     */  
    @SuppressWarnings("unused")
	private static Calendar getAfterDay(Calendar cl){  
        //使用roll方法进行回滚到后一天的时间  
        //cl.roll(Calendar.DATE, 1);  
        //使用set方法直接设置时间值  
        int day = cl.get(Calendar.DATE);  
        cl.set(Calendar.DATE, day+1);  
        return cl;  
    }  
    
    /** 
     * 获得指定日期的前几天 
     *  
     * @param specifiedDay 
     * @param format:yyyy-MM-dd 
     * @param days 相隔的天数
     * @return 
     * @throws Exception 
     */  
    public static String getSpecifiedDayBefore(String specifiedDay,String format,int days) {//可以用new Date().toLocalString()传递参数  
        Calendar c = Calendar.getInstance();  
        Date date = null;  
        try {  
            date = new SimpleDateFormat(format).parse(specifiedDay);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        }  
        c.setTime(date);  
        int day = c.get(Calendar.DATE);  
        c.set(Calendar.DATE, day - days);  
  
        String dayBefore = new SimpleDateFormat(format).format(c  
                .getTime());  
        return dayBefore;  
    }  
  
    /** 
     * 获得指定日期的后几天 
     *  
     * @param specifiedDay
     * @param format:yyyy-MM-dd 
     * @param days 相隔的天数
     * @return 
     */  
    public static String getSpecifiedDayAfter(String specifiedDay,String format,int days) {  
        Calendar c = Calendar.getInstance();  
        Date date = null;  
        try {  
            date = new SimpleDateFormat(format).parse(specifiedDay);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        }  
        c.setTime(date);  
        int day = c.get(Calendar.DATE);  
        c.set(Calendar.DATE, day + days);  
  
        String dayAfter = new SimpleDateFormat(format)  
                .format(c.getTime());  
        return dayAfter;  
    }  
    
    /** 
     * 获得指定日期的后几月
     *  
     * @param specifiedMonth
     * @param format:yyyy-MM-dd 
     * @param months 相隔的月数
     * @return 
     */  
    public static String getSpecifiedMonthAfter(String specifiedMonth,String format,int months) {  
        Calendar c = Calendar.getInstance();  
        Date date = null;  
        try {  
            date = new SimpleDateFormat(format).parse(specifiedMonth);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        }  
        c.setTime(date);  
        int month = c.get(Calendar.MONTH);  
        c.set(Calendar.MONTH, month + months);  
  
        String monthAfter = new SimpleDateFormat(format)  
                .format(c.getTime());  
        return monthAfter;  
    }  
    
    /** 
     * 获取时间相差的月数
     *  
     * @param start
     * @param end 
     * @return 
     */  
    public static int getMonth(Date start, Date end) {
        if (start.after(end)) {
            Date t = start;
            start = end;
            end = t;
        }
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(start);
        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTime(end);
        Calendar temp = Calendar.getInstance();
        temp.setTime(end);
        temp.add(Calendar.DATE, 1);

        int year = endCalendar.get(Calendar.YEAR)
                - startCalendar.get(Calendar.YEAR);
        int month = endCalendar.get(Calendar.MONTH)
                - startCalendar.get(Calendar.MONTH);

        if ((startCalendar.get(Calendar.DATE) == 1)
                && (temp.get(Calendar.DATE) == 1)) {
            return year * 12 + month + 1;
        } else if ((startCalendar.get(Calendar.DATE) != 1)
                && (temp.get(Calendar.DATE) == 1)) {
            return year * 12 + month;
        } else if ((startCalendar.get(Calendar.DATE) == 1)
                && (temp.get(Calendar.DATE) != 1)) {
            return year * 12 + month;
        } else {
            return (year * 12 + month - 1) < 0 ? 0 : (year * 12 + month);
        }
    }
    
    /** 
     * 获取时间相差的天数
     *  
     * @param start
     * @param end 
     * @return 
     */
    public static int differentDays(Date start, Date end) {

        Calendar aCalendar1 = Calendar.getInstance();
        aCalendar1.setTime(start);
        int day1 = aCalendar1.get(Calendar.DAY_OF_YEAR);
        int year1 = aCalendar1.get(Calendar.YEAR);

        Calendar aCalendar2 = Calendar.getInstance();
        aCalendar2.setTime(end);

        int day2 = aCalendar2.get(Calendar.DAY_OF_YEAR);
        int year2 = aCalendar2.get(Calendar.YEAR);
       
        if(year1 != year2){//不同年
            int timeDistance = 0 ;
            for(int i = year1 ; i < year2 ; i ++) {
                if(i%4==0 && i%100!=0 || i%400==0) {//闰年            
                    timeDistance += 366;
                } else {//不是闰年
                    timeDistance += 365;
                }
            }
            return timeDistance + (day2-day1) ;
        } else {//同一年
            return day2-day1;
        }

     }
    
    
    /** 
     * 对象赋值，objVO1 赋值给 objVO2
     *  
     * @param start
     * @param end 
     * @return 
     */
    public static void setVOToVO(Object objVO1, Object objVO2) {
        try {
            BeanUtils.copyProperties(objVO2, objVO1);
        } catch (Exception ex) {
            System.out.println("setVOToVO is Error!!!" + ex.getMessage());
        }
    }

    public static String random(int len) {
        long lng = new Random().nextLong();
        if (lng < 0) {
            lng = lng * (-1);
        }
        String lngStr = "" + lng;
        if (lngStr.length() < len) {
            lngStr += random(len - lngStr.length());
        } else {
            lngStr = lngStr.substring(0, len);
        }
        return lngStr;
    }

    public static String htmlCheck(String str) {
        if (str == null) {
            return null;
        } else {
            String fString = str;
            //fString = fString.replaceAll(";", "&#59;");
            fString = fString.replaceAll("<", "&lt;");
            fString = fString.replaceAll(">", "&gt;");
            fString = fString.replaceAll("\n", "");
            fString = fString.replaceAll("--", "&#45;&#45;");
            fString = fString.replaceAll("'", "&#39;");
            fString = fString.replaceAll("\"", "&#34;");
            //fString = fString.replaceAll("   ", "&nbsp;");
            fString = fString.replaceAll("%", "％");
            fString = fString.replaceAll("'", "‘");
            return fString;
        }
    }

    public static String decode(String str) {
        if (str == null) {
            return null;
        } else {
            String fString = str;
            //fString = fString.replaceAll("&nbsp;", "   ");
            fString = fString.replaceAll("&#34;", "\"");
            fString = fString.replaceAll("&#39;", "'");
            fString = fString.replaceAll("&#45;&#45;", "--");
            fString = fString.replaceAll("<br/>", "\n");
            fString = fString.replaceAll("&gt;", ">");
            fString = fString.replaceAll("&lt;", "<");
            //fString = fString.replaceAll("&#59;", ";");
            fString = fString.replaceAll("%", "％");
            fString = fString.replaceAll("'", "‘");
            return fString;
        }
    }

    public static String decodeSMS(String str) {
        if (str == null) {
            return null;
        } else {
            String fString = str;
            fString = fString.replaceAll("&#34;", "“");
            fString = fString.replaceAll("&#39;", "‘");
            fString = fString.replaceAll("&gt;", "＞");
            fString = fString.replaceAll("&lt;", "＜");
            fString = fString.replaceAll("<br/>", "\n");
            return fString;
        }
    }

    public static String decodeAll(String str) {
        if (str == null) {
            return null;
        } else {
            String fString = str;
            fString = fString.replaceAll("&nbsp;", "   ");
            fString = fString.replaceAll("&#34;", "”");
            fString = fString.replaceAll("&#39;", "‘");
            fString = fString.replaceAll("&#45;&#45;", "－－");
            fString = fString.replaceAll("<br/>", "\r\n");
            fString = fString.replaceAll("<BR>", "\r\n");
            fString = fString.replaceAll("<br>", "\r\n");
            fString = fString.replaceAll("&gt;", "＞");
            fString = fString.replaceAll("&lt;", "＜");
            fString = fString.replaceAll("&#59;", "；");
            fString = fString.replaceAll("%", "％");
            fString = fString.replaceAll("'", "‘");
            fString = fString.replaceAll("&#8226;", "\267");
            fString = fString.replaceAll("&#100000001;", "\267");
            fString = fString.replaceAll("&#100000002;", "，");
            fString = fString.replaceAll("&#100000003;", "？");
            fString = fString.replaceAll("&#100000004;", "!");
            fString = fString.replaceAll("&#100000005;", "。");
            fString = fString.replaceAll("&#100000006;", "《");
            fString = fString.replaceAll("&#100000007;", "》");
            fString = fString.replaceAll("&#100000008;", "【");
            fString = fString.replaceAll("&#100000009;", "】");
            fString = fString.replaceAll("&#1000000010;", "—");
            fString = fString.replaceAll("&#1000000011;", "%");
            fString = fString.replaceAll("&#1000000012;", "-");
            fString = fString.replaceAll("&#1000000013;", "…");
            fString = fString.replaceAll("&#1000000014;", "~");
            fString = fString.replaceAll("&#1000000015;", "“");
            fString = fString.replaceAll("&#1000000016;", "”");
            fString = fString.replaceAll("&#1000000017;", "；");
            fString = fString.replaceAll("&#1000000018;", "’");
            fString = fString.replaceAll("&#1000000019;", "‘");
            fString = fString.replaceAll("&#1000000020;", "、");
            fString = fString.replaceAll("&#1000000021;", "/");
            fString = fString.replaceAll("&#1000000022;", "@");
            fString = fString.replaceAll("&#1000000023;", "（");
            fString = fString.replaceAll("&#1000000024;", "）");
            fString = fString.replaceAll("&#1000000025;", "＝");
            fString = fString.replaceAll("&#1000000026;", "＋");
            return fString;
        }
    }

    public static String getStringBetween(String src, String beginStr,
                                          String endStr) {
        int beginIndex = src.indexOf(beginStr);
        if (beginIndex < 0) {
            return "";
        }
        String leftStr = src.substring(beginIndex + beginStr.length(), src
                .length());
        int endIndex = leftStr.indexOf(endStr);
        if (endIndex < 0) {
            return "";
        }
        return leftStr.substring(0, endIndex);
    }

    public static String getLastStrByLastStr(String src, String str) {
        int i = src.lastIndexOf(str);
        if (i < 0) {
            return "";
        }
        return src.substring(i + str.length());
    }

    public static String getLastStrByFirstStr(String src, String str) {
        int i = src.indexOf(str);
        if (i < 0) {
            return "";
        }
        return src.substring(i + str.length());
    }

    public static String getStrend(String str) {
        String[] strVale = str.split("[.]");
        int Maxs = (strVale.length) - 1;
        str = strVale[Maxs];
        return str;
    }

    public static String copyFile(String root, String folder, String src) {
        String srcFileName = getLastStrByLastStr(src, "resources");
        if (srcFileName.length() < 1) {
            return "";
        }
        srcFileName = "resources" + srcFileName;
        String srcFilePath = getLastStrByLastStr(src, "/");
        if (srcFilePath.length() < 1) {
            return "";
        }
        System.out.println(root + srcFileName);
        System.out.println(root + folder + srcFilePath);
        if (copyFiles(root + srcFileName, root + folder + srcFilePath)) {
            return srcFilePath;
        }
        return "";
    }

    public static boolean copyFiles(String oldPath, String newPath) {
        try {
            System.out.println("oldPath====" + oldPath);
            System.out.println("newPath====" + newPath);
            int bytesum = 0;
            int byteread = 0;
            File oldfile = new File(oldPath);
            if (oldfile.exists()) {
                InputStream inStream = new FileInputStream(oldPath);
                FileOutputStream fs = new FileOutputStream(newPath);
                byte[] buffer = new byte[2048];
                while ((byteread = inStream.read(buffer)) != -1) {
                    bytesum += byteread;
                    System.out.println(bytesum);
                    fs.write(buffer, 0, byteread);
                }
                inStream.close();
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String copyFilesString(String oldPath, String newPath) {
        String newName = "";
        try {
            int bytesum = 0;
            int byteread = 0;
            File oldfile = new File(oldPath);
            if (oldfile.exists()) {
                InputStream inStream = new FileInputStream(oldPath);
                FileOutputStream fs = new FileOutputStream(newPath);
                byte[] buffer = new byte[1444];
                while ((byteread = inStream.read(buffer)) != -1) {
                    bytesum += byteread;
                    fs.write(buffer, 0, byteread);
                }
                inStream.close();

                return newName = newPath;
            } else {
                return newName;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return newName;
        }
    }

    public static void delFolder(String folderPath) {
        try {
            delAllFile(folderPath);
            String filePath = folderPath;
            filePath = filePath.toString();
            java.io.File myFilePath = new java.io.File(filePath);
            myFilePath.delete();

        } catch (Exception e) {
            e.printStackTrace();

        }

    }

    public static void delAllFile(String path) {
        File file = new File(path);
        if (!file.exists()) {
            return;
        }
        if (!file.isDirectory()) {
            return;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);
                delFolder(path + "/" + tempList[i]);
            }
        }
    }

    public static boolean newFile(String filePathAndName, String fileContent) {
        try {
            String filePath = filePathAndName;
            filePath = filePath.toString();
            File myFilePath = new File(filePath);
            if (!myFilePath.exists()) {
                myFilePath.createNewFile();
            }
            FileWriter resultFile = new FileWriter(myFilePath);
            PrintWriter myFile = new PrintWriter(resultFile);
            String strContent = fileContent;
            myFile.println(strContent);
            resultFile.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static float checkSize(String path) {
        float allsize = 0;
        File f = new File(path);
        if (!f.exists()) {
            return allsize;
        }
        File fa[] = f.listFiles();
        long allsizetemp = 0;
        for (int i = 0; i < fa.length; i++) {
            File fs = fa[i];
            if (fs.isDirectory()) {

            } else {
                allsizetemp += fs.length();
            }
        }
        allsize = (float) (Math.round(allsizetemp / 1024 * 100)) / 100;
        return allsize;
    }

    public static Integer addtract_Integer(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.add(b2).intValue();
    }

    public static Integer subtract_Integer(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.subtract(b2).intValue();
    }

    //加
    public static Double addtr(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.add(b2).doubleValue();
    }

    //减
    public static Double subtr(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.subtract(b2).doubleValue();
    }

    //乘
    public static Double multiply(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.multiply(b2).doubleValue();
    }

    //除
    public static Double division(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.divide(b2).doubleValue();
    }

    public static Image bytesToImage(byte[] bytes) {
        Image image = Toolkit.getDefaultToolkit().createImage(bytes);
        try {
            MediaTracker mt = new MediaTracker(new Label());
            mt.addImage(image, 0);
            mt.waitForAll();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return image;
    }

    public static File getFileFromBytes(byte[] b, String outputFile) {
        BufferedOutputStream stream = null;
        File file = null;
        try {
            file = new File(outputFile);
            FileOutputStream fstream = new FileOutputStream(file);
            stream = new BufferedOutputStream(fstream);
            stream.write(b);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stream != null) {
                try {
                    stream.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }
        return file;
    }

    public static float floatformat(float f) {
        DecimalFormat formater = new DecimalFormat("#0.###");
        return Float.valueOf(formater.format(f));
    }

    /*
     * 转为UTF-8
     */
    public static String toUtf8String(String s) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= 0 && c <= 255) {
                sb.append(c);
            } else {
                byte[] b;
                try {
                    b = Character.toString(c).getBytes("ISO-8859-1");
                } catch (Exception ex) {
                    System.out.println(ex);
                    b = new byte[0];
                }
                for (int j = 0; j < b.length; j++) {
                    int k = b[j];
                    if (k < 0)
                        k += 256;
                    sb.append("%" + Integer.toHexString(k).toUpperCase());
                }
            }
        }
        return sb.toString();
    }

    /**
     * 获取每个月第一天
     *
     * @param sYear
     * @param sMonth
     * @return
     */
    public String getFirstDayofMonth(int sYear, int sMonth) {
        String tStartdate = "";
        String month_str = "";
        String day_str = "";
        c.set(c.YEAR, sYear);
        c.set(c.MONTH, sMonth);

        if (sMonth < 10) {
            month_str = "0" + String.valueOf(sMonth);
        } else {
            month_str = String.valueOf(sMonth);
        }

        if (c.getActualMinimum(c.DAY_OF_MONTH) < 10) {
            day_str = "0" + c.getActualMinimum(c.DAY_OF_MONTH);
        } else {
            day_str = String.valueOf(c.getActualMinimum(c.DAY_OF_MONTH));
        }

        tStartdate = String.valueOf(sYear) + "-" + month_str + "-"
                + day_str;

        return tStartdate;
    }

    /**
     * 获取每个月最后一天
     *
     * @param sYear
     * @param sMonth
     * @return
     */
    public String getEndDayofMonth(int sYear, int sMonth) {
        String tEnddate = "";
        String month_str = "";
        String day_str = "";
        c.set(c.YEAR, sYear);
        c.set(c.MONTH, sMonth);

        if (sMonth < 10) {
            month_str = "0" + String.valueOf(sMonth);
        } else {
            month_str = String.valueOf(sMonth);
        }

        if (c.getActualMaximum(c.DAY_OF_MONTH) < 10) {
            day_str = "0" + c.getActualMaximum(c.DAY_OF_MONTH);
        } else {
            day_str = String.valueOf(c.getActualMaximum(c.DAY_OF_MONTH) - 1);
        }

        tEnddate = String.valueOf(sYear) + "-" + month_str + "-"
                + day_str;
        return tEnddate;
    }

    public String getMonth() {
        return (new SimpleDateFormat("MM")).format(new Date());
    }

    private static int[] w = null;


    // 生成校验码 ,code 为除了校验位的其他数据，企业 13 位，产品 19 位等 

    public static String getCheckCode(String code) {
        String str = "";
        int codelength = 0;
        if (w == null) {
            w = new int[34];
            for (int i = 0; i < 34; i++) {
                w[i] = ((int) Math.pow(3, i + 1)) % 10;
            }
        }
        codelength = code.length();
        if (codelength > 34) return null;
        int[] f = new int[codelength];
        for (int i = 0; i < codelength; i++) {
            f[i] = Integer.parseInt(code.substring(codelength - i - 1, codelength - i));
        }
        int s = 0;
        for (int i = 0; i < codelength; i++) {
            s = s + w[i] * f[i];
        }
        str = String.valueOf(s % 10);
        return str;
    }


    /**
     * 将时间截取成11位
     *
     * @param date
     * @return
     */
    public static String formatDate(String date) {
        return date != null ? date.substring(0, 11) : "";
    }

    /**
     * 将float转变成String
     *
     * @param value
     * @return
     */
    public static String stringToFloat(Float value) {
        return value != null ? String.valueOf(value) : "";
    }

    public static String isCheck(String value) {
        return value.equals("0") ? "否" : "是";
    }

    /**
     * 将double转变成String
     *
     * @param value
     * @return
     */
    public static String doubleToString(Double value) {
        return value != null ? String.valueOf(value) : "";
    }

    public static String removeNullString(Object input) {
        String inputStr = "";

        inputStr = (String) input;

        if (input == null)
            inputStr = "";
        else if (input.equals("null"))
            inputStr = "";
        else {
            inputStr = (String) input;
            inputStr = inputStr.replaceAll(" ", "");
        }
        return inputStr;
    }

    public static Double dealNullDouble(Object obj, double dValue) {
        double values = 0;
        try {
//            values=(Double)obj;
            values = Double.parseDouble(obj.toString());
        } catch (Exception ex) {
            System.out.println("dealNullDouble:" + ex.getMessage());
            values = dValue;
        }
        return values;
    }

    public static int dealNullInt(Object obj, int i) {
        int values = 0;
        try {
            if (obj != null) {
                String tmp = obj.toString();
                values = Integer.parseInt(tmp);
            } else {
                values = i;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            values = i;
        }
        return values;
    }

    /**
     * @param res 源字符串
     * @return md5值
     */
    public final static String MD5(String res) {
        char hexDigits[] =
                {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
                        'e', 'f'};
        try {
            byte[] strTemp = res.getBytes();
            MessageDigest mdTemp = MessageDigest.getInstance("MD5");
            mdTemp.update(strTemp);
            byte[] md = mdTemp.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            String result = new String(str);
            return result;
        } catch (Exception e) {
            return null;
        }
    }

    public static String scienceToString(Double d) {
        NumberFormat formatter = NumberFormat.getNumberInstance();
        formatter.setMaximumFractionDigits(30);
        return formatter.format(d).replaceAll(",", "");
    }

    public static void printJson(HttpServletResponse response, String json) {
        System.out.println(json);
        PrintWriter out = null;
        try {
            response.setContentType("text/javascript;charset=UTF-8");
            response.setHeader("Cache-Control", "no-store, max-age=0, no-cache, must-revalidate");
            response.addHeader("Cache-Control", "post-check=0, pre-check=0");
            response.setHeader("Pragma", "no-cache");

            out = response.getWriter();

            out.print(json);


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }


    public static String getRealIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip != null) {
            if (ip.indexOf(',') == -1) {
                return ip;
            }
            return ip.split(",")[0];
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = req.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = req.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = req.getRemoteAddr();
        }

        return ip;
    }


    //文件转成byte
    public static byte[] getBytesFromFile(File file) throws IOException {
        //file size
        long length = file.length();
        InputStream is = null;
        is = new BufferedInputStream(new FileInputStream(file));
        if (length > Integer.MAX_VALUE) {
            throw new IOException("File is to large " + file.getName());
        }
        byte[] bytes = new byte[(int) length];
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
            offset += numRead;
        }
        if (offset < bytes.length) {
            throw new IOException("Could not completely read file " + file.getName());
        }
        is.close();
        return bytes;

    }

    /**
     * 获取2个时间之间的秒钟差
     *
     * @param endtime
     * @param startTime
     * @param formatStr 例子(yyyy-MM-dd HH:mm:ss)
     * @return
     */
    public static long diffTime(String endtime, String startTime,String formatStr) {
        long second = 0l;
        try {
            DateFormat df = new SimpleDateFormat(formatStr);
            Date d1 = df.parse(endtime);
            Date d2 = df.parse(startTime);
            long diff = d1.getTime() - d2.getTime();
            second = diff / (1000);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return second;
    }
    
    /**
     * 字符串转成DATE格式
     *
     * @param endtime
     * @param startTime
     * @param formatStr 例子(yyyy-MM-dd HH:mm:ss)
     * @return
     */
    public static Date getDateFromStr(String time, String formatStr) {
    	Date date = null;
        try {
            DateFormat df = new SimpleDateFormat(formatStr);
            date = df.parse(time);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return date;
    }
    
    /**
     * 字符串转成DATE格式
     *
     * @param endtime
     * @param startTime
     * @param formatStr 例子(yyyy-MM-dd HH:mm:ss)
     * @return
     */
    public static Date getDateFromStr(String time, String formatStr, String zone) {
    	Date date = null;
        try {
            DateFormat df = new SimpleDateFormat(formatStr);
            df.setTimeZone(TimeZone.getTimeZone(zone));
            date = df.parse(time);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return date;
    }

    /**
     * 比较俩个时间先后
     *
     * @param DATE1-第一个时间
     * @param DATE2-第二个时间
     * @param formatStr-字符串时间格式，例子(yyyy-MM-dd HH:mm:ss)
     * @param  
     * @return 1:DATE1在DATE2之后；-1：DATE1在DATE2之前；0-相等
     */
    public static int compare_date(String DATE1, String DATE2,String formatStr) {
        DateFormat df = new SimpleDateFormat(formatStr);
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                //System.out.println("dt1 在dt2后");
                return 1;
            } else if (dt1.getTime() < dt2.getTime()) {
                //System.out.println("dt1在dt2前");
                return -1;
            } else {
                return 0;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return 0;
    }
    
    
    
    /**
     * 加密
     *
     * @param content  需要加密的内容
     * @param password 加密密码
     * @return
     */
    public static String encrypt(String content, byte[] key, byte[] iv) {
        try {
            SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
            IvParameterSpec ivSpec = new IvParameterSpec(iv);
            Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
            byte[] result = cipher.doFinal(content.getBytes("GB2312"));
            return Base16.encode(result); // 加密
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 解密
     *
     * @param content  待解密内容
     * @param password 解密密钥
     * @return
     */
    public static String decrypt(String content, byte[] key, byte[] iv) {
        try {
            SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
            IvParameterSpec ivSpec = new IvParameterSpec(iv);
            Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
            cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
            byte[] result = cipher.doFinal(Base16.decode(content));
            return new String(result, "GB2312"); // 加密
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将二进制转换成16进制
     *
     * @param buf
     * @return
     */
    public static String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     * 将16进制转换为二进制
     *
     * @param hexStr
     * @return
     */
    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

    public static String cipherPadding(String content) {
        int pad = content.length() % 16;
        if (0 != pad) {
            for (int i = 0; i < (16 - pad); i++) {
                content += "=";
            }
        }
        return content;
    }

    public static String cipherCutoff(String content) {
        int num = content.indexOf("\"}=") + 3;
        int length = content.length();
        if (num == -1) {
            return "false";
        }
        if (length != num) {
            int numsub = num;
            int flag = 0;
            for (int i = 0; i < content.length() - num; i++) {
                if (!content.substring(numsub, numsub + 1).equals("=")) {
                    flag = 1;
                    break;
                }
                numsub = numsub + 1;
            }
            if (flag == 1) {
                return "false";
            }
        }
        return content.substring(0, num - 1);
    }

    public static boolean cipherJudgement(String content) {
        int pad = content.length() % 16;
        if (0 == pad) {
            return true;
        } else {
            return false;
        }
    }

    public static String addMonth(String cur_time, int m) {
        String str = "";
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c = Calendar.getInstance();
            c.setTime(df.parse(cur_time));
            c.add(Calendar.MONTH, m);    //传入时间增加月份
            Date date = c.getTime();
            str = df.format(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }
    
    public static String addDay(String cur_time, int m) {
        String str = "";
        try {
        	
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c = Calendar.getInstance();
            c.setTime(df.parse(cur_time));
            
            c.add(Calendar.DATE, m);    //传入时间增加月份
            Date date = c.getTime();
            str = df.format(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }
    
    public static String lastDayOfMonth(String cur_time) {
        String lasday = "";
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.setTime(df.parse(cur_time));
            int value = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            cal.set(Calendar.DAY_OF_MONTH, value);
            lasday = df.format(cal.getTime());
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(lasday);
        return lasday;
    }


    public static String getStr(String str) {
        if (str == null || "".equals(str)) {
            return "";
        } else {
            return str;
        }
    }
    
    
    public static BigDecimal getBigDecimal (BigDecimal value) {
        return value != null ? value : new BigDecimal("0");
    }

    /**
     * 获取各国语言简写(ISO 639-1 Code)
     *
     * @param buf 代码list[i].getDisplayCountry(locale)中为其传入了一个ENGLISH的locale对象，
     *            目的是获得当前地区的英文拼写，便于在前台按照字典顺序显示国家以及相应的语言
     * @return
     */
    public static List<Map.Entry<String, String>> getAllLanguagesMapForISO639_1_Code() {
        Map<String, String> languageMap = new HashMap<String, String>();
        Locale locale = new Locale("Enlish");//代码list[i].getDisplayCountry(locale)中为其传入了一个ENGLISH的locale对象，目的是获得当前地区的英文拼写，便于在前台按照字典顺序显示国家以及相应的语言
        Locale[] list = Locale.getAvailableLocales();
        for (int i = 0; i < list.length; i++) {
            if (StringUtils.isNotEmpty(list[i].getDisplayCountry())) {
                String key = list[i].getLanguage() + "_" + list[i].getCountry();
                String value = list[i].getDisplayCountry(locale) + " "//获得国家英文拼写，如中国China
                        + list[i].getDisplayCountry() + "("//获得国家的本国拼写，如中国 中国
                        + list[i].getDisplayLanguage() + ") " //获得国家的语言，例如中国 中文              + list[i].getLanguage() + "_"
                        + list[i].getLanguage() + "_" + list[i].getCountry();//获得该国语言的代码 如中国 中文 zh_CN
                if (languageMap.containsKey(key)) {
                    continue;
                } else {
                    languageMap.put(key, value);
                }
            }
        }

        //按照国家英文名称来实现排序
        List<Map.Entry<String, String>> languagelist =
                new ArrayList<Map.Entry<String, String>>(languageMap.entrySet());
        //排序
        Collections.sort(languagelist, new Comparator<Map.Entry<String, String>>() {
            public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
                //return (o2.getValue() - o1.getValue());
                return (o1.getValue()).toString().compareTo(o2.getValue());
            }
        });
        return languagelist;
    }

    /**
     * 获取各国语言简写(ISO 639-3 Code)
     *
     * @param buf 代码list[i].getDisplayCountry(locale)中为其传入了一个ENGLISH的locale对象，
     *            目的是获得当前地区的英文拼写，便于在前台按照字典顺序显示国家以及相应的语言
     * @return
     */
    public static List<Map.Entry<String, String>> getAllLanguagesMapForISO639_3_Code() {
        Map<String, String> languageMap = new HashMap<String, String>();
        Locale locale = new Locale("Enlish");//代码list[i].getDisplayCountry(locale)中为其传入了一个ENGLISH的locale对象，目的是获得当前地区的英文拼写，便于在前台按照字典顺序显示国家以及相应的语言
        Locale[] list = Locale.getAvailableLocales();
        for (int i = 0; i < list.length; i++) {
            if (StringUtils.isNotEmpty(list[i].getDisplayCountry(locale))) {
                String key = list[i].getISO3Language() + list[i].getCountry();
                String value = list[i].getDisplayCountry(locale) + " "//获得国家英文拼写，如中国China
                        + list[i].getDisplayCountry() + "("//获得国家的本国拼写，如中国 中国
                        + list[i].getDisplayLanguage() + ") " //获得国家的语言，例如中国 中文              + list[i].getLanguage() + "_"
                        + list[i].getISO3Language() + "_" + list[i].getCountry();//获得该国语言的代码 如中国 中文 zh_CN
                if (languageMap.containsKey(key)) {
                    continue;
                } else {
                    languageMap.put(key, value);
                }
            }
        }

        //按照国家英文名称来实现排序
        List<Map.Entry<String, String>> languagelist =
                new ArrayList<Map.Entry<String, String>>(languageMap.entrySet());
        //排序
        Collections.sort(languagelist, new Comparator<Map.Entry<String, String>>() {
            public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
                //return (o2.getValue() - o1.getValue());
                return (o1.getValue()).toString().compareTo(o2.getValue());
            }
        });
        return languagelist;
    }

    public static Map<String, String> getLanguagesMapForISO639_3_Code() {
        Locale engLocale = Locale.ENGLISH;
        String key = null;
        String value = null;
        Map<String, String> langMap = new TreeMap<String, String>();
        Locale[] locales = Locale.getAvailableLocales();
        for (Locale locale : locales) {
            if (!locale.getDisplayCountry(engLocale).isEmpty()) {
                key = locale.getISO3Language();
                value = locale.getISO3Language().toUpperCase() + locale.getDisplayLanguage();
                langMap.put(key, value);
            }
        }
        langMap.put("chi", "CHI中文");
        return langMap;
    }

    public static Map<String, String> getCountrysMapForISO639_3_Code() {
        Locale engLocale = Locale.ENGLISH;
        String key = null;
        String value = null;
        Map<String, String> langMap = new TreeMap<String, String>();
        Locale[] locales = Locale.getAvailableLocales();
        for (Locale locale : locales) {
            if (!locale.getDisplayCountry(engLocale).isEmpty()) {
                try {
                    key = locale.getISO3Country();
                    value = locale.getDisplayCountry(engLocale) + " "//获得国家英文拼写，如中国China
                            + locale.getDisplayCountry();
                    langMap.put(key, value);
                } catch (Exception e) {
                    continue;
                }
            }
        }
        return langMap;
    }

    /**
     * 将字符串的每个字符转为length个十六进制字符
     */
    public static String stringToHex(String orig, int length) {
        if (orig == null || orig.isEmpty()) {
            return "";
        }
        char[] chars = orig.toCharArray();
        StringBuilder sb = new StringBuilder();
        String hexChar;
        int n;
        for (char c : chars) {
            hexChar = Integer.toHexString(c);
            n = length - hexChar.length();
            for (int i = 0; i < n; i++) {
                hexChar = "0" + hexChar;
            }
            sb.append(hexChar);
        }
        return sb.toString();
    }

    /**
     * 将字符串的每个字符转为length个二进制字符
     */
    public static String stringToBinary(String orig, int length) {
        if (orig == null || orig.isEmpty()) {
            return "";
        }
        char[] chars = orig.toCharArray();
        StringBuilder sb = new StringBuilder();
        String binChar;
        int n;
        for (char c : chars) {
            binChar = Integer.toBinaryString(c);
            n = length - binChar.length();
            for (int i = 0; i < n; i++) {
                binChar = "0" + binChar;
            }
            sb.append(binChar);
        }
        return sb.toString();
    }

    /**
     * 将length个radix进制字符串解析成一个字符，str的长度需为length的倍数，否则返回空串
     *
     */
    public static String radixToString(String str, int radix, int length) {
        StringBuilder target = new StringBuilder();
        int strLength = str.length();
        if (strLength % length == 0) {
            char c;
            for (int i = 0; i < strLength; i += length) {
                c = (char) Integer.parseInt(str.substring(i, i + length), radix);
                target.append(c);
            }
        }
        return target.toString();
    }

    /**
     * 将int转换为长度为length的大写的16进制的字符串，
     * 长度不够在左添0，长度超出则不变
     */
    public static String intToHexString(int i, int length) {
        String hexStr = Integer.toHexString(i);
        return addZero(hexStr, length).toUpperCase();
    }

    /**
     * 将data转换为2进制长度为length的字符串，长度不够在左添0，长度超出则不变
     */
    public static String intToBinaryString(int data, int length) {
        String binStr = Integer.toBinaryString(data);
        return addZero(binStr, length);
    }

    /**
     * 在字符串的前面加0满足字符串长度为length，
     * 若原字符串长度超出length则返回原字符串
     * 若原字符串为null则返回null
     */
    public static String addZero(String orig, int length) {
        if (orig == null) {
            return null;
        } else {
            StringBuilder data = new StringBuilder();
            int n = length - orig.length();
            for (int i = 0; i < n; i++) {
                data.append("0");
            }
            data.append(orig);
            return data.toString();
        }
    }

    /**
     *
     * @param orig 只能包含一个或不包含小数点的字符串
     * @param beforeLength 小数点前的字符数
     * @param afterLength 小数点后的字符数
     * @return 总长度为beforeLength与afterLength之和的无小数点形式的字符串，
     * 若orig为null，则返回同样总长度的字符串“000..."
     */
    public static String getBcdCode(String orig, int beforeLength, int afterLength) {
        if (beforeLength < 0 || afterLength < 0) {
            return "";
        }
        if (orig == null) {
            return addZero("", beforeLength + afterLength);
        }
        String[] strs = orig.split("\\.");
        if (strs.length == 1) {
            return addZero(strs[0], beforeLength) + addZero("", afterLength);
        } else {
            return addZero(strs[0], beforeLength) + strs[1]
                    + addZero("", afterLength - strs[1].length());
        }
    }

    /**
    * 获取本机名称
    */
   public static String getLocalHostName() {  
       String hostName;  
       try {  
           InetAddress addr = InetAddress.getLocalHost();  
           hostName = addr.getHostName();  
       } catch (Exception ex) {  
           hostName = "";  
       }  
       return hostName;  
   }  
   
   /**
    * 获取本机所有Ip地址
    * iptype ipv4-获取所有ipv4的IP，ipv6-获取所有ipv6的Ip
    */
   @SuppressWarnings({ "rawtypes", "unchecked" })
   public static List getAllLocalHostIP(String iptype) {  
	    List iplist= new ArrayList();
	    try {  
	        String hostName = getLocalHostName();  
	        if (hostName.length() > 0) {  
	            InetAddress[] addrs = InetAddress.getAllByName(hostName);  
	                for (int i = 0; addrs.length > 0 && i < addrs.length; i++) {  
	                	if("ipv4".equals(iptype)){
	                		if (addrs[i] instanceof Inet4Address) {
	                			iplist.add(addrs[i].getHostAddress());  
		                	}
	                	} else if("ipv6".equals(iptype)){
	                		if (addrs[i] instanceof Inet6Address) {
	                			iplist.add(addrs[i].getHostAddress());  
		                	}
	                	}
	            }  
	        }  
        } catch (Exception ex) {  
           ex.printStackTrace();
        }  
        return iplist;  
	}  
   
	   /**
	   * 字符串转GB2312编码
	   * 源字符串str
	   * @return 源字符串的GB2312编码
	   */
	public static String toCodeGB2312(String str) {
		  StringBuffer newStr = new StringBuffer("");
		  try {
			  byte[] bArr = str.getBytes("GB2312");
			  for (int i = 0; i < bArr.length; i++) {
				  newStr.append(autoFillStrLeft(Integer.toHexString(bArr[i] & 0xFF), 2, "0"));
			  }
		  } catch (UnsupportedEncodingException e) {
			  e.printStackTrace();
		  }
		  return newStr.toString();
	}
	/**
	   * 字符串转UniCode-LE编码
	   * 源字符串str
	   * @return 源字符串的UniCode-LE编码
	   */
	public static String toUniCodeLE(String str) {
		 StringBuffer newStr = new StringBuffer("");
		  try {
			  byte[] bArr = str.getBytes("UTF-16LE");
			  for (int i = 0; i < bArr.length; i++) {
				  newStr.append(autoFillStrLeft(Integer.toHexString(bArr[i] & 0xFF), 2, "0"));
			  }
		  } catch (UnsupportedEncodingException e) {
			  e.printStackTrace();
		  }
		  return newStr.toString();
	}
	/**
	 * 字符串转UniCode-BE编码
	 * 源字符串str
	 * @return 源字符串的UniCode-BE编码
	 */
	public static String toUniCodeBE(String str) {
		 StringBuffer newStr = new StringBuffer("");
		  try {
			  byte[] bArr = str.getBytes("UTF-16BE");
			  for (int i = 0; i < bArr.length; i++) {
				  newStr.append(autoFillStrLeft(Integer.toHexString(bArr[i] & 0xFF), 2, "0"));
			  }
		  } catch (UnsupportedEncodingException e) {
			  e.printStackTrace();
		  }
		  return newStr.toString();
		
	}
	   
	/** 
	 * 字符串前面前面填充不足位
	 * 源字符串str 填充内容fillStr 填充之后的总位数length
	 * 
	 * @param str 源字符串
	 * @param fillStr 填充内容
	 * @return String 返回后置填充好的字符串
	 */
	 public static String autoFillStrLeft(String str,int length,String fillStr){
		  StringBuffer newStr = new StringBuffer(str);
	      for (int i = 0; i < length - str.length(); i++) {
	    	  newStr = new StringBuffer(fillStr).append(newStr); 
	      }
	      return newStr.toString();
	 }  
	  
	  
	 /**
	     * 字符串后面填充不足位
		 * 源字符串str 填充内容fillStr 填充之后的总位数length
		 * 
		 * @param str 源字符串
		 * @param fillStr 填充内容
		 * @return String 返回后置填充好的字符串
		 */
	  public static String autoFillStrAfter(String str, int length, String fillStr) {
		  StringBuffer newStr = new StringBuffer(str);
		  for (int i = 0; i < length - str.length(); i++) {
			  newStr.append(fillStr);
		  }
		  return newStr.toString();
	  }
	  
	  /**
	     * 字符串前面面填充不足位
		 * 源字符串str 填充内容fillStr 填充之后的总位数length
		 * 
		 * @param str 源字符串
		 * @param fillStr 填充内容
		 * @return String 返回后置填充好的字符串
		 */
	  public static String autoFillStr(String str,int length,String fillStr){
		  StringBuffer newStr = new StringBuffer(str);
	      for (int i = 0; i < length - str.length(); i++) {
	    	  newStr = new StringBuffer(fillStr).append(newStr); 
	      }
	      return newStr.toString();
	  }
	  
	  
	  /**
	     * 十六进制字符串转换成bytes
		 */
	  public static byte[] HexString2Bytes(String src){ 
		  byte[] tmp = src.getBytes(); 
		  byte[] ret = new byte[tmp.length/2]; 
		  for(int i=0; i<tmp.length/2; i++){ 
		  ret[i] = uniteBytes(tmp[i*2], tmp[i*2+1]); 
		  } 
		  return ret; 
	  } 
	  
	  public static byte uniteBytes(byte src0, byte src1) {
		  byte b0 = Byte.decode("0x" + new String(new byte[] { src0 }))
					.byteValue();
		  b0 = (byte) (b0 << 4);
		  byte _b1 = Byte.decode("0x" + new String(new byte[] { src1 }))
					.byteValue();
		  byte ret = (byte) (b0 ^ _b1);
		  return ret;
	  }
	  
	  /**
	     * 二进制字符串转成16进制字符串
		 * @param str 源字符串（如：101100）
		 * @return String 返回16进制字符串（如：2c）
		 */
	  public static String binaryString2hexString(String bString)  {  
		  int digit = Integer.valueOf(bString,2);//根据2进制形式转换成10进制
		  String hexString = Integer.toString(digit,16);//转换成16进制的字符串
		  
		  return hexString;
	  }  
	
	  /**
	     * 十六进制字符串转成二进制字符串
		 * @param str 源字符串（如：2c）
		 * @return String 返回16进制字符串（如：101100）
		 */
      public static String hexString2binaryString(String hexString)  {  
    	  int digit = Integer.valueOf(hexString,16);//根据16进制形式转换成10进制
    	  String bString = Integer.toString(digit,2);//转换成2进制的字符串
    	  return bString;
      }  
      
      /**
	     * 获得指定文件的byte数组 
		 * @param filePath 文件路径
		 */
	@SuppressWarnings("unused")
	public static byte[] getBytesFormFilePath(String filePath){  
           byte[] buffer = null;  
           try {  
               File file = new File(filePath);  
               FileInputStream fis = new FileInputStream(file);  
              ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);  
              byte[] b = new byte[1000];  
              int n;  
              while ((n = fis.read(b)) != -1) {  
                  bos.write(b, 0, n);  
              }  
              fis.close();  
              bos.close();  
              buffer = bos.toByteArray();  
          } catch (FileNotFoundException e) {  
              e.printStackTrace();  
          } catch (IOException e) {  
              e.printStackTrace();  
          }  
          return buffer;  
      }
  
      /** 
        * 根据byte数组，生成文件 
        * @param filePath 文件路径
        * @param fileName 文件名称
        */  
      public static void getFileFromBytes(byte[] bfile, String filePath,String fileName) {  
           BufferedOutputStream bos = null;  
           FileOutputStream fos = null;  
           File file = null;  
           try {  
               File dir = new File(filePath);  
              if(!dir.exists()&&dir.isDirectory()){//判断文件目录是否存在  
                  dir.mkdirs();  
              }  
              file = new File(filePath+"\\"+fileName);  
             fos = new FileOutputStream(file);  
              bos = new BufferedOutputStream(fos);  
              bos.write(bfile);  
          } catch (Exception e) {  
              e.printStackTrace();  
          } finally {  
              if (bos != null) {  
                  try {  
                      bos.close();  
                  } catch (IOException e1) {  
                      e1.printStackTrace();  
                  }  
              }  
              if (fos != null) {  
                  try {  
                      fos.close();  
                  } catch (IOException e1) {  
                      e1.printStackTrace();  
                  }  
              }  
          }  
      }  
      
      /** 
       * 判断文件的是否为图片 
       * @param file 文件对象
       * @return boolean  图片-true;非图片-false
       */  
      public static boolean isImage(File file){  
          if(file.isDirectory()){  
              return false;  
          }  
          String fileName = file.getName();  
          int len = fileName.indexOf(".");  
          String imagesPattern  = fileName.substring(len+1,fileName.length()).toLowerCase();  
          if("jpg".equals(imagesPattern)){  
              return true;  
          }else if("bmp".equals(imagesPattern)){  
              return true;  
          }else if("gif".equals(imagesPattern)){  
              return true;  
          }else if("psd".equals(imagesPattern)){  
              return true;  
          }else if("pcx".equals(imagesPattern)){  
              return true;  
          }else if("png".equals(imagesPattern)){  
              return true;  
          }else if("dxf".equals(imagesPattern)){  
              return true;  
          }else if("cdr".equals(imagesPattern)){  
              return true;  
          }else if("ico".equals(imagesPattern)){  
              return true;  
          }else if("bmp".equals(imagesPattern)){  
              return true;  
          }else if("jpeg".equals(imagesPattern)){  
              return true;  
          }else if("svg".equals(imagesPattern)){  
              return true;  
          }else if("wmf".equals(imagesPattern)){  
              return true;  
          }else if("emf".equals(imagesPattern)){  
              return true;  
          }else if("eps".equals(imagesPattern)){  
              return true;  
          }else if("tga".equals(imagesPattern)){  
              return true;  
          }else if("nef".equals(imagesPattern)){  
              return true;  
          }else if("tif".equals(imagesPattern)){  
              return true;  
          }else if("tiff".equals(imagesPattern)){  
              return true;  
          }else{  
              return false;  
          }  
    
      }   

      /** 
       * 获取访问者IP 
       *  
       * 在一般情况下使用Request.getRemoteAddr()即可，但是经过nginx等反向代理软件后，这个方法会失效。 
       *  
       * 本方法先从Header中获取X-Real-IP，如果不存在再从X-Forwarded-For获得第一个IP(用,分割)， 
       * 如果还不存在则调用Request .getRemoteAddr()。 
       *  
       * @param request 
       * @return 
       */  
      public static String getIpAddr(HttpServletRequest request){  
          String ip = request.getHeader("X-Real-IP");  
          if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {  
              return ip;  
          }  
          ip = request.getHeader("Proxy-Client-IP");  
          if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {  
              // 多次反向代理后会有多个IP值，第一个为真实IP。  
              int index = ip.indexOf(',');  
              if (index != -1) {  
                  return ip.substring(0, index);  
              } else {  
                  return ip;  
              }  
          } else {  
        	  ip = request.getRemoteAddr();
              return ip;  
          }  
      }   
      

    /** 
     * 获取访问者MAC地址 
	 * 获取访问方的MAC地址
	 * 如果不能正常解析它的主机名的话，
	 * 有可能是防火墙屏蔽了，也可能是在DNS中将NetBios解析选项屏蔽了
	 */
     public static String getMacAddrByIp(String ip) {
	    String macAddr = null;
	    try {
	        Process process = Runtime.getRuntime().exec("nbtstat -a " + ip);
	        BufferedReader br = new BufferedReader(
	                new InputStreamReader(process.getInputStream()));
	        Pattern pattern = Pattern.compile("([A-F0-9]{2}-){5}[A-F0-9]{2}");
	        Matcher matcher;
	        for (String strLine = br.readLine(); strLine != null;
	             strLine = br.readLine()) {
	            matcher = pattern.matcher(strLine);
	            if (matcher.find()) {
	                macAddr = matcher.group();
	                break;
	            }
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return macAddr;
	 }
     
     /**  随机6位密码
      *   生成一个随机数 rNum:位数 array[]:待传入数组
      */
   //密码    生成一个随机数 rNum:位数 array[]:待传入数组
   	public static String getRandomPass(int rNumPass, char arrayPass[]) {
   		Random randGen = new Random();
   		String randomPass = null;
   		for (int j = 0; j < rNumPass; j++) {
   			char aPass = arrayPass[randGen.nextInt(arrayPass.length)];
   			randomPass += aPass;
   		}
   		randomPass=randomPass.substring(4,randomPass.length());
   		return randomPass;
   	}
      
	  /**
	   * 获取区域编号的有效位
	   * @param code:12位的数字字符串
	   * @return
	   */
	  public static String getAreacodeValid(String code){
		    if(StringUtils.isEmpty(code)){
		    	return code;
		    }
		  
			List<String> strList = new ArrayList<String>();
			String pstr = "";
			for (int i = 0; i < 12;i += 3) {
				String str = StringUtils.substring(code, i,i+3);
				strList.add(str);
			}
			for (String string : strList) {
				if(!string.equals("000")){
					pstr += string;
				}
			}
			return pstr;
		}
	  
	  /**
	   * 获取3位的区域编号
	   * @param code:12位的数字字符串
	   * @return
	   */
	  public static String getThreeAreaCode(String code){
		  
		  if(StringUtils.isEmpty(code)){
		    	return code;
		    }
		  
		  List<String> strList = new ArrayList<String>();
		  String pstr = "";
		  if(code != null){
			  for (int i = 0; i < 12;i += 3) {
				  String str = StringUtils.substring(code,i,i+3);
				  strList.add(str);
			  }
			  for (String string : strList) {
				  if(!string.equals("000")){
					  pstr = string;
				  }
			  }
		  }
		  return pstr;
	  }
	  /**
	   * 获取ip形式的分区号
	   * @param code:12位的数字字符串
	   * @return
	   */
	  public static String getIpAreacode(String code){
		    if(StringUtils.isEmpty(code)){
		    	return code;
		    }
			List<String> strList = new ArrayList<String>();
			String pstr = "";
			for (int i = 0; i < 12;i += 3) {
				String str = StringUtils.substring(code, i,i+3);
				strList.add(str);
			}
			for (int i = 0; i < strList.size(); i++) {
				if(i==3){
					pstr += strList.get(i);
				}else{
					pstr += strList.get(i)+".";
				}
			}
			return pstr;
		}
	  /**
	   * 获取ip形式的分区号的复原
	   * @param code:12位的数字字符串
	   * @return
	   */
	  public static String getCASCode(String code){
		    if(StringUtils.isEmpty(code)){
		    	return code;
		    }
			String pstr = "";
			String[] split = code.split("\\.");
			for (int i = 0; i < split.length; i++) {
				//不足3位自动补齐
				String leftPad = StringUtils.leftPad(split[i], 3, "0");
				pstr += leftPad;
			}
			return pstr;
		}
	  /**
	   * 将区域编码按照规则组成十六进组编码（每三位区域转成2位的十六进制）
	   * @param code
	   * @return
	   */
	  public static String getHexStringAreacode(String areacode){
		  
		  //处理为空的情况
		  if(StringUtils.isEmpty(areacode)){
		    	return "";
		  }
		  
		  //不足12位，后面自动补0；
		  areacode = StringUtils.rightPad(areacode, 12, "0");
		  
		  //返回的十六进制地区编码
		  StringBuffer hexStringAreacode = new StringBuffer("");
		  for (int i = 0; i < 12; i += 3) {
			  String str = StringUtils.substring(areacode,i,i+3);
			  //将字符串区域编号转成十进制数字
	          int areacodeInt = Integer.parseInt(str);
			  //将十进制数字转成二位十六进制字符串
	          String areacodeHexString = intToHexString(areacodeInt,2);
	          
	          hexStringAreacode = hexStringAreacode.append(areacodeHexString);
		  }
		  
		  return hexStringAreacode.toString();
	  }
	  
      /**
       * 
       * 功能：Java读取txt文件的内容
       * 步骤：1：先获得文件句柄
       * 2：获得文件句柄当做是输入一个字节码流，需要对这个输入流进行读取
       * 3：读取到输入流后，需要读取生成字节流
       * 4：一行一行的输出。readline()。
       * 备注：需要考虑的是异常情况
       * @param lucher
       */
      public static void readTxtFile(String filePath){
          try {
                  String encoding="UTF-8";
                  File file=new File(filePath);
                  if(file.isFile() && file.exists()){ //判断文件是否存在
                      InputStreamReader read = new InputStreamReader(
                      new FileInputStream(file),encoding);//考虑到编码格式
                      BufferedReader bufferedReader = new BufferedReader(read);
                      String lineTxt = null;
                      while((lineTxt = bufferedReader.readLine()) != null){
                          System.out.println(lineTxt);
                      }
                      read.close();
          }else{
              System.out.println("找不到指定的文件");
          }
          } catch (Exception e) {
              System.out.println("读取文件内容出错");
              e.printStackTrace();
          }
      }
      
      
      
	  public static void main(String[] args) {
		   
		  System.out.println(Tools.getIpAreacode("001001000000"));
		  
	  }
}
