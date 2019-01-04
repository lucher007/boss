package com.gospell.boss.service;

import java.util.List;

import com.gospell.boss.cas.CaCommandParam;
import com.gospell.boss.cas.EmailOrOsdMsg;
import com.gospell.boss.cas.Forcedrestart;
import com.gospell.boss.cas.PvrAuthEmm;
import com.gospell.boss.cas.Researchprogram;
import com.gospell.boss.cas.Stbdefaultmsg;
import com.gospell.boss.po.Card;
import com.gospell.boss.po.Caspnblackcard;
import com.gospell.boss.po.Caspnblackstb;
import com.gospell.boss.po.Caspnforcedcc;
import com.gospell.boss.po.Caspnforcedosd;
import com.gospell.boss.po.Caspnnewemail;
import com.gospell.boss.po.Caspnnewfinger;
import com.gospell.boss.po.Caspnproductplay;
import com.gospell.boss.po.User;
import com.gospell.boss.po.Usercard;
import com.gospell.boss.po.Userproduct;
import com.gospell.boss.po.Userstb;

/**
 * CA业务层接口
 */
public interface IAuthorizeService {
	
	/**
	 * 机顶盒购买授权业务
	 * 
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_buyStb(Userstb userstb);
	
	/**
	 * 智能卡购买授权业务
	 * 
	 * @param Usercard
	 * @return
	 */
	public void saveAuthorize_buyCard(Usercard usercard);
	
	/**
	 * 产品购买授权业务
	 * 
	 * @param Userproduct
	 * @return
	 */
	public void saveAuthorize_buyProduct(Userproduct userproduct);
	
	/**
	 * 产品购买授权业务_批量
	 * 
	 * @param Userproduct
	 * @return
	 */
	public void saveAuthorize_buyProduct_batch(List<Userproduct> userproductlist);
	
	/**
	 * 停开机顶盒
	 * 
	 * @param Userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnStb(Userstb userstb,String command);
	
	/**
	 * 批量停开机顶盒
	 * 
	 * @param Userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnStb_batch(List<Userstb> userstblist,String command);
	
	/**
	 * 停开智能卡
	 * @param Userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnCard(Usercard usercard,String command);
	
	/**
	 * 批量停开智能卡
	 * @param Userstb
	 * @param commandType:指令类型（0-停；1-开）
	 * @return
	 */
	public void saveAuthorize_stopAndOnCard_batch(List<Usercard> usercardlist,String command);
	
	/**
	 * 销户-机顶盒处理
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_cancelUser_userstb(Userstb userstb);
	
	/**
	 * 销户-智能卡处理
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_cancelUser_usercard(Usercard usercard);
	
	/**
	 * 更换机顶盒
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_replaceStb(Userstb userstb,Userstb olduserstb);
	
	/**
	 * 更换智能卡
	 * @param Usercard
	 * @return
	 */
	public void saveAuthorize_replaceCard(Usercard usercard,Usercard oldusercard);
	
	/**
	 * 机顶盒电子钱包充值
	 * @param Usercard
	 * @return
	 */
	public void saveAuthorize_rechargeWallet_userstb(Userstb userstb);
	
	/**
	 * 智能卡电子钱包充值
	 * @param Usercard
	 * @return
	 */
	public void saveAuthorize_rechargeWallet_usercard(Usercard usercard);
	
	/**
	 * 新邮件
	 * @param Caspnnewemail
	 * @return
	 */
	public void saveAuthorize_newemail(Caspnnewemail caspnnewemail);
	
	/**
	 * 强制OSD
	 * @param Caspnforcedosd
	 * @return
	 */
	public void saveAuthorize_forcedosd(Caspnforcedosd caspnforcedosd);
	
	/**
	 * 新指纹显示
	 * @param Caspnnewfinger
	 * @return
	 */
	public void saveAuthorize_newfinger(Caspnnewfinger caspnnewfinger);
	
	/**
	 * 强制换台
	 * @param Caspnforcedcc
	 * @return
	 */
	public void saveAuthorize_forcedcc(Caspnforcedcc caspnforcedcc);
	
