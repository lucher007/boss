package com.gospell.boss.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.gospell.boss.po.JsonObject;
import com.gospell.boss.po.Menu;
import com.gospell.boss.po.Operator;

public class JsonTest {

	public static void main(String[] args) {
		String json = "{data:[" +
				             "{loginname:'Wallace'," +
				             " menulist:[{menucode:123456," +
				             "            menuname:'个人业务'" +
				             "           }" +
				                       "]" +
				             "}," +
				             "{loginname:'Grommit',menulist:[{menucode:456789,menuname:'发票打印'}]}" +
				"]" +
				"" +
				"}";  
		Map classMap = new HashMap();  
		classMap.put( "data", Operator.class );
		classMap.put( "menulist", Menu.class ); 
		JsonObject bean = (JsonObject)JSONObject.toBean( JSONObject.fromObject(json), JsonObject.class, classMap );
		List list = bean.getData();
		for(int i=0;i<list.size();i++){
			Operator operator = (Operator)list.get(i);
			System.out.println(operator.getLoginname());
			List<Menu> menulist = operator.getMenulist();
			for(int j=0;j<menulist.size();j++){
				Menu menu = (Menu)menulist.get(j);
				System.out.println("person"+i+"-->"+menu.getMenucode()+"-->"+menu.getMenuname());
			}
		}
	}

}
