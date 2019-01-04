package test;

import java.util.Calendar;
import java.util.Random;

import com.gospell.boss.common.AesSecret;

public class CardAndPass {

	static Random randGen = null;
	static char[] numbersAndLetters = null;
	static char[] passAndLetters = null;
	static String key = "gospell";
	static String encodePass;
	
	public static void main(String[] strs) {

		randGen = new Random();
		numbersAndLetters = ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
		passAndLetters = ("0123456789").toCharArray();
		
		for(int i=1;i<=100;i++){
			String date = getNowTime();
			String random2String = getRandom(4, numbersAndLetters);
			String randomPass = getRandomPass(6, passAndLetters);
			String string = addZero(String.valueOf(i), 6);
			System.out.println("卡号"+date+random2String+string);
			System.out.println("原始密码"+randomPass);
			
			//加密
			try {
				encodePass = AesSecret.aesEncrypt(randomPass, key);
				
				System.out.println("加密后"+encodePass);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			//解密
			
			String decodePass;
			try {
				decodePass = AesSecret.aesDecrypt(encodePass, key);
				System.out.println("解密后"+decodePass);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
//			System.out.println("卡号："+date+random2String+string);
//			System.out.println("密码："+randomPass);
//			System.out.println("加密后："+encodePass);
//			System.out.println("解密后："+decodePass);
		}
	}
	
	//得到当前日期 年/月/日/分/秒
	public static String getNowTime() {
		Calendar now = Calendar.getInstance();
		String time =  String.valueOf(now.get(Calendar.YEAR)) + String.valueOf(now.get(Calendar.MONTH) + 1) + String.valueOf(now.get(Calendar.DAY_OF_MONTH) )+ String.valueOf(now.get(Calendar.MINUTE)) + String.valueOf(now.get(Calendar.SECOND));
		return time;
	}

	//生成一个随机数 rNum:位数 array[]:待传入数组
	public static String getRandom(int rNum, char array[]) {
		String random = null;
		for (int j= 0; j < rNum; j++) {
			char a = array[randGen.nextInt(array.length)];
			random += a;
		}
		random=random.substring(4,random.length());
		return random;
	}
	
	//密码    生成一个随机数 rNum:位数 array[]:待传入数组
	public static String getRandomPass(int rNumPass, char arrayPass[]) {
		String randomPass = null;
		for (int j = 0; j < rNumPass; j++) {
			char aPass = arrayPass[randGen.nextInt(arrayPass.length)];
			randomPass += aPass;
		}
		randomPass=randomPass.substring(4,randomPass.length());
		return randomPass;
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

}