	/**
	 * 机顶盒默认开机节目
	 * @param Stbdefaultmsg
	 * @return
	 */
	public void saveAuthorize_stbdefaultmsg(Stbdefaultmsg stbdefaultmsg);
	
	/**
	 * 机顶盒强制重启
	 * @param Forcedrestart
	 * @return
	 */
	public void saveAuthorize_forcedrestart(Forcedrestart forcedrestart);
	
	
	/**
	 * 重新搜索节目
	 * @param Forcedrestart
	 * @return
	 */
	public void saveAuthorize_researchprogram(Researchprogram researchprogram);
	
	/**
	 * PVA再授权
	 * @param PvrAuthEmm
	 * @return
	 */
	public void saveAuthorize_pvrauthemm(PvrAuthEmm pvrAuthEmm);
	
	/**
	 * 机顶盒黑名单
	 * @param Caspnblackstb
	 * @return
	 */
	public void saveAuthorize_blackstb(Caspnblackstb caspnblackstb);
	
	/**
	 * 智能卡黑名单
	 * @param Caspnblackcard
	 * @return
	 */
	public void saveAuthorize_blackcard(Caspnblackcard caspnblackcard);
	
	/**
	 * 产品信息同步
	 * @param 
	 * @return
	 */
	public void saveAuthorize_pushproductinfo();
	
	/**
	 * 重置PIN码
	 * @param 
	 * @return
	 */
	public void saveAuthorize_resetpincode(CaCommandParam form);
	
	/**
	 * 清除PIN码
	 * @param 
	 * @return
	 */
	public void saveAuthorize_cleanpincode(CaCommandParam form);
	
	/**
	 * 删除错误发卡指令
	 * @param 
	 * @return
	 */
	public void saveAuthorize_deleteerrcard(CaCommandParam form);
	
	/**
	 * 批量预授权
	 * @param 
	 * @return
	 */
	public void saveAuthorize_batchpreauthorize(CaCommandParam form);
	
	/**
	 * 机卡绑定关系(针对机顶盒)
	 * @param Userstb
	 * @return
	 */
	public void saveAuthorize_stbBingCard(Userstb userstb);
	
	/**
	 * 迁移业务发送激活授权
	 * @param User
	 * @return
	 */
	public void saveAuthorize_transferAddress(User user);
	
	/**
	 * 过户业务发送激活授权
	 * @param User
	 * @return
	 */
	public void saveAuthorize_transferUser(User user);
	
	/**
	 * 智能卡批量发卡操作
	 */
	public void  saveAuthorize_batchsendCard(Card card,String userareacode);
	
	/**
	 * OSD
	 * @param Caspnforcedosd
	 * @return
	 */
	public void saveAuthorize_osd(EmailOrOsdMsg emailOrOsdMsg);
	
	/**
	 * Email指令
	 * @param EmailOrOsdMsg
	 * @return
	 */
	public void saveAuthorize_email(EmailOrOsdMsg emailOrOsdMsg);
	
	/**
	 * 指纹指令
	 * @param EmailOrOsdMsg
	 * @return
	 */
	public void saveAuthorize_finger(EmailOrOsdMsg emailOrOsdMsg);
	
	/**
	 * 产品限播指令
	 * @param Caspnproductplay
	 * @return
	 */
	public void saveAuthorize_productplaylimit(Caspnproductplay caspnproductplay);
	
	/**
	 * 产品准播指令
	 * @param Caspnproductplay
	 * @return
	 */
	public void saveAuthorize_productplayallow(Caspnproductplay caspnproductplay);

	/**
	 * pvr功能控制
	 * @param CaCommandParam
	 * @return
	 */
	public void saveAuthorize_pvrfunctionControl(CaCommandParam form);

	/**
	 * 父母锁密码复位
	 * @param CaCommandParam
	 * @return
	 */
	public void saveAuthorize_parentlock(CaCommandParam form);
	
}
