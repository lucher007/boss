package com.gospell.boss.po;

public class Constant {
	/**
	 * 项目常量类
	 */
		// 授权过期日期
		public static final String AUTHOR_TIME = "2099-12-31";
		
		// http请求头
		public static final String HTTP_HEAD = "http://";
		// WebService服务域
		public static final String WEBSERVICE_DOMAIN = "/boss/services/bossServer";
		// WebService命名空间
		public static final String WEBSERVICE_NAMESPACE = "http://impl.server.axis2.boss.com";
		
		// 分页显示每页记录数
		public static final int PAGE_SIZE = 5;
		
		// CAS每次查询EmmSend表发送的记录数
		public static final int EMMSEND_QUERY_SIZE = 1000;
		
		// 日期格式
		public static final String DATE_FORMAT_1 = "yyyy-MM-dd";
		public static final String DATE_FORMAT_2 = "yyyyMMdd";
		public static final String DATE_FORMAT_3 = "yyMMdd";
		
		// 时间格式
		public static final String DATETIME_FORMAT_1 = "yyyy-MM-dd HH:mm:ss";
		public static final String DATETIME_FORMAT_2 = "yyyyMMddHHmmss";
		
		public static final String EXPORT_HTML = "HTML";
		public static final String EXPORT_PDF = "PDF";
		public static final String EXPORT_XLS = "XLS";
		
		// CAS属性文件名称
		public static final String CAS_FILENAME = "cas";
		// CAS版本号
		public static final int CAS_VERSION = 2;
		
		// CAS命令类型参数
		public static final int CAS_CMDTYPE_PRODUCT_AUTHOR = 1;
		public static final int CAS_CMDTYPE_OSD_SEND = 2;
		public static final int CAS_CMDTYPE_PING_RESET = 3;
		public static final int CAS_CMDTYPE_BOX_CARD_APPLY = 4;
		public static final int CAS_CMDTYPE_BOX_CARD_CANCEL = 5;
		public static final int CAS_CMDTYPE_FINGER_SHOW = 6;
		public static final int CAS_CMDTYPE_AREA_LOCK_APPLY = 8;
		public static final int CAS_CMDTYPE_AREA_LOCK_CANCEL = 9;
		public static final int CAS_CMDTYPE_CARD_PURCHASE = 10;
		public static final int CAS_CMDTYPE_CARD_OPENCLOSE = 11;
		public static final int CAS_CMDTYPE_EMAIL_SEND = 13;
		public static final int CAS_CMDTYPE_CONDITION_SEARCH = 14;
		public static final int CAS_CMDTYPE_LIMIT_PLAY_APPLY = 17;
		public static final int CAS_CMDTYPE_LIMIT_PLAY_CANCEL = 18;
		
		// CAS命令优先级
		public static final int CAS_CMDLEVEL_CARD_PURCHASE = 1;
		public static final int CAS_CMDLEVEL_PING_RESET = 1;
		public static final int CAS_CMDLEVEL_PRODUCT_AUTHOR = 2;
		public static final int CAS_CMDLEVEL_BOX_CARD_APPLY = 3;
		public static final int CAS_CMDLEVEL_BOX_CARD_CANCEL = 3;
		public static final int CAS_CMDLEVEL_CARD_OPENCLOSE = 3;
		public static final int CAS_CMDLEVEL_LIMIT_PLAY_APPLY = 3;
		public static final int CAS_CMDLEVEL_LIMIT_PLAY_CANCEL = 3;
		public static final int CAS_CMDLEVEL_AREA_LOCK_APPLY = 3;
		public static final int CAS_CMDLEVEL_AREA_LOCK_CANCEL = 3;
		public static final int CAS_CMDLEVEL_OSD_SEND = 4;
		public static final int CAS_CMDLEVEL_EMAIL_SEND = 4;
		
		// CAS命令条件寻址16进制参数
		public static final String CAS_CONDITION_CARD_ID = "23";    // 卡号
		public static final String CAS_CONDITION_USER_AREA = "24";  // 区域
		public static final String CAS_CONDITION_VIP_CLASS = "25";  // VIP订户（集团订户）
		public static final String CAS_CONDITION_COMPARE_LT  =  "13";  // 小于
		public static final String CAS_CONDITION_COMPARE_LE = "14";  // 小于等于
		public static final String CAS_CONDITION_COMPARE_GT = "15";   // 大于
		public static final String CAS_CONDITION_COMPARE_GE = "16";  // 大于等于
		public static final String CAS_CONDITION_COMPARE_EQ = "17";  // 等于
		public static final String CAS_CONDITION_COMPARE_NE = "18";  // 不等于
		public static final String CAS_CONDITION_COMPARE_AND = "1c";  // AND
		public static final String CAS_CONDITION_COMPARE_OR = "1d";  // OR
		
