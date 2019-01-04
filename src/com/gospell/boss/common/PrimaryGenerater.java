package com.gospell.boss.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.util.StringUtils;

/**
 * 获取编码
 */
public class PrimaryGenerater {
	private static final String PRE_NUMBER = "yyMMdd";  //流水号前缀格式
	private static final String SUF_NUMBER = "000000";    //流水号后缀格式
    private static PrimaryGenerater primaryGenerater = null;
 
    private PrimaryGenerater() {
    }
 
    /**
     * 取得PrimaryGenerater的单例实现
     *
     * @return
     */
    public static PrimaryGenerater getInstance() {
        if (primaryGenerater == null) {
            synchronized (PrimaryGenerater.class) {
                if (primaryGenerater == null) {
                    primaryGenerater = new PrimaryGenerater();
                }
            }
        }
        return primaryGenerater;
    }
 
    /** 生成下一个编号
     * 如果传递进来的流水号为空，或者 它的前缀格式不等于当前时间格式，则返回默认第一个流水号
     */
    public synchronized String generaterNextNumber(String sno) {
        String id = null;
        //规则前缀格式
        SimpleDateFormat pre_formatter = new SimpleDateFormat(PRE_NUMBER);
        //当前时间格式
        String correntDateStr = pre_formatter.format(new Date()); 
        //流水号后缀格式
        DecimalFormat suf_formatter = new DecimalFormat(SUF_NUMBER);
        
        //如果传递进来的流水号为空，则返回默认第一个流水号
        if (StringUtils.isEmpty(sno)) {
        	 id = correntDateStr + suf_formatter.format(1);
        } else{
        	//获取传递进来的流水号的前缀格式
            String pre_sno = sno.substring(0, PRE_NUMBER.length());
            //如果传递进来的流水号前缀格式不等于当前时间格式，则返回默认当前时间的第一个流水号
            if (pre_sno.compareTo(correntDateStr) < 0){
            	//获取传递进来的流水号
            	id = correntDateStr + suf_formatter.format(1);
            	return id;
            //如果传递进来的流水号前缀格式不等于当前时间格式，则返回下一个流水号
            } else {
            	//获取传递进来的流水后后缀格式
            	String suf_sno = sno.substring(PRE_NUMBER.length());
                id = correntDateStr + suf_formatter.format(1 + Integer.parseInt(suf_sno));
            }
        }
        return id;
    }
    
    public static void main(String[] args){
    	System.out.println(" -------" + getInstance().generaterNextNumber(null));
    	
    }
    
}
