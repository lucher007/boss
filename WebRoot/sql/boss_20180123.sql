/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : boss

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2018-01-23 16:37:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activityinfo
-- ----------------------------
DROP TABLE IF EXISTS `activityinfo`;
CREATE TABLE `activityinfo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL COMMENT '类型（0-文字；1-图片）',
  `title` varchar(255) DEFAULT NULL COMMENT '活动标题',
  `content` varchar(5000) DEFAULT NULL COMMENT '活动内容',
  `state` varchar(255) DEFAULT NULL COMMENT '状态(0-失效；1-有效）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activityinfo
-- ----------------------------

-- ----------------------------
-- Table structure for activityinfopic
-- ----------------------------
DROP TABLE IF EXISTS `activityinfopic`;
CREATE TABLE `activityinfopic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `activityinfoid` int(10) DEFAULT NULL COMMENT '活动信息ID',
  `filename` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `preservefilename` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `preserveurl` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activityinfopic
-- ----------------------------

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `pid` int(10) DEFAULT NULL COMMENT '父节点区域ID',
  `code` varchar(255) DEFAULT NULL COMMENT '区域编号（有规则的编号，方便管理拓扑结构，举例：001，002,001-001等。',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域号',
  `areaname` varchar(255) DEFAULT NULL COMMENT '区域名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `areacode_unique` (`netid`,`areacode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域信息表';

-- ----------------------------
-- Records of area
-- ----------------------------

-- ----------------------------
-- Table structure for authorize
-- ----------------------------
DROP TABLE IF EXISTS `authorize`;
CREATE TABLE `authorize` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `serverid` int(10) DEFAULT NULL COMMENT '所属前端',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域号',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `terminalid` varchar(255) DEFAULT NULL COMMENT '终端号',
  `terminaltype` varchar(255) DEFAULT NULL COMMENT '终端类型（0-机顶盒号；1-智能卡号）',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡ID',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `versiontype` varchar(255) DEFAULT NULL COMMENT 'CA版本类型(gos_gn,gos_pn)',
  `commandtype` varchar(255) DEFAULT NULL COMMENT 'CA命令类型指令',
  `conditionaddr` varchar(255) DEFAULT NULL COMMENT '寻址条件',
  `command` varchar(1024) DEFAULT NULL COMMENT 'CA命令（16进制数据字符）',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-未发送；1-发送失败）',
  `result` varchar(255) DEFAULT NULL COMMENT '返回结果（保存发送失败返回结果）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CA授权信息表';

-- ----------------------------
-- Records of authorize
-- ----------------------------