		// 流水号类型
		public static final String SERIAL_TYPE_CUSTCODE = "CUSTCODE";
		public static final String SERIAL_TYPE_SERVSERIALID = "SERVSERIALID";
		
		// 对应数据库参数表类型代码（TYPECODE）的具体参数
		public static final String TYPECODE_OPERATOR_STATUS = "OPERSTATUS"; //操作员状态
		public static final String TYPECODE_CUST_TYPE = "CUSTTYPE"; //订户类型
		public static final String TYPECODE_CUST_STATUS = "CUSTSTATUS"; //订户状态
		public static final String TYPECODE_CUST_FLAG = "CUSTFLAG"; //订户标志
		public static final String TYPECODE_CERT_TYPE = "CERTTYPE"; //证件类型
		public static final String TYPECODE_CARD_FLAG = "CARDFLAG"; //子母卡标识
		public static final String TYPECODE_APPLY_TYPE = "APPLYTYPE"; //申请类型
		public static final String TYPECODE_BUY_TYPE = "BUYTYPE"; //购买类型
		public static final String TYPECODE_USE_STATUS = "USESTATUS"; //用户使用状态
		public static final String TYPECODE_BUSI_TYPE = "BUSITYPE"; //业务类型
		public static final String TYPECODE_BUSI_STATUS = "BUSISTATUS"; //业务状态
		public static final String TYPECODE_SERV_TYPE = "SERVTYPE"; //服务类型
		public static final String TYPECODE_PRICE_UNIT = "PRICEUNIT"; //价格单位
		public static final String TYPECODE_PAY_TYPE = "PAYTYPE"; //支付类型
		public static final String TYPECODE_PRINT_FLAG = "PRINTFLAG"; //是否打印发票
		public static final String TYPECODE_BILL_TYPE = "BILLTYPE"; //发票类型
		public static final String TYPECODE_BOX_FLAG = "BOXFLAG"; //主副机标识
		public static final String TYPECODE_DEVICE_TYPE = "DEVICETYPE"; //设备类型
		public static final String TYPECODE_DEVICE_STATUS = "DEVICESTATUS"; //设备状态
		public static final String TYPECODE_REPLACE_CAUSE = "REPLACECAUSE"; //设备更换原因
		public static final String TYPECODE_PROD_TYPE = "PRODTYPE";  //产品类型
		public static final String TYPECODE_PROD_STATUS = "PRODSTATUS";  //产品状态
		public static final String TYPECODE_PRODUSE_STATUS = "PRODUSESTATUS";  //产品使用状态
		public static final String TYPECODE_POLICY_TYPE = "POLICYTYPE";  //策略类型
		public static final String TYPECODE_AUTHOR_STATUS = "AUTHSTATUS";  //授权状态
		public static final String TYPECODE_MATURE_TYPE = "MATURETYPE";  //催缴类型
		public static final String TYPECODE_SEND_TYPE = "SENDTYPE";  //消息发送类型
		public static final String TYPECODE_SEND_FLAG = "SENDFLAG";  //发送状态
		
		// 对应数据库业务类型的具体参数
		public static final String SERV_TYPE_KH = "adduser";//开户
		public static final String SERV_TYPE_MK = "buycard";//购买智能卡
		public static final String SERV_TYPE_MS = "buystb";//购买智能卡
		public static final String SERV_TYPE_MP = "buyproduct";//购买套餐
		public static final String SERV_TYPE_CP = "cancelproduct";//取消套餐
		public static final String SERV_TYPE_XH = "canceluser";//销户
		public static final String SERV_TYPE_KT = "opencard";//订户开通
		public static final String SERV_TYPE_BT = "pausecard";//订户报停
		public static final String SERV_TYPE_RJ = "replacestb";//更换机顶盒
		public static final String SERV_TYPE_RC = "replacecard";//更换机顶盒
		public static final String SERV_TYPE_UU = "updateUser";//修改订户
		public static final String SERV_TYPE_RA = "rechargeAccount";//账户充值
		public static final String SERV_TYPE_RW = "rechargewallet";//电子钱包充值
		public static final String SERV_TYPE_UF = "updatefee";     //错费修正
		
		// 对应数据库参数表参数编号（PARACODE）的具体数值
		public static final String PARACODE_DEVICE_TYPE_CARD = "CARD"; // 设备类型：智能卡
		public static final String PARACODE_DEVICE_TYPE_BOX = "BOX"; // 设备类型：机顶盒
		
		public static final String PARACODE_DEVICE_FLAG_MAIN = "MAIN"; // 设备标识：母卡/主机
		public static final String PARACODE_DEVICE_FLAG_SUB = "SUB"; // 设备标识：子卡/副机
		
