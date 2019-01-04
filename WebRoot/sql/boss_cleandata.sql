truncate activityinfo;
truncate activityinfopic;
truncate area;
truncate authorize;
truncate authorizehistory;
truncate card;
truncate caspnblackcard;
truncate caspnblackstb;
truncate caspnforcedcc;
truncate caspnforcedosd;
truncate caspnnewemail;
truncate caspnnewfinger;
truncate caspnproductplay;
truncate computer;
truncate dispatch;
truncate dispatchdetail;
truncate event;
truncate eventextend;
truncate giftcard;
truncate helpinfo;
truncate httprequestlog;
truncate message;
truncate network;
truncate operator;
truncate operatorinvoice;
truncate operatorlogs;
truncate operatorroleref;
truncate package;
truncate printtemplate;
truncate problemcomplaint;
truncate problemcomplaintdetail;
truncate product;
truncate productextend;
truncate productserviceref;
truncate provider;
truncate role;
truncate rolemenuref;
truncate server;
truncate service;
truncate serviceextend;
truncate stb;
truncate stbcardref;
truncate store;
truncate user;
truncate useraccountlog;
truncate userbusiness;
truncate userbusinessdetail;
truncate usercard;
truncate userfeedback;
truncate userlevel;
truncate userlevelproduct;
truncate userproduct;
truncate userstb;
truncate usertaxpayer;


-- ----------------------------
-- Records of operator
-- ----------------------------
INSERT INTO `operator` VALUES ('1', 'admin', '0', '0', null, null, null, null, 'Super admin', '0', null, null, null, null, null, null, null, '1', null);


-- ----------------------------
-- Records of operatorroleref
-- ----------------------------
INSERT INTO `operatorroleref` VALUES ('1', '1', '1', null);


-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '00000001', '系统默认角色', '0', null);

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



