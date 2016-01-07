package com.hiersun.ecommerce.gb.weixin.message.resp;

import com.hiersun.ecommerce.gb.weixin.utils.MessageType;

/**
 * 消息xml格式 <xml> <ToUserName><![CDATA[toUser]]></ToUserName>
 * <FromUserName><![CDATA[fromUser]]></FromUserName>
 * <CreateTime>12345678</CreateTime> <MsgType><![CDATA[text]]></MsgType> </xml>
 * 消息基类（公众号->用户）
 */

public class BaseMessage {

	// 接收方账号
	private String ToUserName;
	// 开发者账号
	private String FromUserName;
	// 消息创建时间（整型）
	// @XStreamOmitField
	private long CreateTime;
	// 消息类型（text/music/news）
	private String MsgType;

	// auto gen setter getter
	public String getToUserName() {
		return ToUserName;
	}

	public void setToUserName(String toUserName) {
		ToUserName = toUserName;
	}

	public String getFromUserName() {
		return FromUserName;
	}

	public void setFromUserName(String fromUserName) {
		FromUserName = fromUserName;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}

	public String getMsgType() {
		return MsgType;
	}

	// modify manual zedon
	public void setMsgType(MessageType msgType) {
		MsgType = msgType.toString();
	}

}