		public static final String PARACODE_DEVICE_STATUS_ENTER = "ENTER"; //设备状态：入库
		public static final String PARACODE_DEVICE_STATUS_ASSIGN = "ASSIGN"; //设备状态：分配
		public static final String PARACODE_DEVICE_STATUS_RETRIEVE = "RETRIEVE"; //设备状态：回收
		public static final String PARACODE_DEVICE_STATUS_SALE = "SALE"; //设备状态：售出
		
		public static final String PARACODE_USE_STATUS_NORMAL = "NORMAL"; //设备使用状态：正常
		public static final String PARACODE_USE_STATUS_STOP = "STOP"; //设备使用状态：用户报停
		public static final String PARACODE_USE_STATUS_CANCEL = "CANCEL"; //设备使用状态：销户
		
		public static final String PARACODE_POLICY_TYPE_PRODUCT = "PRODUCT"; //策略类型：产品策略
		public static final String PARACODE_POLICY_TYPE_DEVICEMODEL = "DEVICEMODEL"; //策略类型：设备型号策略
		
		public static final String PARACODE_PROD_TYPE_PROGRAM= "PROGRAM"; // 产品类型：节目套餐
		public static final String PARACODE_PROD_TYPE_ADSL= "ADSL"; // 产品类型：宽带产品
		
		public static final String PARACODE_PROD_STATUS_USABLED = "USABLED"; //产品状态：可用
		public static final String PARACODE_PROD_STATUS_OVERDUE = "OVERDUE"; //产品状态：过期
		
		public static final String PARACODE_PRODUSE_STATUS_NORMAL = "NORMAL"; //产品使用状态：正常
		public static final String PARACODE_PRODUSE_STATUS_PAUSE = "PAUSE"; //产品使用状态：暂停
		
		public static final String PARACODE_AUTHOR_STATUS_WAITING = "WAITING"; //授权状态：待授权
		public static final String PARACODE_AUTHOR_STATUS_COMPLETED = "COMPLETED"; //授权状态：已授权
		public static final String PARACODE_AUTHOR_STATUS_CANCEL = "CANCEL"; //授权状态：反授权
		public static final String PARACODE_AUTHOR_STATUS_AGAIN = "AGAIN"; //授权状态：重授权
		
		public static final String PARACODE_CUST_STATUS_NORMAL = "NORMAL"; //订户状态：正常
		public static final String PARACODE_CUST_STATUS_CANCEL = "CANCEL"; //订户状态：销户
		
		public static final String PARACODE_CUST_FLAG_PERSONAL = "PERSONAL"; //订户标志：个人订户
		public static final String PARACODE_CUST_FLAG_GROUP = "GROUP"; //订户标志：集团订户
		
		public static final String PARACODE_BUSI_TYPE_PROGRAM = "PROGRAM"; //业务类型：节目业务
		
		public static final String PARACODE_BUSI_STATUS_NORMAL = "NORMAL"; //业务状态：正常
		
		public static final String PARACODE_OPER_STATUS_NORMAL = "1"; // 操作员状态，有效
		
		public static final String SERVER_GOS_GN = "gos_gn";     //高安服务器
		public static final String SERVER_GOS_PN = "gos_pn";     //普安服务器
		
		
		//系统参数表(页面维护)
		public static final String MPS_EXTEND_FLAG = "mps_extend_flag"; //MPS推送标志（0-不推送；1-推送）
		public static final String Product_FILE_SAVE_LOCATION = "product_file_save_location"; //文件保存位置
		public static final String AUTH_EXPIRED_TIME = "auth_expired_time"; //授权过期日期
		public static final String OPERATORS_AREAID = "operators_areaid"; //运营商分配区域ID
		public static final String OPERATORS_NETID = "operators_netid"; //运营商分配网络ID
		public static final String OPERATORS_BOUQUETID = "operators_bouquetid"; //运营商分配信束ID
		public static final String OPERATORS_NAME = "operators_name"; //运营商名称
		public static final String CURRENCY_CODE = "currency_code"; //系统采用货币代码
		public static final String CURRENCY_CONVERSION_DENOMINATOR = "currency_conversion_denominator"; //货币转换因子之分母
		public static final String CAS_SEND_AUTO = "cas_send_auto"; //系统发送CAS指令标志（0-否；1-是）
		public static final String MASTER_SLAVE_CARD_INTERVAL_TIME = "master_slave_card_interval_time"; //子母卡配对时间间隔
		public static final String USER_VIP_CLASS = "user_vip_class"; //用户VIP级别
		public static final String MATURITY_RATING = "maturity_rating"; //成人级别
		public static final String OPERATOR_INFO = "operator_info"; //运营商信息
		
		//产品同步给MPS方法
		public static final String HTTPFORMPS_PUSHPRODUCTINFO = "/mps/rs/push/pushProduct"; //像MPS服务器同步产品接口接口名
		
	}

	
	
	
	
	
	
	
	
	
	
	

