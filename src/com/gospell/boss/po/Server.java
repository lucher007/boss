package com.gospell.boss.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
/**
 * 用户实体类
 */
public class Server extends BaseField implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;                //数据库ID
	private Integer netid;             //所属网络ID
	private Integer providerid;        //供应商ID
	private String servertype;	       //服务器类型（cas;epg;novd;mps）
	private String servername;		   //前端名称
	private String versiontype;        //版本类型(gos_gn,gos_pn)
	private String ip;                 //Ip地址
	private String port;               //端口号
	private String protocols;          //通信协议
	private String version;            //版本号
	private String encryptionflag;     //是否加密(0-否；1-是)
	private String encryptiontype;     //加密方式
	private String initialkey;         //初始密钥
	private String remark;             //备注
	
	/******************数据库辅助字段*************************/
	private Server server;
	private List<Server> serverlist;
	private Map<Integer, String> networkmap;
	private Map<Integer, String> providermap;
	private Network network;
	private Provider provider;
	
	private String queryservertype;
	
	private String querynetid;
	private String queryversiontype;
	
	private String socketConnectState;
	
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

	public Integer getProviderid() {
		return providerid;
	}

	public void setProviderid(Integer providerid) {
		this.providerid = providerid;
	}

	public String getServertype() {
		return servertype;
	}

	public void setServertype(String servertype) {
		this.servertype = servertype;
	}

	public String getServername() {
		return servername;
	}

	public void setServername(String servername) {
		this.servername = servername;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getProtocols() {
		return protocols;
	}

	public void setProtocols(String protocols) {
		this.protocols = protocols;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getEncryptionflag() {
		return encryptionflag;
	}

	public void setEncryptionflag(String encryptionflag) {
		this.encryptionflag = encryptionflag;
	}

	public String getEncryptiontype() {
		return encryptiontype;
	}

	public void setEncryptiontype(String encryptiontype) {
		this.encryptiontype = encryptiontype;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Server getServer() {
		return server;
	}

	public void setServer(Server server) {
		this.server = server;
	}

	public List<Server> getServerlist() {
		return serverlist;
	}

	public void setServerlist(List<Server> serverlist) {
		this.serverlist = serverlist;
	}

	public String getQueryservertype() {
		return queryservertype;
	}

	public void setQueryservertype(String queryservertype) {
		this.queryservertype = queryservertype;
	}

	public Map<Integer, String> getNetworkmap() {
		return networkmap;
	}

	public void setNetworkmap(Map<Integer, String> networkmap) {
		this.networkmap = networkmap;
	}

	public String getQuerynetid() {
		return querynetid;
	}

	public void setQuerynetid(String querynetid) {
		this.querynetid = querynetid;
	}

	public Network getNetwork() {
		return network;
	}

	public void setNetwork(Network network) {
		this.network = network;
	}

	public Provider getProvider() {
		return provider;
	}

	public void setProvider(Provider provider) {
		this.provider = provider;
	}

	public Map<Integer, String> getProvidermap() {
		return providermap;
	}

	public void setProvidermap(Map<Integer, String> providermap) {
		this.providermap = providermap;
	}

	public String getInitialkey() {
		return initialkey;
	}

	public void setInitialkey(String initialkey) {
		this.initialkey = initialkey;
	}

	public String getVersiontype() {
		return versiontype;
	}

	public void setVersiontype(String versiontype) {
		this.versiontype = versiontype;
	}

	public String getQueryversiontype() {
		return queryversiontype;
	}

	public void setQueryversiontype(String queryversiontype) {
		this.queryversiontype = queryversiontype;
	}

	public String getSocketConnectState() {
		return socketConnectState;
	}

	public void setSocketConnectState(String socketConnectState) {
		this.socketConnectState = socketConnectState;
	}

	
}
