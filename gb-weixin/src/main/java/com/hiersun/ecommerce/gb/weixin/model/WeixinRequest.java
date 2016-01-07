package com.hiersun.ecommerce.gb.weixin.model;

import java.util.Date;
import java.util.Map;

import com.hiersun.ecommerce.gb.weixin.message.req.RequestMessage;

/**
 * 微信请求
 */
public class WeixinRequest {
	/**
	 * 请求Id
	 */
	private long requestId;
	/**
	 * 消息Id
	 */
	private long msgId;
	/**
	 * AppId
	 */
	private String appId;
	/**
	 * 用户OpenId
	 */
	private String userOpenId;
	/**
	 * 消息类型
	 */
	private String msgType;

	/**
	 * msgType 是 event 时 ，有此属性
	 */
	private String msgEventType;

	/**
	 * 消息创建（发送）时间
	 */
	private Date createTime;
	/**
	 * 消息体 注：记录消息的xml内容 （接收到的原始xml串）
	 */
	private String msgObjContent;
	/**
	 * 消息校验是否合法
	 */
	private Boolean isValid;
	/**
	 * 校验结果说明
	 */
	private String validationRemark;

	public Boolean getIsValid() {
		return isValid;
	}

	public void setIsValid(Boolean isValid) {
		this.isValid = isValid;
	}

	public String getValidationRemark() {
		return validationRemark;
	}

	public void setValidationRemark(String validationRemark) {
		this.validationRemark = validationRemark;
	}

	public long getMsgId() {
		return msgId;
	}

	public void setMsgId(long msgId) {
		this.msgId = msgId;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getUserOpenId() {
		return userOpenId;
	}

	public void setUserOpenId(String userOpenId) {
		this.userOpenId = userOpenId;
	}

	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getMsgObjContent() {
		return msgObjContent;
	}

	public void setMsgObjContent(String msgObjContent) {
		this.msgObjContent = msgObjContent;
	}

	public long getRequestId() {
		return requestId;
	}

	public void setRequestId(long requestId) {
		this.requestId = requestId;
	}

	public String getMsgEventType() {
		return msgEventType;
	}

	public void setMsgEventType(String msgEventType) {
		this.msgEventType = msgEventType;
	}

	
	public WeixinRequest(long requestId, long msgId, String appId, String userOpenId, String msgType,
			String msgEventType, Date createTime, String msgObjContent, Boolean isValid, String validationRemark) {
		super();
		this.requestId = requestId;
		this.msgId = msgId;
		this.appId = appId;
		this.userOpenId = userOpenId;
		this.msgType = msgType;
		this.msgEventType = msgEventType;
		this.createTime = createTime;
		this.msgObjContent = msgObjContent;
		this.isValid = isValid;
		this.validationRemark = validationRemark;
	}

	public WeixinRequest(RequestMessage reqMsg) {
		super();
		Map<String, String> resMap = reqMsg.getRequestMap();
		this.appId = resMap.get("ToUserName");
		this.userOpenId = resMap.get("FromUserName");
		this.msgType = resMap.get("MsgType");
		this.createTime = new Date(Long.parseLong(resMap.get("CreateTime")) * 1000L);
		this.msgObjContent = resMap.toString();
		if (reqMsg.getMsgType() < 200) {
			this.msgId = Long.parseLong(resMap.get("MsgId"));
		} else {
			this.msgEventType = resMap.get("Event");
		}
	}

}
