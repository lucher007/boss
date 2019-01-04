package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Message extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private String messagertype;	       //留言人类型(0-客服 1-订户)
	private String messagerid;		   //留言人ID
	private String dispatchid;            //工单ID
	private String content;              //留言内容
	private String addtime;              //留言时间
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Message message;
	private List<Message> messagelist;
	
	private Network network;
	private Map<Integer, String> networkmap;
	
	private String querymessagertype;
	private String querymessagerid;
	private String querydispatchid;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getNetid() {
		return netid;
	}
	public void setNetid(Integer netid) {
		this.netid = netid;
	}
	public String getMessagertype() {
		return messagertype;
	}
	public void setMessagertype(String messagertype) {
		this.messagertype = messagertype;
	}
	public String getMessagerid() {
		return messagerid;
	}
	public void setMessagerid(String messagerid) {
		this.messagerid = messagerid;
	}
	public String getDispatchid() {
		return dispatchid;
	}
	public void setDispatchid(String dispatchid) {
		this.dispatchid = dispatchid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public List<Message> getMessagelist() {
		return messagelist;
	}
	public void setMessagelist(List<Message> messagelist) {
		this.messagelist = messagelist;
	}
	public Network getNetwork() {
		return network;
	}
	public void setNetwork(Network network) {
		this.network = network;
	}
	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}
	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}
	public String getQuerymessagertype() {
		return querymessagertype;
	}
	public void setQuerymessagertype(String querymessagertype) {
		this.querymessagertype = querymessagertype;
	}
	public String getQuerymessagerid() {
		return querymessagerid;
	}
	public void setQuerymessagerid(String querymessagerid) {
		this.querymessagerid = querymessagerid;
	}
	public String getQuerydispatchid() {
		return querydispatchid;
	}
	public void setQuerydispatchid(String querydispatchid) {
		this.querydispatchid = querydispatchid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
}
