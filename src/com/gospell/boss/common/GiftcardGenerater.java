package com.gospell.boss.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.springframework.util.StringUtils;

/**
 * 充值卡卡号获取编码
 */
public class GiftcardGenerater {
	//private static final String PRE_NUMBER = "yyyyMMdd";  //流水号前缀格式
	//private static final String MID_NUMBER = "A";  //流水号中间格式
	private static final String SUF_NUMBER = "000000";    //流水号后缀格式
    private static GiftcardGenerater primaryGenerater = null;
    static char[] passAndLetters = ("0123456789").toCharArray();//随机密码产生的数组
    private GiftcardGenerater() {
    }
 
    /**
     * 取得PrimaryGenerater的单例实现
     *
     * @return
     */
    public static GiftcardGenerater getInstance() {
        if (primaryGenerater == null) {
            synchronized (GiftcardGenerater.class) {
                if (primaryGenerater == null) {
                    primaryGenerater = new GiftcardGenerater();
                }
            }
        }
        return primaryGenerater;
    }
 
    /** 生成下一个编号
     * 如果传递进来的流水号为空，或者 它的前缀格式不等于当前时间格式，则返回默认第一个流水号
     */
    public synchronized String generaterNextNumber(String batchno, String amountpara, String sno) {
        String id = null;
        //规则前缀格式
        //SimpleDateFormat pre_formatter = new SimpleDateFormat(PRE_NUMBER);
        //当前时间格式
        //String correntDateStr = pre_formatter.format(new Date()); 
        //流水号后缀格式
        DecimalFormat suf_formatter = new DecimalFormat(SUF_NUMBER);
        
        //如果传递进来的流水号为空，则返回默认第一个流水号
        if (StringUtils.isEmpty(sno)) {
        	 id = batchno + amountpara + suf_formatter.format(1);
        } else{
        	//获取传递进来的流水号的前缀格式
            String pre_sno = sno.substring(0, batchno.length());
            //获取传递进来的流水号的面额参数
            String mid_sno = sno.substring(batchno.length(), batchno.length() + amountpara.length());
            
            //如果传递进来的流水号前缀格式不等于当前时间格式，或者 面额参数不相等，则返回默认当前时间的面额的第一个流水号
            if (pre_sno.equals(batchno) && amountpara.equals(mid_sno)){
            	//获取传递进来的流水后后缀格式
            	String suf_sno = sno.substring(batchno.length()+amountpara.length());
                id = pre_sno + mid_sno + suf_formatter.format(1 + Integer.parseInt(suf_sno));
            //如果传递进来的流水号前缀格式等于当前时间格式且等于面额参数，则返回下一个流水号
            }else{
            	id = pre_sno + mid_sno + suf_formatter.format(1);
            	return id;
            }
        }
        return id;
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
  		
  		System.out.println(randomPass);
  		
  		randomPass=randomPass.substring(4,randomPass.length());
  		return randomPass;
  	}
    
    public static void main(String[] args){
    	//System.out.println(" -------" + getInstance().generaterNextNumber("20170515","A","20170515A000001"));
    	//String mid_sno = "170515A000001".substring(6, 7);
    	System.out.println(getRandomPass(6,("0123456789").toCharArray()));
    }
    
}