-- ----------------------------
-- Table structure for authorizehistory
-- ----------------------------
DROP TABLE IF EXISTS `authorizehistory`;
CREATE TABLE `authorizehistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `serverid` int(10) DEFAULT NULL COMMENT '所属前端',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域号',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `terminalid` varchar(255) DEFAULT NULL COMMENT '终端号',
  `terminaltype` varchar(255) DEFAULT NULL COMMENT '终端类型（0-机顶盒号；1-智能卡号）',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡ID',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `versiontype` varchar(255) DEFAULT NULL COMMENT 'CA版本类型(gos_gn,gos_pn)',
  `commandtype` varchar(255) DEFAULT NULL COMMENT 'CA命令类型指令',
  `conditionaddr` varchar(255) DEFAULT NULL COMMENT '寻址条件',
  `command` varchar(1024) DEFAULT NULL COMMENT 'CA命令（16进制数据字符）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='CA信息历史表';

-- ----------------------------
-- Records of authorizehistory
-- ----------------------------

-- ----------------------------
-- Table structure for businesstype
-- ----------------------------
DROP TABLE IF EXISTS `businesstype`;
CREATE TABLE `businesstype` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `typekey` varchar(255) DEFAULT NULL COMMENT '业务类型编码',
  `typename` varchar(255) DEFAULT NULL COMMENT '业务类型名称',
  `feename` varchar(255) DEFAULT NULL COMMENT '费用名称',
  `price` decimal(15,2) DEFAULT NULL COMMENT '办理此业务价格',
  `showorder` decimal(15,2) DEFAULT NULL COMMENT '页面显示顺序',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `definedflag` varchar(255) DEFAULT NULL COMMENT '是否自定义标签（0-系统业务类型；1-自定义业务类型）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='业务类型参数表';

-- ----------------------------
-- Records of businesstype
-- ----------------------------
INSERT INTO `businesstype` VALUES ('1', 'adduser', '开户', '开户费', '0.00', '7.00', '1', '0', null);
INSERT INTO `businesstype` VALUES ('2', 'buycard', '买卡', '智能卡费', '0.00', '8.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('3', 'buystb', '买机顶盒', '机顶盒费', '0.00', '9.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('4', 'pausecard', '报停', '报停费', '10.00', '2.00', '1', '0', null);
INSERT INTO `businesstype` VALUES ('5', 'transferaddress', '迁移', '迁移费', '20.00', '1.00', '1', '0', null);
INSERT INTO `businesstype` VALUES ('6', 'opencard', '开通', '开通费', '20.00', '3.00', '1', '0', null);
INSERT INTO `businesstype` VALUES ('7', 'rebackstb', '回收机顶盒', '回收机顶盒费', '0.00', '10.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('8', 'rebackcard', '回收智能卡', '回收智能卡费', '0.00', '11.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('9', 'rechargeaccount', '账户充值', '账户充值费', '0.00', '12.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('10', 'rechargewallet', '电子钱包充值', '电子钱包充值费', '0.00', '13.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('11', 'buyproduct', '购买产品', '产品费', '0.00', '4.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('12', 'transferuser', '过户', '过户费', '50.00', '5.00', '1', '0', null);
INSERT INTO `businesstype` VALUES ('13', 'canceluser', '销户', '销户费', '20.00', '6.00', '1', '0', null);
INSERT INTO `businesstype` VALUES ('14', 'replacestb', '更换机顶盒', '机顶盒费', '0.00', '14.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('15', 'replacecard', '更换智能卡', '智能卡费', '0.00', '15.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('16', 'cancelproduct', '取消产品', '取消产品', '0.00', '16.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('17', 'updateuser', '修改订户', '修改订户', '0.00', '17.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('18', 'authorizerefresh', '授权刷新', '授权刷新费', '0.00', '18.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('19', 'transferusered', '受理过户', '受理过户费', '0.00', '19.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('20', 'accountpayment', '账户支付', '账户费', '0.00', '20.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('21', 'giftcardrecharge', '充值卡充值', '充值卡费', '0.00', '21.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('22', 'scorerecharge', '积分充值', '积分费', '0.00', '22.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('23', 'giftcardpayment', '充值卡支付', '充值卡费', '0.00', '23.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('24', 'scorepayment', '积分支付', '积分费', '0.00', '24.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('25', 'accountrefund', '账户退钱', '退钱费', '0.00', '25.00', '0', '0', null);
INSERT INTO `businesstype` VALUES ('27', '遥控器费用', '遥控器费用', null, '10.00', null, '1', '1', null);
INSERT INTO `businesstype` VALUES ('28', '产品优惠', '产品优惠', null, '-100.00', null, '1', '1', null);
INSERT INTO `businesstype` VALUES ('29', 'antean', 'antean', null, '10.00', null, '1', '1', null);
INSERT INTO `businesstype` VALUES ('30', 'discount', 'discount', null, '-20.00', null, '1', '1', null);

-- ----------------------------
-- Table structure for card
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cardid` varchar(255) DEFAULT NULL COMMENT '卡号',
  `providerid` int(10) DEFAULT NULL COMMENT '供应商ID',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `versiontype` varchar(255) DEFAULT NULL COMMENT '所属CAS版本类型',
  `serverid` int(10) DEFAULT NULL COMMENT '所属服务器ID',
  `state` varchar(255) DEFAULT NULL COMMENT '卡状态（0-库存；1：使用；2：维修；3：损坏；）',
  `inputtime` datetime DEFAULT NULL COMMENT '入库时间',
  `outtime` datetime DEFAULT NULL COMMENT 'outtime',
  `batchnum` varchar(255) DEFAULT NULL COMMENT '入库批号',
  `pincode` varchar(255) DEFAULT NULL COMMENT 'PIN码',
  `incardflag` varchar(255) DEFAULT '0' COMMENT '是否内置卡(0-外置卡；1-内置卡）',
  `stbno` varchar(255) DEFAULT NULL COMMENT '配对机顶盒号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cardid_unique` (`cardid`) USING BTREE,
  UNIQUE KEY `stbno_unique` (`stbno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='智能卡信息表';

-- ----------------------------
-- Records of card
-- ----------------------------

-- ----------------------------
-- Table structure for caspnblackcard
-- ----------------------------
DROP TABLE IF EXISTS `caspnblackcard`;
CREATE TABLE `caspnblackcard` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注(关联机顶盒黑名单表的ID)',
  `stbno` varchar(255) DEFAULT NULL COMMENT '绑定的机顶盒号',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `versiontype` varchar(255) DEFAULT NULL COMMENT 'cas版本类型',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  `conditioncontent` varchar(255) DEFAULT NULL COMMENT '条件内容',
  `addtime` datetime DEFAULT NULL COMMENT '添加日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caspnblackcard
-- ----------------------------

-- ----------------------------
-- Table structure for caspnblackstb
-- ----------------------------
DROP TABLE IF EXISTS `caspnblackstb`;
CREATE TABLE `caspnblackstb` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注(绑定的黑名单智能卡号，多个卡号用逗号隔开)',
  `cardids` varchar(255) DEFAULT NULL COMMENT '黑名单绑定的智能卡，多卡号已逗号隔开',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `versiontype` varchar(255) DEFAULT NULL COMMENT 'cas版本类型',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  `conditioncontent` varchar(255) DEFAULT NULL COMMENT '条件内容',
  `expired_Time` datetime DEFAULT NULL COMMENT '过期日期',
  `addtime` datetime DEFAULT NULL COMMENT '添加日期',
  `send_now_flag` varchar(255) DEFAULT NULL COMMENT '立即发送标识（取值说明：0：不立即发送   1：立即发送）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caspnblackstb
-- ----------------------------

-- ----------------------------
-- Table structure for caspnforcedcc
-- ----------------------------
DROP TABLE IF EXISTS `caspnforcedcc`;
CREATE TABLE `caspnforcedcc` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡号',
  `conditioncontent` varchar(255) DEFAULT NULL COMMENT '条件内容',
  `expiredtime` datetime DEFAULT NULL COMMENT '过期时间',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束日期',
  `addtime` datetime DEFAULT NULL,
  `lockscreen` varchar(255) DEFAULT NULL COMMENT '锁定用',
  `stbtype` varchar(255) DEFAULT NULL COMMENT '机顶盒的类型（0x00：DVB-C，0x01：DVB-S，0x02: DVB-T）',
  `pcrpid` varchar(255) DEFAULT NULL COMMENT '时钟的PID',
  `serviceid` varchar(255) DEFAULT NULL COMMENT '节目号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `versiontype` varchar(255) DEFAULT NULL COMMENT 'cas版本类型',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  `network_match` varchar(255) DEFAULT NULL COMMENT '网络匹配标识(0-不匹配；1-匹配）',
  `operator_match` varchar(255) DEFAULT NULL COMMENT '运营商匹配标识(0-不匹配；1-匹配）',
  `area_match` varchar(255) DEFAULT NULL COMMENT '区域匹配标识(0-不匹配；1-匹配）',
  `device_type_match` varchar(255) DEFAULT NULL COMMENT '设备类型匹配标识(0-不匹配；1-匹配）',
  `terminal_type_match` varchar(255) DEFAULT NULL COMMENT '终端类型匹配标识(0-不匹配；1-匹配）',
  `vip_class_match` varchar(255) DEFAULT NULL COMMENT 'VIP级别匹配标识(0-不匹配；1-匹配）',
  `network_id` varchar(255) DEFAULT NULL COMMENT '匹配网络ID',
  `operator_id` varchar(255) DEFAULT NULL COMMENT '匹配运营商ID',
  `area_id` varchar(255) DEFAULT NULL COMMENT '匹配区域ID',
  `device_type` varchar(255) DEFAULT NULL COMMENT '匹配设备类型(0–固定终端；1–手持终端)',
  `terminal_type` varchar(255) DEFAULT NULL COMMENT '匹配终端类型(0 - 主机；1 - 子机)',
  `vip_class` varchar(255) DEFAULT NULL COMMENT '匹配VIP等级',
  `tsid` varchar(255) DEFAULT NULL COMMENT 'TS流ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caspnforcedcc
-- ----------------------------

-- ----------------------------
-- Table structure for caspnforcedosd
-- ----------------------------
DROP TABLE IF EXISTS `caspnforcedosd`;
CREATE TABLE `caspnforcedosd` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡号',
  `conditioncontent` varchar(1000) DEFAULT NULL COMMENT '条件内容',
  `expiredtime` datetime DEFAULT NULL COMMENT ' 过期日期',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束日期',
  `lockscreen` varchar(255) DEFAULT NULL COMMENT '锁定用户操作(0：不锁定，1：锁定面板和遥控器操作)',
  `duration` varchar(255) DEFAULT NULL COMMENT '显示时间长度，以秒为单位',
  `showtimes` varchar(255) DEFAULT NULL COMMENT '显示次数',
  `showfreq` varchar(255) DEFAULT NULL COMMENT '显示频率',
  `priority` varchar(255) DEFAULT NULL COMMENT '优先级，分为低级（数值为0 ）、中级（数值为1 ）、高级（数值为2 ）',
  `style` varchar(255) DEFAULT NULL COMMENT '滚动条显示还是文本框显示， 0：滚动条，1：文本框（不显示卡号） 2:  文本框（显示卡号）',
  `stylevalue` varchar(255) DEFAULT NULL COMMENT '滚动方式',
  `fontsize` varchar(255) DEFAULT NULL COMMENT '字号, 目前版本不支持',
  `fontcolor` varchar(255) DEFAULT NULL COMMENT '字体颜色RGBA',
  `backgroundcolor` varchar(255) DEFAULT NULL COMMENT '背景色RGBA',
  `backgroundtransparency` varchar(255) DEFAULT NULL COMMENT '背景透明度',
  `content` varchar(1000) DEFAULT NULL COMMENT 'OSD内容',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `versiontype` varchar(255) DEFAULT NULL COMMENT 'cas版本类型',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  `display_style` varchar(255) DEFAULT NULL COMMENT '表示屏显风格。000 - 滚动显示；001 – 弹窗显示；其他 – 预留将来使用',
  `font` varchar(255) DEFAULT NULL COMMENT '字体',
  `foregroundcolor` varchar(255) DEFAULT NULL COMMENT '前景色',
  `foregroundtransparency` varchar(255) DEFAULT NULL COMMENT '前景透明度',
  `scrolldirection` varchar(255) DEFAULT NULL COMMENT '滚动方向',
  `displayfrequency` varchar(255) DEFAULT NULL COMMENT '滚动频率',
  `positionx` varchar(255) DEFAULT NULL COMMENT '位置横坐标',
  `positiony` varchar(255) DEFAULT NULL COMMENT '位置纵坐标',
  `barheight` varchar(255) DEFAULT NULL COMMENT '滚动条高度',
  `screencoveragepercentage` varchar(255) DEFAULT NULL COMMENT '占屏比',
  `cardiddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否显示卡号（0-不显示；1-显示）',
  `terminaliddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否显示终端号（0-不显示；1-显示）',
  `operatoriddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否显示运营商号（0-不显示；1-显示）',
  `privatecontentflag` varchar(255) DEFAULT NULL COMMENT '是否显示私有内容（0-不显示；1-显示）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='普安强制OSD';

-- ----------------------------
-- Records of caspnforcedosd
-- ----------------------------

-- ----------------------------
-- Table structure for caspnnewemail
-- ----------------------------
DROP TABLE IF EXISTS `caspnnewemail`;
CREATE TABLE `caspnnewemail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `emailid` bigint(10) DEFAULT NULL COMMENT '邮件ID',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡号',
  `conditioncontent` varchar(1000) DEFAULT NULL COMMENT '条件内容',
  `emailtype` varchar(255) DEFAULT NULL COMMENT 'Email类型（0-普通; 1-advanced;2-urgent;3-bill）',
  `addtime` datetime DEFAULT NULL COMMENT '写信时间',
  `emailtitle` varchar(255) DEFAULT NULL COMMENT 'Email的标题',
  `emailcontent` varchar(1000) DEFAULT NULL COMMENT 'Email 的内容',
  `expiredtime` datetime DEFAULT NULL COMMENT '过期时间',
  `casexpiredtime` datetime DEFAULT NULL COMMENT 'CAS过期时间',
  `versiontype` varchar(255) DEFAULT NULL COMMENT '版本类型(gos_gn,gos_pn)',
  `sendername` varchar(255) DEFAULT NULL COMMENT '发送者名称',
  `emailpriority` varchar(255) DEFAULT NULL COMMENT '邮件优先级(0：低级 1：普通 2：高级)',
  `remark` varchar(1000) DEFAULT NULL COMMENT '编码方式(0-GB2312； 1-Unicode-LE；2-Unicode-BE)',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caspnnewemail
-- ----------------------------

-- ----------------------------
-- Table structure for caspnnewfinger
-- ----------------------------
DROP TABLE IF EXISTS `caspnnewfinger`;
CREATE TABLE `caspnnewfinger` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '网络ID',
  `netid` int(10) DEFAULT NULL,
  `cardid` varchar(255) DEFAULT NULL,
  `conditioncontent` varchar(255) DEFAULT NULL,
  `expiredtime` datetime DEFAULT NULL COMMENT '过期时间',
  `reservedfutureuse` varchar(255) DEFAULT NULL COMMENT '保留字典',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `lockscreen` varchar(255) DEFAULT NULL COMMENT '锁定用',
  `duration` varchar(255) DEFAULT NULL COMMENT '显示时间长度',
  `intervaltime` varchar(255) DEFAULT NULL COMMENT '间隔时间',
  `showtimes` varchar(255) DEFAULT NULL COMMENT '显示次数',
  `fontsize` varchar(255) DEFAULT NULL,
  `fontcolor` varchar(255) DEFAULT NULL COMMENT '字体颜色RGBA',
  `backgroundcolor` varchar(255) DEFAULT NULL COMMENT '背景色RGBA',
  `postype` varchar(255) DEFAULT NULL COMMENT '显示的位置模式',
  `posx` varchar(255) DEFAULT NULL COMMENT '显示坐标X，PosType为1时有效',
  `posy` varchar(255) DEFAULT NULL COMMENT '显示坐标Y，PosType为1时有效',
  `channelids` varchar(255) DEFAULT NULL COMMENT '需要显示FP的频道号，多个以逗号(,)隔开',
  `showfreq` varchar(255) DEFAULT NULL COMMENT '显示频率',
  `showtype` varchar(255) DEFAULT NULL COMMENT '显示类型',
  `idtype` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL COMMENT '内容(8到16个字符)',
  `addtime` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `versiontype` varchar(255) DEFAULT NULL COMMENT '版本类型',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  `foregroundcolor` varchar(255) DEFAULT NULL COMMENT '前景色RGA',
  `foregroundtransparency` varchar(255) DEFAULT NULL COMMENT '前景透明度',
  `backgroundtransparency` varchar(255) DEFAULT NULL COMMENT '背景透明度',
  `fingerheight` varchar(255) DEFAULT NULL COMMENT '指纹高度',
  `encryptflag` varchar(255) DEFAULT NULL COMMENT '是否加密(0-不加密；1-加密）',
  `cardiddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否显示卡号（0-不显示；1-显示）',
  `terminaliddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否显示终端号（0-不显示；1-显示）',
  `operatoriddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否显示运营商号（0-不显示；1-显示）',
  `privatecontentflag` varchar(255) DEFAULT NULL COMMENT '是否显示私有内容（0-不显示；1-显示）',
  `hideflag` varchar(255) DEFAULT NULL COMMENT '是否隐藏（0-不隐藏；1-隐藏）',
  `ramdompositionflag` varchar(255) DEFAULT NULL COMMENT '指纹显示方式(0-指定位置显示；1-随机显示）',
  `fingerid` bigint(10) DEFAULT NULL COMMENT '指纹ID',
  `areaiddisplayflag` varchar(255) DEFAULT NULL COMMENT '是否包含区域ID',
  `displayfrequency` varchar(255) DEFAULT NULL COMMENT '显示频率',
  `displaydurationtime` varchar(255) DEFAULT NULL COMMENT '单次显示持续时间',
  `layout` varchar(255) DEFAULT NULL COMMENT '显示的布局(0-水平;1-垂直)',
  `fonttype` varchar(255) DEFAULT NULL COMMENT '字体类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caspnnewfinger
-- ----------------------------

-- ----------------------------
-- Table structure for caspnproductplay
-- ----------------------------
DROP TABLE IF EXISTS `caspnproductplay`;
CREATE TABLE `caspnproductplay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `playid` bigint(10) DEFAULT NULL COMMENT '产品准播限播ID',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡ID',
  `conditioncontent` varchar(1000) DEFAULT NULL COMMENT '条件内容',
  `productinfo` varchar(2000) DEFAULT NULL COMMENT '产品内容',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `expiredtime` datetime DEFAULT NULL COMMENT '过期时间',
  `casexpiredtime` datetime DEFAULT NULL COMMENT 'CAS过期时间',
  `versiontype` varchar(255) DEFAULT NULL COMMENT '版本类型(gos_gn,gos_pn)',
  `addressingmode` varchar(255) DEFAULT NULL COMMENT '寻址方式：单播-0；多播-1；',
  `conditioncount` varchar(255) DEFAULT NULL COMMENT '寻址段数',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caspnproductplay
-- ----------------------------

-- ----------------------------
-- Table structure for computer
-- ----------------------------
DROP TABLE IF EXISTS `computer`;
CREATE TABLE `computer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT ' 所属网络',
  `storeid` int(10) DEFAULT NULL COMMENT '所属营业厅',
  `computercode` varchar(255) DEFAULT NULL COMMENT '电脑编号',
  `ip` varchar(255) DEFAULT NULL COMMENT 'IP地址',
  `macaddress` varchar(255) DEFAULT NULL COMMENT 'MAC地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端电脑表';

-- ----------------------------
-- Records of computer
-- ----------------------------

-- ----------------------------
-- Table structure for currency
-- ----------------------------
DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '货币代码',
  `originalsymbol` varchar(255) DEFAULT NULL COMMENT '原有符号',
  `standardsymbol` varchar(255) DEFAULT NULL COMMENT '标准符号',
  `chinesename` varchar(255) DEFAULT NULL COMMENT '中文名称',
  `englishname` varchar(255) DEFAULT NULL COMMENT '英语名称',
  `country` varchar(255) DEFAULT NULL COMMENT '国别',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of currency
-- ----------------------------
INSERT INTO `currency` VALUES ('1', '344', 'HK＄', 'HKD', '港元', 'HongKong Dollars', '中国香港', null);
INSERT INTO `currency` VALUES ('2', '446', 'PAT.;P.', 'MOP', '澳门元', 'Macao Pataca', '中国澳门', null);
INSERT INTO `currency` VALUES ('3', '901', null, 'TWD', '中国台湾元', 'TAIWAN,CHINA DOLLAR', '中国台湾', null);
INSERT INTO `currency` VALUES ('4', '156', 'RMB￥', 'CNY', '人民币元', 'Renminbi Yuan', '中国', null);
INSERT INTO `currency` VALUES ('5', '408', null, 'KPW', '圆', 'Korean Won', '朝鲜', null);
INSERT INTO `currency` VALUES ('6', '704', 'D.', 'VND', '越南盾', 'Vietnamese Dong', '越南', null);
INSERT INTO `currency` VALUES ('7', '392', '￥;J.￥', 'JPY', '日圆', 'Japanese Yen', '日本', null);
INSERT INTO `currency` VALUES ('8', '418', 'K.', 'LAK', '基普', 'Laotian Kip', '老挝', null);

-- ----------------------------
-- Table structure for dispatch
-- ----------------------------
DROP TABLE IF EXISTS `dispatch`;
CREATE TABLE `dispatch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL,
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域',
  `dispatchno` varchar(255) DEFAULT NULL COMMENT '派工单号',
  `complaintid` int(10) DEFAULT NULL COMMENT '问题投诉ID',
  `complaintno` varchar(255) DEFAULT NULL COMMENT '问题投诉单号',
  `problemtype` varchar(255) DEFAULT NULL COMMENT '问题类型(1-硬件问题；2-软件问题；0-其他问题)',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `adddate` datetime DEFAULT NULL COMMENT '添加时间',
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `dispatcherid` int(10) DEFAULT NULL COMMENT '维修人员id',
  `content` varchar(1000) DEFAULT NULL COMMENT '派工内容',
  `dealdate` datetime DEFAULT NULL COMMENT '处理时间',
  `dealresult` varchar(1000) DEFAULT NULL COMMENT '处理结果',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-未派单；1-已派单；2-处理中；\r\n3-已处理；4-处理失败； 5-结单）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='派工单信息表';

-- ----------------------------
-- Records of dispatch
-- ----------------------------

-- ----------------------------
-- Table structure for dispatchdetail
-- ----------------------------
DROP TABLE IF EXISTS `dispatchdetail`;
CREATE TABLE `dispatchdetail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dispatchid` int(10) DEFAULT NULL COMMENT 'dispatchid',
  `dispatchno` varchar(255) DEFAULT NULL COMMENT '派工单单号',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络ID',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（1-图片；2-视频文件）',
  `filename` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `preservefilename` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `preserveurl` varchar(255) DEFAULT NULL COMMENT '存放地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='派工单明细表';

-- ----------------------------
-- Records of dispatchdetail
-- ----------------------------

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `serviceid` int(10) DEFAULT NULL COMMENT '所属业务ID',
  `eventId` varchar(255) DEFAULT NULL COMMENT '事件ID',
  `programid` varchar(255) DEFAULT NULL COMMENT '节目ID（可以是ServiceID+EventID形成的简单组合，保留字段）',
  `eventname` varchar(255) DEFAULT NULL COMMENT '事件名称（从子网的EPG获得）',
  `eventtype` varchar(255) DEFAULT NULL COMMENT '事件类型（从子网的EPG获得）',
  `description` varchar(1000) DEFAULT NULL COMMENT '事件描述（从子网的EPG获得）',
  `chargetype` varchar(255) DEFAULT NULL COMMENT '计费类型（1-按次收费；2-按秒收费）',
  `price` decimal(15,2) DEFAULT NULL COMMENT '事件单价',
  `extendflag` varchar(255) DEFAULT NULL COMMENT '是否推广（0-否；1-是）',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='事件信息表';

-- ----------------------------
-- Records of event
-- ----------------------------

-- ----------------------------
-- Table structure for eventextend
-- ----------------------------
DROP TABLE IF EXISTS `eventextend`;
CREATE TABLE `eventextend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络ID',
  `eventid` varchar(255) DEFAULT NULL COMMENT '事件ID',
  `webflag` varchar(255) DEFAULT NULL COMMENT '是否在WEB平台上显示（0-否；1-是）',
  `rank` varchar(255) DEFAULT NULL COMMENT '推荐等级（级别越高，在同类产品中的排序越靠前1,2,3,4,5）',
  `description` varchar(1000) DEFAULT NULL COMMENT '描述文字',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（1-海报图片；2-视频文件）',
  `filename` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `preservefilename` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `preserveurl` varchar(255) DEFAULT NULL COMMENT '存放地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='事件推广表';

-- ----------------------------
-- Records of eventextend
-- ----------------------------

-- ----------------------------
-- Table structure for giftcard
-- ----------------------------
DROP TABLE IF EXISTS `giftcard`;
CREATE TABLE `giftcard` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `giftcardno` varchar(255) DEFAULT NULL COMMENT '礼品卡号',
  `password` varchar(255) DEFAULT NULL COMMENT '礼品卡密码',
  `batchno` varchar(255) DEFAULT NULL COMMENT '批次号',
  `serialno` varchar(255) DEFAULT NULL COMMENT '序列号(当天递增，默认开始位000001)',
  `amount` decimal(15,2) DEFAULT NULL COMMENT '面额',
  `amountpara` varchar(255) DEFAULT NULL COMMENT '面额参数',
  `price` decimal(15,2) DEFAULT NULL COMMENT '价格',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `printflag` varchar(255) DEFAULT NULL COMMENT '印刷标志（0-否；1-是）',
  `usedflag` varchar(255) DEFAULT NULL COMMENT '使用标志（0-未使用；1-已使用）',
  `addtime` datetime DEFAULT NULL COMMENT '生成时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of giftcard
-- ----------------------------

-- ----------------------------
-- Table structure for giftcardamountpara
-- ----------------------------
DROP TABLE IF EXISTS `giftcardamountpara`;
CREATE TABLE `giftcardamountpara` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parakey` varchar(255) DEFAULT NULL COMMENT '价格KEY',
  `amount` decimal(15,2) DEFAULT NULL COMMENT '价格值',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of giftcardamountpara
-- ----------------------------
INSERT INTO `giftcardamountpara` VALUES ('1', 'A', '100.00', '1', null);
INSERT INTO `giftcardamountpara` VALUES ('2', 'B', '50.00', '1', null);
INSERT INTO `giftcardamountpara` VALUES ('3', 'C', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('4', 'D', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('5', 'E', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('6', 'F', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('7', 'G', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('8', 'H', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('9', 'I', '0.00', '0', null);
INSERT INTO `giftcardamountpara` VALUES ('10', 'J', '0.00', '0', null);

-- ----------------------------
-- Table structure for helpinfo
-- ----------------------------
DROP TABLE IF EXISTS `helpinfo`;
CREATE TABLE `helpinfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `question` varchar(1000) DEFAULT NULL COMMENT '问题内容',
  `answer` varchar(1000) DEFAULT NULL COMMENT '解决方法',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（0-常见问题 1-其他问题）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of helpinfo
-- ----------------------------

-- ----------------------------
-- Table structure for httprequestlog
-- ----------------------------
DROP TABLE IF EXISTS `httprequestlog`;
CREATE TABLE `httprequestlog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requesturl` varchar(1000) DEFAULT NULL,
  `requestparam` varchar(1000) DEFAULT NULL,
  `result` varchar(1000) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of httprequestlog
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(10) DEFAULT NULL COMMENT '上级菜单',
  `menutype` varchar(255) DEFAULT NULL COMMENT '菜单级数',
  `addtime` datetime DEFAULT NULL COMMENT '创建时间',
  `menuorder` double(10,4) DEFAULT NULL COMMENT '排序',
  `menuname` varchar(255) DEFAULT NULL COMMENT '菜单名称',
  `menucode` varchar(255) DEFAULT NULL COMMENT '菜单编码（用于多语言国际化）',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `menuurl` varchar(255) DEFAULT NULL COMMENT '菜单链接',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', null, '1', '2016-04-21 15:20:11', '1.0000', '个人业务', 'menu.business.manage', '1', null, null);
INSERT INTO `menu` VALUES ('2', null, '1', '2016-04-21 15:22:18', '2.0000', '产品管理', 'menu.product.manage', '1', null, null);
INSERT INTO `menu` VALUES ('3', null, '1', '2016-04-21 15:28:02', '3.0000', '设备管理', 'menu.device.manage', '1', null, null);
INSERT INTO `menu` VALUES ('4', null, '1', '2016-04-21 15:35:35', '4.0000', '工单管理', 'menu.dispatch.manage', '1', null, null);
INSERT INTO `menu` VALUES ('5', null, '1', '2016-04-21 15:39:11', '8.0000', '普安授权', 'menu.command.pn', '0', null, null);
INSERT INTO `menu` VALUES ('6', null, '1', '2016-04-21 15:41:56', '6.0000', '系统管理', 'menu.system.manage', '1', null, null);
INSERT INTO `menu` VALUES ('7', null, '1', '2016-04-21 17:06:37', '7.0000', '查询统计', 'menu.stat.manage', '1', null, null);
INSERT INTO `menu` VALUES ('8', '1', '2', '2016-05-05 16:23:07', '1.0100', '订户查询', 'menu.business.userquery', '1', 'user/businessUnit?businesstype=queryUser', null);
INSERT INTO `menu` VALUES ('9', '1', '2', '2016-05-05 16:25:10', '1.0200', '订户开户', 'menu.business.useradd', '1', 'user/addInit?businesstype=addUser', null);
INSERT INTO `menu` VALUES ('10', '1', '2', '2016-05-05 16:26:17', '1.0300', '设备购买', 'menu.business.devicebuy', '1', 'user/businessUnit?businesstype=buyDevice', null);
INSERT INTO `menu` VALUES ('11', '1', '2', '2016-05-05 16:31:27', '1.0400', '产品购买', 'menu.business.productbuy', '1', 'user/businessUnit?businesstype=buyProduct', null);
INSERT INTO `menu` VALUES ('12', '1', '2', '2016-05-05 16:39:08', '1.0500', '停开机', 'menu.business.stopandon', '1', 'user/businessUnit?businesstype=stopAndOn', null);
INSERT INTO `menu` VALUES ('13', '1', '2', '2016-05-05 16:41:15', '1.0600', '过户', 'menu.business.usertransfer', '1', 'user/businessUnit?businesstype=transferUser', null);
INSERT INTO `menu` VALUES ('14', '1', '2', '2016-05-05 16:42:52', '1.0700', '销户', 'menu.business.usercancel', '0', 'user/businessUnit?businesstype=cancelUser', null);
INSERT INTO `menu` VALUES ('15', '1', '2', '2016-05-05 16:44:44', '1.0800', '迁移', 'menu.business.addresstransfer', '1', 'user/businessUnit?businesstype=transferAddress', null);
INSERT INTO `menu` VALUES ('16', '1', '2', '2016-05-05 16:56:18', '1.0900', '更换机顶盒', 'menu.business.stbreplace', '1', 'user/businessUnit?businesstype=replaceStb', null);
INSERT INTO `menu` VALUES ('17', '1', '2', '2016-05-05 16:56:18', '1.1000', '更换智能卡', 'menu.business.cardreplace', '1', 'user/businessUnit?businesstype=replaceCard', '');
INSERT INTO `menu` VALUES ('18', '1', '2', '2016-05-05 16:57:04', '1.1600', '发票打印', 'menu.business.invoiceprint', '1', 'user/businessUnit?businesstype=invoicePrint', null);
INSERT INTO `menu` VALUES ('19', '1', '2', '2016-05-05 17:03:57', '1.1100', '账户充值', 'menu.business.accountrecharge', '1', 'user/businessUnit?businesstype=rechargeAccount', null);
INSERT INTO `menu` VALUES ('20', '1', '2', '2016-05-05 17:18:20', '1.1200', '电子钱包充值', 'menu.business.walletrecharge', '1', 'user/businessUnit?businesstype=rechargeWallet', null);
INSERT INTO `menu` VALUES ('21', '1', '2', '2016-05-05 17:24:19', '1.1300', '订户信息修改', 'menu.business.userupdate', '1', 'user/businessUnit?businesstype=updateUser', null);
INSERT INTO `menu` VALUES ('22', '1', '2', '2016-05-05 17:21:57', '1.1400', '问题投诉', 'menu.business.problemcomplaint', '0', 'user/businessUnit?businesstype=problemcomplaint', null);
INSERT INTO `menu` VALUES ('23', '2', '2', '2016-05-06 08:36:03', '2.0100', '业务管理', 'menu.product.service', '1', 'service/findByList', null);
INSERT INTO `menu` VALUES ('24', '2', '2', '2016-05-06 08:38:29', '2.0200', '业务推广', 'menu.product.serviceextend', '1', 'service/servicePromotion', null);
INSERT INTO `menu` VALUES ('25', '2', '2', '2016-05-06 10:42:26', '2.0300', '产品管理', 'menu.product.product', '1', 'product/findByList', null);
INSERT INTO `menu` VALUES ('26', '2', '2', '2016-05-06 10:44:06', '2.0400', '产品推广', 'menu.product.productextend', '1', 'product/productPromotion', null);
INSERT INTO `menu` VALUES ('27', '2', '2', '2016-05-06 10:45:03', '2.0500', '节目事件管理', 'menu.product.event', '0', null, null);
INSERT INTO `menu` VALUES ('28', '2', '2', '2016-05-06 10:45:53', '2.0600', '节目事件推广', 'menu.product.eventextend', '0', null, null);
INSERT INTO `menu` VALUES ('29', '2', '2', '2016-05-06 10:46:25', '2.0700', '套餐管理', 'menu.product.package', '1', 'package/findByList', null);
INSERT INTO `menu` VALUES ('30', '3', '2', '2016-05-06 11:13:12', '3.0100', '厂商标识管理', 'menu.device.provider', '1', 'provider/findByList', null);
INSERT INTO `menu` VALUES ('31', '3', '2', '2016-05-06 14:00:15', '3.0200', '设备规格型号', 'menu.device.devicemodel', '0', '', null);
INSERT INTO `menu` VALUES ('32', '3', '2', '2016-05-06 14:10:01', '3.0300', '机顶盒管理', 'menu.device.stb', '1', 'stb/findByList', null);
INSERT INTO `menu` VALUES ('33', '3', '2', '2016-05-06 14:10:44', '3.0400', '智能卡管理', 'menu.device.card', '1', 'card/findByList', null);
INSERT INTO `menu` VALUES ('34', '4', '2', '2016-05-06 14:11:30', '4.0100', '问题投诉', 'menu.dispatch.problemcomplaint', '1', 'problemcomplaint/findByList', null);
INSERT INTO `menu` VALUES ('35', '4', '2', '2016-05-06 14:16:40', '4.0200', '工单查询', 'menu.dispatch.dispatchquery', '1', 'dispatch/findByList?jumping=findDispatchList', null);
INSERT INTO `menu` VALUES ('36', '4', '2', '2016-05-06 14:17:28', '4.0300', '工单派工', 'menu.dispatch.dispatchassign', '1', 'dispatch/findByList?jumping=findDispatchListForAssign&querystate=0', null);
INSERT INTO `menu` VALUES ('37', '4', '2', '2016-05-06 14:18:28', '4.0400', '工单回单', 'menu.dispatch.dispatchreply', '1', 'dispatch/findByList?jumping=findReturnDispatchList&querystate=12', null);
INSERT INTO `menu` VALUES ('38', '4', '2', '2016-05-06 14:19:28', '4.0500', '工单审核', 'menu.dispatch.dispatchcheck', '1', 'dispatch/findByList?jumping=findDispatchListForCheck&querystate=34', null);
INSERT INTO `menu` VALUES ('39', '1', '2', '2016-05-06 14:20:24', '1.1500', '授权刷新', 'menu.authorize.authorizerefresh', '1', 'user/businessUnit?businesstype=authorizeRefresh', null);
INSERT INTO `menu` VALUES ('40', '5', '2', '2016-05-06 14:22:00', '5.0200', '批量预授权', 'menu.authorize.batchpreauthorize', '0', 'cas_pn/add_Cmd01', null);
INSERT INTO `menu` VALUES ('41', '5', '2', '2016-05-06 14:24:02', '5.0300', '条件OSD/Mail', 'menu.authorize.osdmail', '0', 'authorize/osdAndMail', null);
INSERT INTO `menu` VALUES ('42', '5', '2', '2016-05-06 14:24:42', '5.0400', '授权记录查询', 'menu.authorize.authorizequery', '0', 'authorize/findByList', null);
INSERT INTO `menu` VALUES ('43', '6', '2', '2016-05-06 14:26:27', '6.0100', '操作员管理', 'menu.system.operator', '1', 'operator/findByList', null);
INSERT INTO `menu` VALUES ('44', '6', '2', '2016-05-06 14:28:30', '6.0200', '角色管理', 'menu.system.role', '1', 'role/findByList', null);
INSERT INTO `menu` VALUES ('45', '6', '2', '2016-05-06 14:32:49', '6.0300', '网络管理', 'menu.system.network', '1', 'network/findByList', null);
INSERT INTO `menu` VALUES ('46', '6', '2', '2016-05-06 14:37:23', '6.0400', '服务器管理', 'menu.system.server', '1', 'server/findByList', null);
INSERT INTO `menu` VALUES ('47', '6', '2', '2016-05-06 14:56:53', '6.0500', '区域管理', 'menu.system.area', '1', 'area/findByList', null);
INSERT INTO `menu` VALUES ('48', '6', '2', '2016-05-06 14:57:23', '6.0600', '营业厅管理', 'menu.system.store', '1', 'store/findByList', null);
INSERT INTO `menu` VALUES ('49', '6', '2', '2016-05-06 15:00:17', '6.0700', '计算机管理', 'menu.system.computer', '0', 'computer/findByList', null);
INSERT INTO `menu` VALUES ('50', '6', '2', '2016-05-06 15:01:38', '6.0800', '发票模板管理', 'menu.system.invoicetemplate', '1', 'print/findByList', null);
INSERT INTO `menu` VALUES ('51', '6', '2', '2016-05-06 15:02:45', '6.0900', '系统参数管理', 'menu.system.systempara', '1', 'systempara/findByList', null);
INSERT INTO `menu` VALUES ('52', '7', '2', '2016-05-06 15:27:55', '7.0100', '操作员日报', 'menu.stat.operatorreport', '1', 'statreport/operatorBusinessStat', null);
INSERT INTO `menu` VALUES ('53', '7', '2', '2016-05-06 15:29:53', '7.0200', '操作员日志查询', 'menu.stat.operatorreportlist', '1', 'statreport/operatorBusinessStatdetail', null);
INSERT INTO `menu` VALUES ('54', '7', '2', '2016-05-06 15:31:29', '7.0300', '营业厅营业报表', 'menu.stat.storereport', '0', 'statistic/findStoreList', null);
INSERT INTO `menu` VALUES ('55', '7', '2', '2016-05-06 15:34:00', '7.0400', '产品购买统计', 'menu.stat.productbuyedstat', '0', 'statistic/findUserProductList', null);
INSERT INTO `menu` VALUES ('56', '7', '2', '2016-05-06 15:34:57', '7.0500', '订户状态查询', 'menu.stat.userstatequery', '0', 'statistic/findUserList', null);
INSERT INTO `menu` VALUES ('57', '1', '2', '2016-05-06 14:18:28', '1.1600', '业务操作记录', 'menu.business.businessquery', '1', 'user/businessUnit?businesstype=queryBusiness', null);
INSERT INTO `menu` VALUES ('58', '1', '2', '2016-05-06 14:18:28', '1.0110', '订户业务信息', 'menu.business.businessinfo', '1', 'user/businessUnit?businesstype=businessInfo', null);
INSERT INTO `menu` VALUES ('59', '5', '2', '0016-05-06 14:18:28', '5.0500', '强制重启机顶盒', 'menu.authorize.forcerestartstb', '0', 'cas_pn/add_Cmd33', null);
INSERT INTO `menu` VALUES ('60', '5', '2', '2016-11-24 09:43:55', '5.0600', '新Email指令', 'menu.authorize.newemail', '0', 'cas_pn/find_Cmd35_List', null);
INSERT INTO `menu` VALUES ('61', '5', '2', '2016-11-24 09:45:15', '5.0700', 'PVA再授权', 'menu.authorize.pvrentitle', '0', 'cas_pn/add_Cmd38', null);
INSERT INTO `menu` VALUES ('62', '5', '2', '2016-11-24 09:47:25', '5.0800', '机顶盒黑名单', 'menu.authorize.blackstb', '0', 'cas_pn/find_Cmd46_List', null);
INSERT INTO `menu` VALUES ('63', '5', '2', '2016-11-24 09:51:37', '5.0900', '智能卡黑名单', 'menu.authorize.blackcard', '0', 'cas_pn/find_Cmd44_List', null);
INSERT INTO `menu` VALUES ('64', '5', '2', '2016-11-24 09:52:16', '5.1000', '强制OSD', 'menu.authorize.forceosd', '0', 'cas_pn/find_Cmd29_List', null);
INSERT INTO `menu` VALUES ('65', '5', '2', '2016-11-24 09:53:41', '5.1100', '强制换台', 'menu.authorize.forcechangechannel', '0', 'cas_pn/find_Cmd32_List', null);
INSERT INTO `menu` VALUES ('66', '5', '2', '2016-11-24 09:54:51', '5.1200', '删除发卡指令', 'menu.authorize.deleteerrcard', '0', 'cas_pn/add_Cmd51', null);
INSERT INTO `menu` VALUES ('67', '5', '2', '2016-11-24 09:56:13', '5.1300', '机顶盒开机信息', 'menu.authorize.stbdefaultmessage', '0', 'cas_pn/add_Cmd34', null);
INSERT INTO `menu` VALUES ('68', '5', '2', '2016-11-24 09:58:29', '5.1400', '新版指纹显示', 'menu.authorize.newshowfinger', '0', 'cas_pn/find_Cmd60_List', null);
INSERT INTO `menu` VALUES ('69', '1', '2', '2016-11-24 09:58:29', '1.1700', '产品取消', 'menu.business.cancelproduct', '1', 'user/businessUnit?businesstype=cancelproduct', null);
INSERT INTO `menu` VALUES ('70', '1', '2', '0016-11-24 09:58:29', '1.1800', '设备回收', 'menu.business.rebackdevice', '1', 'user/businessUnit?businesstype=rebackdevice', null);
INSERT INTO `menu` VALUES ('71', '6', '2', '0016-11-24 09:58:29', '6.1000', '业务类型管理', 'menu.system.businesstype', '1', 'businesstype/findByList', null);
INSERT INTO `menu` VALUES ('72', null, '1', '2016-12-28 14:52:47', '9.0000', '高安指令', 'menu.command.gn', '0', null, null);
INSERT INTO `menu` VALUES ('73', '5', '2', '2016-12-30 14:14:15', '5.1500', '重置PIN码', 'menu.authorize.resetpincode', '1', 'cas_pn/add_Cmd03', '');
INSERT INTO `menu` VALUES ('74', '1', '2', '2017-04-27 16:23:34', '1.1900', '重置机卡绑定', 'menu.business.resetbinding', '1', 'user/businessUnit?businesstype=resetbinding', null);
INSERT INTO `menu` VALUES ('75', '1', '2', '2017-05-05 16:01:11', '1.2000', '订户账户记录', 'menu.business.accountlog', '1', 'user/businessUnit?businesstype=accountlog', null);
INSERT INTO `menu` VALUES ('80', '3', '2', '2017-05-04 13:48:51', '3.0500', '充值卡面额管理', 'menu.device.giftcardamount', '1', 'giftcardamountpara/findByList', null);
INSERT INTO `menu` VALUES ('81', '3', '2', '2017-05-15 16:48:46', '3.0600', '充值卡管理', 'menu.device.giftcard', '1', 'giftcard/findByList', null);
INSERT INTO `menu` VALUES ('82', '1', '2', '2017-05-16 14:49:57', '1.2100', '充值卡充值', 'menu.business.giftcardrecharge', '1', 'user/businessUnit?businesstype=giftcardrecharge', null);
INSERT INTO `menu` VALUES ('83', '4', '2', '2017-05-18 16:37:14', '4.0600', '帮助信息', 'menu.dispatch.helpinfo', '1', 'helpinfo/findByList', null);
INSERT INTO `menu` VALUES ('84', '6', '2', '2017-06-01 10:57:40', '6.1200', '数据库恢复', 'menu.system.databaserestore', '0', 'databaserestore/databaserestoreInit', null);
INSERT INTO `menu` VALUES ('85', '4', '2', '2017-06-06 17:10:04', '4.0700', '订户反馈', 'menu.dispatch.userfeedback', '1', 'userfeedback/findByList', null);
INSERT INTO `menu` VALUES ('86', '7', '2', '2017-08-28 10:43:45', '7.0700', '订户收费记录', 'menu.stat.userchargerecord', '1', 'statreport/userChargeRecord', null);
INSERT INTO `menu` VALUES ('87', '7', '2', '2017-08-28 11:09:07', '7.0800', '订户终端状态统计', 'menu.stat.userterminalstatestat', '1', 'statreport/userTerminalStateStat', null);
INSERT INTO `menu` VALUES ('88', '7', '2', '2017-08-29 11:24:39', '7.0900', '订户产品到期统计', 'menu.stat.userproductexpiredstat', '1', 'statreport/userProductExpiredStat', null);
INSERT INTO `menu` VALUES ('89', '7', '2', '2017-08-30 10:55:59', '7.1000', '产品收视统计', 'menu.stat.userproductaudiencestat', '1', 'statreport/userProductAudienceStat', null);
INSERT INTO `menu` VALUES ('90', '1', '2', '2017-09-01 10:47:02', '1.1890', '解除机卡绑定', 'menu.business.removebinding', '1', 'user/businessUnit?businesstype=removebinding', null);
INSERT INTO `menu` VALUES ('91', '1', '2', '2017-09-03 15:32:05', '1.2200', '套餐购买', 'menu.authorize.buypackage', '1', 'package/findPackagelistForBuy', null);
INSERT INTO `menu` VALUES ('92', '6', '2', '2017-08-31 10:41:55', '6.1100', '数据库导出', 'menu.system.exportdata', '0', 'backupdata/databasestoreInit', null);
INSERT INTO `menu` VALUES ('93', '7', '2', '2017-09-12 09:20:42', '7.1100', '订户产品欠费统计', 'menu.stat.userProductArrearsStat', '1', 'statreport/userProductArrearsStat', null);
INSERT INTO `menu` VALUES ('94', '7', '2', '2017-09-13 16:22:54', '7.1200', '产品购买统计', 'menu.stat.productbuyedstat', '1', 'statreport/userProductPurchasedStat', null);
INSERT INTO `menu` VALUES ('95', '1', '2', '2017-11-29 15:01:08', '1.2300', '其他费用收费', 'menu.business.otherexpenses', '1', 'user/businessUnit?businesstype=feecollection ', null);
INSERT INTO `menu` VALUES ('96', '1', '2', '2017-11-29 15:26:59', '1.2400', '订户密码修改', 'menu.business.updateuserpassword', '1', 'user/businessUnit?businesstype=updateUserpassword', null);
INSERT INTO `menu` VALUES ('97', '7', '2', '2017-11-29 15:29:16', '7.1600', 'APP端业务汇总', 'menu.stat.mobileBusinessStat', '1', 'statreport/mobileBusinessStat', null);
INSERT INTO `menu` VALUES ('98', '7', '2', '2017-11-29 15:30:14', '7.1700', 'APP端业务明细', 'menu.stat.mobileBusinessStatdetail', '1', 'statreport/mobileBusinessStatdetail', null);
INSERT INTO `menu` VALUES ('99', '7', '2', '2017-11-29 15:31:04', '7.1800', '用户离线统计', 'menu.stat.userOfflineStat', '1', 'statreport/userOfflineStat', null);
INSERT INTO `menu` VALUES ('100', null, '1', '2016-12-30 14:14:15', '10.0000', 'CAS指令', 'menu.authorize.cascommand', '1', '', null);
INSERT INTO `menu` VALUES ('101', '100', '2', '2016-12-30 14:14:15', '100.0500', '新Email指令', 'menu.authorize.newemail', '1', 'cascommand/find_newemail_List', null);
INSERT INTO `menu` VALUES ('102', '100', '2', '2017-01-06 13:44:51', '100.0600', '强制OSD', 'menu.authorize.forceosd', '1', 'cascommand/find_forcedosd_List', null);
INSERT INTO `menu` VALUES ('103', '100', '2', '2017-01-09 15:33:29', '100.0700', '新版指纹显示', 'menu.authorize.newshowfinger', '1', 'cascommand/find_newfinger_List', null);
INSERT INTO `menu` VALUES ('104', '100', '2', '2017-01-11 14:38:42', '100.0800', '强制换台', 'menu.authorize.forcechangechannel', '1', 'cascommand/find_forcedcc_List', null);
INSERT INTO `menu` VALUES ('105', '100', '2', '2017-01-13 14:52:07', '100.0900', '机顶盒默认开机节目', 'menu.authorize.stbdefaultmessage', '1', 'cascommand/add_stbdefaultmsg_Init', null);
INSERT INTO `menu` VALUES ('106', '100', '2', '2017-01-13 17:29:00', '100.1000', '强制重启', 'menu.authorize.forcerestartstb', '1', 'cascommand/add_forcedrestart_Init', null);
INSERT INTO `menu` VALUES ('107', '100', '2', '2017-01-16 16:10:03', '100.1100', '重新搜索节目', 'menu.authorize.researchprogram', '1', 'cascommand/add_researchprogram_Init', null);
INSERT INTO `menu` VALUES ('108', '100', '2', '2017-01-16 16:41:05', '100.1200', 'PVA再授权', 'menu.authorize.pvrentitle', '1', 'cascommand/add_pvrauthemm_Init', null);
INSERT INTO `menu` VALUES ('109', '100', '2', '2017-01-17 14:07:10', '100.1300', '机顶盒黑名单', 'menu.authorize.blackstb', '1', 'cascommand/find_blackstb_List', null);
INSERT INTO `menu` VALUES ('110', '100', '2', '2017-01-18 11:17:11', '100.0100', '智能卡黑名单', 'menu.authorize.blackcard', '1', 'cascommand/find_blackcard_List', null);
INSERT INTO `menu` VALUES ('111', '100', '2', '2017-01-19 14:05:02', '100.0200', '重置PIN码', 'menu.authorize.resetpincode', '1', 'cascommand/add_resetpincode_Init', null);
INSERT INTO `menu` VALUES ('112', '100', '2', '2017-01-20 11:33:32', '100.0300', '清除PIN码', 'menu.authorize.cleanpincode', '1', 'cascommand/add_cleanpincode_Init', null);
INSERT INTO `menu` VALUES ('113', '100', '2', '2017-01-20 14:16:30', '100.0400', '删除错误发卡指令', 'menu.authorize.deleteerrcard', '1', 'cascommand/add_deleteerrcard_Init', null);
INSERT INTO `menu` VALUES ('114', '100', '2', '2017-01-21 09:38:50', '100.1400', '批量预授权', 'menu.authorize.batchpreauthorize', '1', 'cascommand/add_batchpreauthorize_Init', null);
INSERT INTO `menu` VALUES ('115', '100', '2', '2017-05-23 08:47:34', '100.1500', '批量授权', 'menu.authorize.batchauthorize', '1', 'cascommand/add_batchauthorize_Init', null);
INSERT INTO `menu` VALUES ('116', '100', '2', '2017-05-23 17:07:47', '100.1600', '批量关停', 'menu.authorize.batchstop', '1', 'cascommand/add_batchstop_Init', null);
INSERT INTO `menu` VALUES ('117', '100', '2', '2017-05-24 10:39:58', '100.1700', '批量授权刷新', 'menu.authorize.batchauthorizerefresh', '1', 'cascommand/add_batchauthorizerefresh_Init', null);
INSERT INTO `menu` VALUES ('118', '100', '2', '2017-05-24 16:33:09', '100.1800', '批量发卡', 'menu.authorize.batchsendcard', '1', 'cascommand/add_batchsendcard_Init', null);
INSERT INTO `menu` VALUES ('119', '100', '2', '2017-12-08 17:29:55', '100.1900', 'OSD', 'menu.authorize.osd', '1', 'cascommand/add_osd_Init', null);
INSERT INTO `menu` VALUES ('120', '100', '2', '2017-12-08 17:33:19', '100.2000', '邮件', 'menu.authorize.email', '1', 'cascommand/add_email_Init', null);
INSERT INTO `menu` VALUES ('121', '100', '2', '2017-12-08 17:34:40', '100.2100', '指纹', 'menu.authorize.finger', '1', 'cascommand/add_finger_Init', null);
INSERT INTO `menu` VALUES ('122', '100', '2', '2018-01-10 17:29:48', '100.2200', '产品限播', 'menu.authorize.productplaylimit', '1', 'cascommand/add_productplaylimit_Init', null);
INSERT INTO `menu` VALUES ('123', '100', '2', '2018-01-10 17:31:18', '100.2300', '产品准播', 'menu.authorize.productplayallow', '1', 'cascommand/find_productplayallow_List', null);
INSERT INTO `menu` VALUES ('124', '100', '2', '2018-01-10 17:32:02', '100.2400', 'PVR功能控制', 'menu.authorize.pvrcontrol', '1', 'cascommand/add_pvrcontrol_Init', null);
INSERT INTO `menu` VALUES ('131', '6', '2', '2017-09-29 17:13:30', '6.1300', '订户级别管理', 'menu.system.userlevel', '1', 'userlevel/findByList', '');
INSERT INTO `menu` VALUES ('132', '6', '2', '2017-12-14 17:42:09', '6.1400', '活动信息', 'menu.system.activityinfo', '1', 'activityinfo/findByList', null);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `messagertype` varchar(255) DEFAULT NULL COMMENT '留言人类型(0-客服 1-订户)',
  `messagerid` int(10) DEFAULT NULL COMMENT '留言人ID',
  `dispatchid` int(10) DEFAULT NULL COMMENT '工单ID',
  `content` varchar(1000) DEFAULT NULL COMMENT '留言内容',
  `addtime` datetime DEFAULT NULL COMMENT '留言时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for network
-- ----------------------------
DROP TABLE IF EXISTS `network`;
CREATE TABLE `network` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` varchar(255) DEFAULT NULL COMMENT '网络ID',
  `pid` int(10) DEFAULT NULL COMMENT '父网络ID（如果是根节点，此字段为空）',
  `code` varchar(255) DEFAULT NULL COMMENT '网络编号（有规则的编号，方便管理拓扑结构，举例：001，002,001001等。',
  `netname` varchar(255) DEFAULT NULL COMMENT '网络名称',
  `nettype` varchar(255) DEFAULT NULL COMMENT '网络类型（0-无备独立前端；1-有独立前端）',
  `address` varchar(255) DEFAULT NULL COMMENT '网络地理位置',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网络信息表';

-- ----------------------------
-- Records of network
-- ----------------------------

-- ----------------------------
-- Table structure for operator
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `loginname` varchar(255) DEFAULT NULL COMMENT '登录名称',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `operatorlevel` varchar(255) DEFAULT NULL COMMENT '操作员级别（0-系统级别；1-网络级别；2-区域级别）',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域编码',
  `storeid` int(10) DEFAULT NULL COMMENT '所属营业厅',
  `operatorcode` varchar(255) DEFAULT NULL COMMENT '操作员编号',
  `operatorname` varchar(255) DEFAULT NULL COMMENT '操作员姓名',
  `operatortype` varchar(255) DEFAULT NULL COMMENT '操作员类型（0-超级管理人员；1-操作员；2-施工人员;3-管理人员）',
  `documenttype` varchar(255) DEFAULT NULL COMMENT '证件类型',
  `documentno` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮件地址',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `telephone` varchar(255) DEFAULT NULL COMMENT '固定电话',
  `mobile` varchar(255) DEFAULT NULL COMMENT '移动电话',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `state` varchar(255) DEFAULT NULL COMMENT '操作员状态(0-无效；1-有效)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='操作员信息表';

-- ----------------------------
-- Records of operator
-- ----------------------------
INSERT INTO `operator` VALUES ('1', 'admin', '0', '0', null, null, null, null, 'Super admin', '0', null, null, null, null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for operatorinvoice
-- ----------------------------
DROP TABLE IF EXISTS `operatorinvoice`;
CREATE TABLE `operatorinvoice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `operatorid` int(10) NOT NULL COMMENT '操作员ID',
  `startinvoicecode` varchar(255) DEFAULT NULL COMMENT '开始发票号',
  `endinvoicecode` varchar(255) DEFAULT NULL COMMENT '结束发票号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorid` (`operatorid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operatorinvoice
-- ----------------------------

-- ----------------------------
-- Table structure for operatorlogs
-- ----------------------------
DROP TABLE IF EXISTS `operatorlogs`;
CREATE TABLE `operatorlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络ID',
  `serviceid` int(10) DEFAULT NULL COMMENT '所属前端ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '所属区域号',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `usercode` varchar(255) DEFAULT NULL COMMENT '订户编号',
  `username` varchar(255) DEFAULT NULL COMMENT '订户名称',
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `operatorcode` varchar(255) DEFAULT NULL COMMENT '操作员编号',
  `operatorname` varchar(255) DEFAULT NULL COMMENT '操作员名称',
  `businesstypekey` varchar(255) DEFAULT NULL COMMENT '业务类型Key',
  `businesstypename` varchar(255) DEFAULT NULL COMMENT '业务类型名称',
  `content` varchar(1000) DEFAULT NULL COMMENT '操作内容',
  `addtime` datetime DEFAULT NULL COMMENT 'addtime',
  `source` varchar(255) DEFAULT NULL COMMENT '操作类型(0-BOSS;1-MPS)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志记录表';

-- ----------------------------
-- Records of operatorlogs
-- ----------------------------

-- ----------------------------
-- Table structure for operatorroleref
-- ----------------------------
DROP TABLE IF EXISTS `operatorroleref`;
CREATE TABLE `operatorroleref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `roleid` int(10) DEFAULT NULL COMMENT '角色ID',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='操作员角色关系表';

-- ----------------------------
-- Records of operatorroleref
-- ----------------------------
INSERT INTO `operatorroleref` VALUES ('1', '1', '1', null);

-- ----------------------------
-- Table structure for package
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `name` varchar(255) DEFAULT NULL COMMENT '套餐名称',
  `type` varchar(255) DEFAULT NULL COMMENT '套餐类型(0-开户套餐；1-续费套餐)',
  `usertype` varchar(255) DEFAULT NULL COMMENT '指定订户类型(0-全部；1-指定)',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域编号',
  `service_ids` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `package_json` varchar(10000) DEFAULT NULL COMMENT '套餐内容JOSN数据',
  `starttime` datetime DEFAULT NULL COMMENT '开始有效时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束有效时间',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `totalmoney` decimal(15,2) DEFAULT '0.00' COMMENT '总价',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of package
-- ----------------------------

-- ----------------------------
-- Table structure for printpara
-- ----------------------------
DROP TABLE IF EXISTS `printpara`;
CREATE TABLE `printpara` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '参数编码',
  `name` varchar(255) DEFAULT NULL COMMENT '参数名称',
  `state` varchar(255) DEFAULT NULL COMMENT '状态(0无效；1-有效)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of printpara
-- ----------------------------
INSERT INTO `printpara` VALUES ('1', 'totalPrice', '总金额', '1', '');
INSERT INTO `printpara` VALUES ('2', 'printlist', '列表', '1', '');
INSERT INTO `printpara` VALUES ('3', 'clientName', '客户名', '1', '');
INSERT INTO `printpara` VALUES ('4', 'clientCode', '用户编号', '1', '');
INSERT INTO `printpara` VALUES ('5', 'operateDate', '操作日期', '1', null);
INSERT INTO `printpara` VALUES ('6', 'printDate', '打印日期', '1', null);
INSERT INTO `printpara` VALUES ('7', 'operatorCode', '操作员编号', '1', null);
INSERT INTO `printpara` VALUES ('8', 'operatorName', '操作员姓名', '1', null);
INSERT INTO `printpara` VALUES ('9', 'storeName', '营业厅名称', '1', null);
INSERT INTO `printpara` VALUES ('10', 'taxpayerCode', '纳税人识别号', '1', null);
INSERT INTO `printpara` VALUES ('11', 'taxpayerName', '纳税人名称', '1', null);
INSERT INTO `printpara` VALUES ('12', 'remark', '备注', '1', '');
INSERT INTO `printpara` VALUES ('13', 'invoiceNumber', '发票号', '0', '');
INSERT INTO `printpara` VALUES ('14', 'amountPrice', '总金额（大写）', '0', '');
INSERT INTO `printpara` VALUES ('15', 'receivablesname', '收款方', '1', '');
INSERT INTO `printpara` VALUES ('16', 'receivablescode', '税务登记证号码', '1', '');

-- ----------------------------
-- Table structure for printtemplate
-- ----------------------------
DROP TABLE IF EXISTS `printtemplate`;
CREATE TABLE `printtemplate` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '打印模板编码',
  `name` varchar(255) DEFAULT NULL COMMENT '打印模板名称',
  `value` varchar(4095) DEFAULT NULL COMMENT '模板值',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of printtemplate
-- ----------------------------

-- ----------------------------
-- Table structure for problemcomplaint
-- ----------------------------
DROP TABLE IF EXISTS `problemcomplaint`;
CREATE TABLE `problemcomplaint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订户ID',
  `complaintno` varchar(255) DEFAULT NULL COMMENT '投诉问题单号',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域号',
  `userid` int(10) DEFAULT NULL COMMENT '用户ID',
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `type` varchar(255) DEFAULT NULL COMMENT '类型(0-故障；1-投诉)',
  `problemtype` varchar(255) DEFAULT NULL COMMENT '问题类型(1-硬件问题；2-软件问题；0-其他问题)',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-未受理；1-受理中；3-已处理；4-处理失败）(没有２为了与工单DISPATCH中的STATE同步)',
  `result` varchar(255) DEFAULT NULL COMMENT '处理结果',
  `resource` varchar(255) DEFAULT NULL COMMENT '问题投诉来源（0-BOSS；1-MPS）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题投诉信息表';

-- ----------------------------
-- Records of problemcomplaint
-- ----------------------------

-- ----------------------------
-- Table structure for problemcomplaintdetail
-- ----------------------------
DROP TABLE IF EXISTS `problemcomplaintdetail`;
CREATE TABLE `problemcomplaintdetail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `complaintid` int(10) DEFAULT NULL COMMENT 'complaintid',
  `complaintno` varchar(255) DEFAULT NULL COMMENT '投诉问题单号',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（1-图片；2-视频文件）',
  `filename` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `preservefilename` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `preserveurl` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题投诉明细表';

-- ----------------------------
-- Records of problemcomplaintdetail
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `productname` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `producttype` varchar(255) DEFAULT NULL COMMENT '产品类型（1-数字电视；2-广播；3-数据业务）',
  `pricepermonth` decimal(15,2) DEFAULT '0.00' COMMENT '产品包月单价',
  `priceperday` decimal(15,2) DEFAULT '0.00' COMMENT '产品每天价格',
  `extendflag` varchar(255) DEFAULT NULL COMMENT '是否推广（0-否；1-是）',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `subpricepermonth` decimal(15,2) DEFAULT '0.00' COMMENT '副机按月价格',
  `subpriceperday` decimal(15,2) DEFAULT '0.00' COMMENT '副机按天价格',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_netid_productid` (`netid`,`productid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品信息表';

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for productextend
-- ----------------------------
DROP TABLE IF EXISTS `productextend`;
CREATE TABLE `productextend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `webflag` varchar(255) DEFAULT NULL COMMENT '是否在WEB平台上显示（0-否；1-是）',
  `rank` varchar(255) DEFAULT NULL COMMENT '推荐等级（级别越高，在同类产品中的排序越靠前1,2,3,4,5）',
  `description` varchar(1000) DEFAULT NULL COMMENT '描述文字',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（1-海报图片；2-视频文件）',
  `filename` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `preservefilename` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `preserveurl` varchar(255) DEFAULT NULL COMMENT '存放地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品推广表';

-- ----------------------------
-- Records of productextend
-- ----------------------------

-- ----------------------------
-- Table structure for productserviceref
-- ----------------------------
DROP TABLE IF EXISTS `productserviceref`;
CREATE TABLE `productserviceref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `serviceid` varchar(255) DEFAULT NULL COMMENT '业务ID',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品业务关系表';

-- ----------------------------
-- Records of productserviceref
-- ----------------------------

-- ----------------------------
-- Table structure for provider
-- ----------------------------
DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `companyname` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `model` varchar(255) DEFAULT NULL COMMENT '规格型号',
  `type` varchar(255) DEFAULT NULL COMMENT '类型(0-机顶盒；1-智能卡)',
  `mainprice` decimal(15,2) DEFAULT '0.00' COMMENT '主终端价格',
  `subprice` decimal(15,2) DEFAULT '0.00' COMMENT '副终端价格',
  `address` varchar(255) DEFAULT NULL COMMENT '公司地址',
  `repairaddress` varchar(255) DEFAULT NULL COMMENT '维修地址',
  `factoryaddress` varchar(255) DEFAULT NULL COMMENT '厂房地址',
  `businesscontactername` varchar(255) DEFAULT NULL COMMENT '商务联系人姓名',
  `businesscontactertelephone` varchar(255) DEFAULT NULL COMMENT '商务联系人电话',
  `businesscontacteremail` varchar(255) DEFAULT NULL COMMENT '商务联系人邮件',
  `technicalcontactername` varchar(255) DEFAULT NULL COMMENT '技术联系人姓名',
  `technicalcontactertelephone` varchar(255) DEFAULT NULL COMMENT '技术联系人电话',
  `technicalcontacteremail` varchar(255) DEFAULT NULL COMMENT '技术联系人邮件',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_model` (`model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商信息表';

-- ----------------------------
-- Records of provider
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rolecode` varchar(255) DEFAULT NULL COMMENT '角色编号',
  `rolename` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（0-默认；1-用户添加）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '00000001', '系统默认角色', '0', null);

-- ----------------------------
-- Table structure for rolemenuref
-- ----------------------------
DROP TABLE IF EXISTS `rolemenuref`;
CREATE TABLE `rolemenuref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` int(10) DEFAULT NULL COMMENT '角色ID',
  `meunuid` int(10) DEFAULT NULL COMMENT '菜单ID',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='角色与菜单关系表';

-- ----------------------------
-- Records of rolemenuref
-- ----------------------------
INSERT INTO `rolemenuref` VALUES ('1', '1', '1', null);
INSERT INTO `rolemenuref` VALUES ('2', '1', '8', null);
INSERT INTO `rolemenuref` VALUES ('3', '1', '58', null);
INSERT INTO `rolemenuref` VALUES ('4', '1', '9', null);
INSERT INTO `rolemenuref` VALUES ('5', '1', '10', null);
INSERT INTO `rolemenuref` VALUES ('6', '1', '11', null);
INSERT INTO `rolemenuref` VALUES ('7', '1', '12', null);
INSERT INTO `rolemenuref` VALUES ('8', '1', '13', null);
INSERT INTO `rolemenuref` VALUES ('9', '1', '15', null);
INSERT INTO `rolemenuref` VALUES ('10', '1', '16', null);
INSERT INTO `rolemenuref` VALUES ('11', '1', '17', null);
INSERT INTO `rolemenuref` VALUES ('12', '1', '19', null);
INSERT INTO `rolemenuref` VALUES ('13', '1', '20', null);
INSERT INTO `rolemenuref` VALUES ('14', '1', '21', null);
INSERT INTO `rolemenuref` VALUES ('15', '1', '39', null);
INSERT INTO `rolemenuref` VALUES ('16', '1', '18', null);
INSERT INTO `rolemenuref` VALUES ('17', '1', '57', null);
INSERT INTO `rolemenuref` VALUES ('18', '1', '69', null);
INSERT INTO `rolemenuref` VALUES ('19', '1', '70', null);
INSERT INTO `rolemenuref` VALUES ('20', '1', '90', null);
INSERT INTO `rolemenuref` VALUES ('21', '1', '74', null);
INSERT INTO `rolemenuref` VALUES ('22', '1', '75', null);
INSERT INTO `rolemenuref` VALUES ('23', '1', '82', null);
INSERT INTO `rolemenuref` VALUES ('24', '1', '91', null);
INSERT INTO `rolemenuref` VALUES ('25', '1', '95', null);
INSERT INTO `rolemenuref` VALUES ('26', '1', '96', null);
INSERT INTO `rolemenuref` VALUES ('27', '1', '2', null);
INSERT INTO `rolemenuref` VALUES ('28', '1', '23', null);
INSERT INTO `rolemenuref` VALUES ('29', '1', '24', null);
INSERT INTO `rolemenuref` VALUES ('30', '1', '25', null);
INSERT INTO `rolemenuref` VALUES ('31', '1', '26', null);
INSERT INTO `rolemenuref` VALUES ('32', '1', '29', null);
INSERT INTO `rolemenuref` VALUES ('33', '1', '3', null);
INSERT INTO `rolemenuref` VALUES ('34', '1', '30', null);
INSERT INTO `rolemenuref` VALUES ('35', '1', '32', null);
INSERT INTO `rolemenuref` VALUES ('36', '1', '33', null);
INSERT INTO `rolemenuref` VALUES ('37', '1', '80', null);
INSERT INTO `rolemenuref` VALUES ('38', '1', '81', null);
INSERT INTO `rolemenuref` VALUES ('39', '1', '4', null);
INSERT INTO `rolemenuref` VALUES ('40', '1', '34', null);
INSERT INTO `rolemenuref` VALUES ('41', '1', '35', null);
INSERT INTO `rolemenuref` VALUES ('42', '1', '36', null);
INSERT INTO `rolemenuref` VALUES ('43', '1', '37', null);
INSERT INTO `rolemenuref` VALUES ('44', '1', '38', null);
INSERT INTO `rolemenuref` VALUES ('45', '1', '83', null);
INSERT INTO `rolemenuref` VALUES ('46', '1', '85', null);
INSERT INTO `rolemenuref` VALUES ('47', '1', '6', null);
INSERT INTO `rolemenuref` VALUES ('48', '1', '43', null);
INSERT INTO `rolemenuref` VALUES ('49', '1', '44', null);
INSERT INTO `rolemenuref` VALUES ('50', '1', '45', null);
INSERT INTO `rolemenuref` VALUES ('51', '1', '46', null);
INSERT INTO `rolemenuref` VALUES ('52', '1', '47', null);
INSERT INTO `rolemenuref` VALUES ('53', '1', '48', null);
INSERT INTO `rolemenuref` VALUES ('54', '1', '50', null);
INSERT INTO `rolemenuref` VALUES ('55', '1', '51', null);
INSERT INTO `rolemenuref` VALUES ('56', '1', '71', null);
INSERT INTO `rolemenuref` VALUES ('57', '1', '131', null);
INSERT INTO `rolemenuref` VALUES ('58', '1', '132', null);
INSERT INTO `rolemenuref` VALUES ('59', '1', '7', null);
INSERT INTO `rolemenuref` VALUES ('60', '1', '52', null);
INSERT INTO `rolemenuref` VALUES ('61', '1', '53', null);
INSERT INTO `rolemenuref` VALUES ('62', '1', '86', null);
INSERT INTO `rolemenuref` VALUES ('63', '1', '87', null);
INSERT INTO `rolemenuref` VALUES ('64', '1', '88', null);
INSERT INTO `rolemenuref` VALUES ('65', '1', '89', null);
INSERT INTO `rolemenuref` VALUES ('66', '1', '93', null);
INSERT INTO `rolemenuref` VALUES ('67', '1', '94', null);
INSERT INTO `rolemenuref` VALUES ('68', '1', '97', null);
INSERT INTO `rolemenuref` VALUES ('69', '1', '98', null);
INSERT INTO `rolemenuref` VALUES ('70', '1', '99', null);
INSERT INTO `rolemenuref` VALUES ('71', '1', '100', null);
INSERT INTO `rolemenuref` VALUES ('72', '1', '110', null);
INSERT INTO `rolemenuref` VALUES ('73', '1', '111', null);
INSERT INTO `rolemenuref` VALUES ('74', '1', '112', null);
INSERT INTO `rolemenuref` VALUES ('75', '1', '113', null);
INSERT INTO `rolemenuref` VALUES ('76', '1', '101', null);
INSERT INTO `rolemenuref` VALUES ('77', '1', '102', null);
INSERT INTO `rolemenuref` VALUES ('78', '1', '103', null);
INSERT INTO `rolemenuref` VALUES ('79', '1', '104', null);
INSERT INTO `rolemenuref` VALUES ('80', '1', '105', null);
INSERT INTO `rolemenuref` VALUES ('81', '1', '106', null);
INSERT INTO `rolemenuref` VALUES ('82', '1', '107', null);
INSERT INTO `rolemenuref` VALUES ('83', '1', '108', null);
INSERT INTO `rolemenuref` VALUES ('84', '1', '109', null);
INSERT INTO `rolemenuref` VALUES ('85', '1', '114', null);
INSERT INTO `rolemenuref` VALUES ('86', '1', '115', null);
INSERT INTO `rolemenuref` VALUES ('87', '1', '116', null);
INSERT INTO `rolemenuref` VALUES ('88', '1', '117', null);
INSERT INTO `rolemenuref` VALUES ('89', '1', '118', null);
INSERT INTO `rolemenuref` VALUES ('90', '1', '119', null);
INSERT INTO `rolemenuref` VALUES ('91', '1', '120', null);
INSERT INTO `rolemenuref` VALUES ('92', '1', '121', null);
INSERT INTO `rolemenuref` VALUES ('93', '1', '122', null);
INSERT INTO `rolemenuref` VALUES ('94', '1', '123', null);
INSERT INTO `rolemenuref` VALUES ('95', '1', '124', null);

-- ----------------------------
-- Table structure for server
-- ----------------------------
DROP TABLE IF EXISTS `server`;
CREATE TABLE `server` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络ID',
  `providerid` int(10) DEFAULT NULL COMMENT '供应商ID',
  `servertype` varchar(255) DEFAULT NULL COMMENT '服务器类型（cas;epg;novd;mps）',
  `servername` varchar(255) DEFAULT NULL COMMENT '前端名称',
  `versiontype` varchar(255) DEFAULT NULL COMMENT '版本类型(gos_gn,gos_pn)',
  `ip` varchar(255) DEFAULT NULL COMMENT 'Ip地址',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  `protocols` varchar(255) DEFAULT NULL COMMENT '通信协议',
  `version` varchar(255) DEFAULT NULL COMMENT '版本号',
  `encryptionflag` varchar(255) DEFAULT NULL COMMENT '是否加密(0-否；1-是)',
  `encryptiontype` varchar(255) DEFAULT NULL COMMENT '加密方式',
  `initialkey` varchar(255) DEFAULT NULL COMMENT '密钥',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务服务器系统';

-- ----------------------------
-- Records of server
-- ----------------------------

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `serviceid` varchar(255) DEFAULT NULL COMMENT '业务ID',
  `servicename` varchar(255) DEFAULT NULL COMMENT '业务名称',
  `servicetype` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `chargetype` varchar(255) DEFAULT NULL COMMENT '计费类型（是否允许单独购买。0-不允许单独购买；1-允许单独购买）',
  `pricepermonth` decimal(15,2) DEFAULT '0.00' COMMENT '业务包月价格',
  `priceperday` decimal(15,2) DEFAULT '0.00' COMMENT '产品每天价格',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位（年/月/周/日/小时/个）',
  `extendflag` varchar(255) DEFAULT NULL COMMENT '是否生效（0-否；1-是）',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-无效；1-有效）',
  `subpricepermonth` decimal(15,2) DEFAULT '0.00' COMMENT '副机按月价格',
  `subpriceperday` decimal(15,2) DEFAULT '0.00' COMMENT '副机按天价格',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_netid_serviceid` (`netid`,`serviceid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务信息管理';

-- ----------------------------
-- Records of service
-- ----------------------------

-- ----------------------------
-- Table structure for serviceextend
-- ----------------------------
DROP TABLE IF EXISTS `serviceextend`;
CREATE TABLE `serviceextend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `serviceid` varchar(255) DEFAULT NULL COMMENT '业务ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `webflag` varchar(255) DEFAULT NULL COMMENT '是否在WEB平台上显示（0-否；1-是）',
  `rank` varchar(255) DEFAULT NULL COMMENT '推荐等级（级别越高，在同类产品中的排序越靠前1,2,3,4,5）',
  `description` varchar(1000) DEFAULT NULL COMMENT '描述文字',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（1-海报图片；2-视频文件）',
  `filename` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `preservefilename` varchar(255) DEFAULT NULL COMMENT '服务器保存文件名',
  `preserveurl` varchar(255) DEFAULT NULL COMMENT '存放地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务推广表';

-- ----------------------------
-- Records of serviceextend
-- ----------------------------

-- ----------------------------
-- Table structure for stb
-- ----------------------------
DROP TABLE IF EXISTS `stb`;
CREATE TABLE `stb` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒序号',
  `providerid` int(10) DEFAULT NULL COMMENT '供应商ID',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `versiontype` varchar(255) DEFAULT NULL COMMENT '所属CAS版本类型',
  `serverid` int(10) DEFAULT NULL COMMENT '所属前端ID',
  `stbversion` varchar(255) DEFAULT NULL COMMENT '软件版本',
  `loaderversion` varchar(255) DEFAULT NULL COMMENT 'Loader程序版本号',
  `state` varchar(255) DEFAULT NULL COMMENT '机顶盒状态 （0-库存；1：使用；2：维修；3：损坏）',
  `inputtime` datetime DEFAULT NULL COMMENT '入库时间',
  `outtime` datetime DEFAULT NULL COMMENT '出库时间',
  `incardflag` varchar(255) DEFAULT '0' COMMENT '是否内置卡(0-外置卡；1-内置卡；2-无卡）',
  `batchnum` varchar(255) DEFAULT NULL COMMENT '入库批号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stbno` (`stbno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机顶盒信息表';

-- ----------------------------
-- Records of stb
-- ----------------------------

-- ----------------------------
-- Table structure for stbcardref
-- ----------------------------
DROP TABLE IF EXISTS `stbcardref`;
CREATE TABLE `stbcardref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `cardid` varchar(255) DEFAULT NULL COMMENT '卡号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机顶盒与智能卡配对表';

-- ----------------------------
-- Records of stbcardref
-- ----------------------------

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `storecode` varchar(255) DEFAULT NULL COMMENT '营业厅编号',
  `storename` varchar(255) DEFAULT NULL COMMENT '营业厅名称',
  `address` varchar(255) DEFAULT NULL COMMENT '营业厅地址',
  `state` varchar(255) DEFAULT NULL COMMENT '营业厅状态(0-无效；1-有效)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='营业厅信息表';

-- ----------------------------
-- Records of store
-- ----------------------------

-- ----------------------------
-- Table structure for systempara
-- ----------------------------
DROP TABLE IF EXISTS `systempara`;
CREATE TABLE `systempara` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '参数名称',
  `code` varchar(255) DEFAULT NULL COMMENT '参数编码',
  `value` varchar(255) DEFAULT NULL COMMENT '参数值',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0无效；1-有效）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注(1有效；0无效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='系统参数表';

-- ----------------------------
-- Records of systempara
-- ----------------------------
INSERT INTO `systempara` VALUES ('1', 'MPS服务器推广标识', 'mps_extend_flag', '1', '1', null);
INSERT INTO `systempara` VALUES ('2', '文件存放路径', 'upload_file_path', 'c:\\boss_file', '1', '');
INSERT INTO `systempara` VALUES ('3', 'CAS到期日期', 'auth_expired_time', '2060-10-04 11:04:38', '0', '');
INSERT INTO `systempara` VALUES ('4', 'CAS自动发送标识（0-否；1-自动发送）', 'cas_send_auto', '1', '0', null);
INSERT INTO `systempara` VALUES ('5', '客户端认证标识', 'client_auth_flag', '0', '0', null);
INSERT INTO `systempara` VALUES ('10', '子母卡配对时间间隔', 'master_slave_card_interval_time', '999', '1', '子母卡配对时间间隔（天）');
INSERT INTO `systempara` VALUES ('11', '用户级别', 'user_vip_class', '1', '1', '订户等级');
INSERT INTO `systempara` VALUES ('12', '成人级别', 'maturity_rating', '1', '1', '成人级');
INSERT INTO `systempara` VALUES ('13', '运营商分配区域ID', 'operators_areaid', '128', '1', '运营商区域ID');
INSERT INTO `systempara` VALUES ('14', '运营商分配网络ID', 'operators_netid', '1', '1', '运营商网络ID');
INSERT INTO `systempara` VALUES ('15', '运营商分配信束ID', 'operators_bouquetid', '1', '1', '运营商分配信束ID');
INSERT INTO `systempara` VALUES ('16', '运营商名称', 'operators_name', 'Gospell', '1', '运营商名称');
INSERT INTO `systempara` VALUES ('17', '运营商信息', 'operator_info', 'Gospell', '1', '运营商信息');
INSERT INTO `systempara` VALUES ('18', '货币代码', 'currency_code', '586', '1', '货币代码');
INSERT INTO `systempara` VALUES ('19', '货币转换因子之分母（转化成电子钱包）', 'currency_conversion_denominator', '100', '1', '转化成电子钱包');
INSERT INTO `systempara` VALUES ('20', '子卡是否继承母卡授权', 'sub_hold_main_flag', '1', '1', '0-不继承；1-继承');
INSERT INTO `systempara` VALUES ('21', '是否发送机卡配对指令', 'send_stbcardpair_flag', '1', '1', '0-不配对；1-配对');
INSERT INTO `systempara` VALUES ('22', '是否允许只有智能卡的订户', 'only_sell_card_flag', '1', '0', '0-不允许；1-允许');
INSERT INTO `systempara` VALUES ('23', '是否发票打印纳税人信息', 'print_taxpayer_flag', '1', '1', '0-不打印；1-打印');
INSERT INTO `systempara` VALUES ('24', '机卡绑定个数', 'stb_binding_card_num', '1', '0', '机顶盒对应的智能卡数目');
INSERT INTO `systempara` VALUES ('25', '自动添加安装工单', 'auto_add_installation_workorder', '0', '1', '0-否；1-是');
INSERT INTO `systempara` VALUES ('26', '每台主机允许副机的数量', 'number_subdevice_allowed_per_main', '2', '1', '每台主机允许的副机数量');
INSERT INTO `systempara` VALUES ('27', '发票打印收款方名称', 'print_receivables_name', 'Gospell', '1', '发票打印的收款方名称');
INSERT INTO `systempara` VALUES ('28', '发票打印收款方编号', 'print_receivables_code', '123414250032385917', '1', '税务登记证号码');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域编号',
  `usercode` varchar(255) DEFAULT NULL COMMENT '订户编号(如00000001依次递增)',
  `username` varchar(255) DEFAULT NULL COMMENT '订户姓名',
  `usertype` varchar(255) DEFAULT '0' COMMENT '订户类型(0-普通订户；1-集团订户）',
  `mobile` varchar(255) DEFAULT NULL COMMENT '移动电话',
  `telephone` varchar(255) DEFAULT NULL COMMENT '固定电话',
  `documenttype` varchar(255) DEFAULT NULL COMMENT '证件类型',
  `documentno` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮件地址',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `password` varchar(255) DEFAULT NULL COMMENT '登录MPP密码',
  `paypassword` varchar(255) DEFAULT NULL COMMENT '账户余额支付密码',
  `bankno` varchar(255) DEFAULT NULL COMMENT '绑定银行卡号码',
  `score` decimal(15,2) DEFAULT '0.00' COMMENT '订户积分(默认为0)',
  `account` decimal(15,2) DEFAULT '0.00' COMMENT '账户金额',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0：注销;1：正常；2:报停；3-待审核）',
  `userlevelid` int(10) DEFAULT NULL COMMENT '用户级别',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `netid` (`netid`) USING BTREE,
  KEY `areacode` (`areacode`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `documentno` (`documentno`) USING BTREE,
  KEY `mobile` (`mobile`) USING BTREE,
  KEY `state` (`state`) USING BTREE,
  KEY `address` (`address`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户信息表';

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for useraccountlog
-- ----------------------------
DROP TABLE IF EXISTS `useraccountlog`;
CREATE TABLE `useraccountlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（0-入账；1-出账）',
  `money` decimal(15,2) DEFAULT NULL COMMENT '金额',
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `addtime` datetime DEFAULT NULL COMMENT '操作日期',
  `source` varchar(255) DEFAULT NULL COMMENT '操作类型(0-BOSS;1-MPS;2-代付款)',
  `businesstypekey` varchar(255) DEFAULT NULL COMMENT '业务类型（rechargeaccount-账户充值；giftcardpayment-充值卡充值；scorerecharge-积分充值;accountrefund-账户退钱;accountpayment-账户支付）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户充值记录表';

-- ----------------------------
-- Records of useraccountlog
-- ----------------------------

-- ----------------------------
-- Table structure for userbusiness
-- ----------------------------
DROP TABLE IF EXISTS `userbusiness`;
CREATE TABLE `userbusiness` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `userid` int(255) DEFAULT NULL COMMENT '订户id',
  `storeid` int(10) DEFAULT NULL COMMENT '营业厅ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域号',
  `totalmoney` decimal(15,2) DEFAULT NULL COMMENT '费用总金额',
  `shouldmoney` decimal(15,2) DEFAULT NULL COMMENT '应付金额',
  `accountmoney` decimal(15,2) DEFAULT NULL COMMENT '余额抵扣金额',
  `paymoney` decimal(15,2) DEFAULT NULL COMMENT '现金支付金额',
  `discount` decimal(15,2) DEFAULT NULL COMMENT '折扣',
  `score` decimal(15,2) DEFAULT NULL COMMENT '积分（已经弃用）',
  `scoremoney` decimal(15,2) DEFAULT NULL COMMENT '积分抵扣金额（已经弃用）',
  `addtime` datetime DEFAULT NULL COMMENT '添加日期',
  `logout` varchar(255) DEFAULT NULL COMMENT '注销标志（默认为0-正常；1-注销）',
  `source` varchar(255) DEFAULT NULL COMMENT '购买来源（0-营业厅；1-MPS；2-代买）',
  `buyerid` int(10) DEFAULT NULL COMMENT '代买人(代付款的时候保存代付人ID)',
  `paytype` varchar(255) DEFAULT NULL COMMENT '支付类型（0-现金支付；1-余额支付；2-积分支付；3-其他支付）',
  `invoicecode` varchar(255) DEFAULT NULL COMMENT '发票编号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户业务操作主表';

-- ----------------------------
-- Records of userbusiness
-- ----------------------------

-- ----------------------------
-- Table structure for userbusinessdetail
-- ----------------------------
DROP TABLE IF EXISTS `userbusinessdetail`;
CREATE TABLE `userbusinessdetail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `businessid` int(10) DEFAULT NULL COMMENT '订单主表ID',
  `operatorid` int(10) DEFAULT NULL COMMENT '操作员ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域号',
  `userid` int(10) DEFAULT NULL COMMENT '订户id',
  `storeid` int(10) DEFAULT NULL COMMENT '营业厅ID',
  `businesstypekey` varchar(255) DEFAULT NULL COMMENT '业务类型Key',
  `businesstypename` varchar(255) DEFAULT NULL COMMENT '业务类型名称',
  `terminalid` varchar(255) DEFAULT NULL COMMENT '终端号',
  `terminaltype` varchar(255) DEFAULT NULL COMMENT '终端类型（0-机顶盒号；1-智能卡号）',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡ID',
  `stbno` varchar(255) DEFAULT NULL,
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `productname` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `type` varchar(255) DEFAULT NULL COMMENT '产品类型（1-产品；2-业务；3-事件）',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `starttime` datetime DEFAULT NULL COMMENT '授权开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '授权结束时间',
  `feename` varchar(255) DEFAULT NULL COMMENT '费用名称',
  `content` varchar(255) DEFAULT NULL COMMENT '费用内容',
  `price` decimal(15,2) DEFAULT NULL COMMENT '单价',
  `totalmoney` decimal(15,2) DEFAULT NULL COMMENT '总费用',
  `logout` varchar(255) DEFAULT NULL COMMENT '注销标志（默认为0-正常；1-注销）',
  `source` varchar(255) DEFAULT NULL COMMENT '业务来源（0-BOSS；1-MPS；2-代买）',
  `buyerid` int(10) DEFAULT NULL COMMENT '代买人(代付款的时候保存代付人ID)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户业务操作明细表';

-- ----------------------------
-- Records of userbusinessdetail
-- ----------------------------

-- ----------------------------
-- Table structure for usercard
-- ----------------------------
DROP TABLE IF EXISTS `usercard`;
CREATE TABLE `usercard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域编号',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `serverid` int(10) DEFAULT NULL COMMENT '智能卡所属CAS',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡号',
  `mothercardflag` varchar(255) DEFAULT NULL COMMENT '子母卡标志（0-母卡；1-子卡）',
  `mothercardid` varchar(255) DEFAULT NULL COMMENT '母卡卡号',
  `addtime` datetime DEFAULT NULL COMMENT '购买时间',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-报停；1：使用 ；2：维修 ；3：损坏；4：停止）',
  `incardflag` varchar(255) DEFAULT NULL COMMENT '卡类型（0-外置卡；1-内置卡）',
  `stbno` varchar(255) DEFAULT NULL COMMENT '配对机顶盒',
  `price` decimal(15,2) DEFAULT NULL COMMENT '价格',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cardid_unique` (`cardid`) USING BTREE,
  UNIQUE KEY `stbno_unique` (`stbno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户智能卡表';

-- ----------------------------
-- Records of usercard
-- ----------------------------

-- ----------------------------
-- Table structure for userfeedback
-- ----------------------------
DROP TABLE IF EXISTS `userfeedback`;
CREATE TABLE `userfeedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `netid` int(10) DEFAULT NULL COMMENT '所属网络',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `type` varchar(255) DEFAULT NULL COMMENT '反馈类型（1-意见反馈 ； 2-产品使用反馈）',
  `producttype` varchar(255) DEFAULT NULL COMMENT '产品类型（1-产品；2-业务；3-事件）',
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `productname` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `content` varchar(1000) DEFAULT NULL COMMENT '反馈内容',
  `mobile` varchar(255) DEFAULT NULL COMMENT '联系电话(type为1时有)',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户反馈意见';

-- ----------------------------
-- Records of userfeedback
-- ----------------------------

-- ----------------------------
-- Table structure for userlevel
-- ----------------------------
DROP TABLE IF EXISTS `userlevel`;
CREATE TABLE `userlevel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `levelname` varchar(255) DEFAULT NULL COMMENT '订户级别',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `levelname` (`levelname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlevel
-- ----------------------------

-- ----------------------------
-- Table structure for userlevelproduct
-- ----------------------------
DROP TABLE IF EXISTS `userlevelproduct`;
CREATE TABLE `userlevelproduct` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `userlevelid` int(10) DEFAULT NULL COMMENT '订户级别ID',
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `pricepermonth` decimal(15,2) DEFAULT NULL COMMENT '产品包月单价',
  `priceperday` decimal(15,2) DEFAULT NULL COMMENT '产品每天价格',
  `subpricepermonth` decimal(15,2) DEFAULT NULL COMMENT '子卡包月价格',
  `subpriceperday` decimal(15,2) DEFAULT NULL COMMENT '子卡按天购买价格',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlevelproduct
-- ----------------------------

-- ----------------------------
-- Table structure for userproduct
-- ----------------------------
DROP TABLE IF EXISTS `userproduct`;
CREATE TABLE `userproduct` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '网络ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域编号',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `serverid` int(10) DEFAULT NULL COMMENT 'CAS服务器ID',
  `terminalid` varchar(255) DEFAULT NULL COMMENT '终端号',
  `terminaltype` varchar(255) DEFAULT NULL COMMENT '终端类型（0-机顶盒号；1-智能卡号）',
  `cardid` varchar(255) DEFAULT NULL COMMENT '智能卡号',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `productid` varchar(255) DEFAULT NULL COMMENT '产品ID',
  `productname` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `type` varchar(255) DEFAULT NULL COMMENT '产品类型（1-产品；2-业务；3-事件）',
  `source` varchar(255) DEFAULT NULL COMMENT '购买来源（0-营业厅；1-MPS；2-代买）',
  `buyerid` int(10) DEFAULT NULL COMMENT '代买人(代付款的时候保存代付人ID)',
  `addtime` datetime DEFAULT NULL COMMENT '购买时间',
  `starttime` datetime DEFAULT NULL COMMENT '授权开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '授权结束时间',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-报停；1-正常；4-注销）',
  `restday` decimal(15,2) DEFAULT NULL COMMENT '报停剩下天数',
  `price` decimal(15,2) DEFAULT NULL COMMENT '价格',
  `unit` varchar(255) DEFAULT NULL COMMENT '价格单位（month-月;day-日）',
  `buyamount` int(10) DEFAULT NULL COMMENT '购买数量',
  `totalmoney` decimal(15,2) DEFAULT NULL COMMENT '产品总费用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户产品表';

-- ----------------------------
-- Records of userproduct
-- ----------------------------

-- ----------------------------
-- Table structure for userstb
-- ----------------------------
DROP TABLE IF EXISTS `userstb`;
CREATE TABLE `userstb` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `netid` int(10) DEFAULT NULL COMMENT '所属网络ID',
  `areacode` varchar(255) DEFAULT NULL COMMENT '区域编号',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `serverid` int(10) DEFAULT NULL COMMENT '机顶盒所属CAS',
  `stbno` varchar(255) DEFAULT NULL COMMENT '机顶盒号',
  `incardflag` varchar(255) DEFAULT NULL COMMENT '是否内置卡(0-外置卡；1-内置卡；2-无卡）',
  `addtime` datetime DEFAULT NULL COMMENT '购买时间',
  `mothercardflag` varchar(255) DEFAULT NULL COMMENT '主副机标志（0-主机；1-子机）',
  `mothercardid` varchar(255) DEFAULT NULL COMMENT '母机号',
  `state` varchar(255) DEFAULT NULL COMMENT '状态（0-报停；1：使用 ；2：维修 ；3：损坏；4：停止）',
  `price` decimal(15,2) DEFAULT NULL COMMENT '价格',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stbno` (`stbno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订户机顶盒表';

-- ----------------------------
-- Records of userstb
-- ----------------------------

-- ----------------------------
-- Table structure for usertaxpayer
-- ----------------------------
DROP TABLE IF EXISTS `usertaxpayer`;
CREATE TABLE `usertaxpayer` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `userid` int(10) DEFAULT NULL COMMENT '订户ID',
  `taxpayercode` varchar(255) DEFAULT NULL COMMENT '纳税人识别号',
  `taxpayername` varchar(1000) DEFAULT NULL COMMENT '纳税人识别号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usrid_unique` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usertaxpayer
-- ----------------------------
