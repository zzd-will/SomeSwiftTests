package com.hiersun.ecommerce.gb.weixin.message.req;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.hiersun.ecommerce.gb.weixin.utils.XMLTools;

/**
 * 消息xml格式 <xml> <ToUserName><![CDATA[toUser]]></ToUserName>
 * <FromUserName><![CDATA[fromUser]]></FromUserName>
 * <CreateTime>12345678</CreateTime> <MsgType><![CDATA[text]]></MsgType> </xml>
 * //消息基类（用户 -> 公众号）
 */
public class RequestMessage {
	private static final Logger logger = Logger.getLogger(RequestMessage.class);
	
	public final static int TYPE_NONE = 0;
	public final static int MSG_TYPE_TEXT = 101;
	public final static int MSG_TYPE_IMAGE = 102;
	public final static int MSG_TYPE_VOICE = 103;
	public final static int MSG_TYPE_VIDEO = 104;
	public final static int MSG_TYPE_SHORTVIDEO = 105;
	public final static int MSG_TYPE_LOCATION = 106;
	public final static int MSG_TYPE_LINK = 107;
	public final static int MSG_TYPE_EVENT_SUBSCRIBE = 201;
	public final static int MSG_TYPE_EVENT_UNSUBSCRIBE = 202;
	public final static int MSG_TYPE_EVENT_CLICK = 300;
	private int mMsgType;// 消息类型

	private Map<String, String> mRequestMap;

	public RequestMessage(HttpServletRequest request) {
		try {
			mRequestMap = XMLTools.parseXmltoMap(request);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		if (mRequestMap != null) {
			mMsgType = formatType(mRequestMap);
		}

	}

	private int formatType( Map<String, String> requestMap) {
		String type=requestMap.get("MsgType");
		if (type == null) {
			return TYPE_NONE;
		}
//		type = type.toLowerCase();
		if (type.equals("text")) {
			return MSG_TYPE_TEXT;
		}
		if (type.equals("image")) {
			return MSG_TYPE_IMAGE;
		}
		if (type.equals("voice")) {
			return MSG_TYPE_VOICE;
		}
		if (type.equals("video")) {
			return MSG_TYPE_VIDEO;
		}
		if (type.equals("shortvideo")) {
			return MSG_TYPE_SHORTVIDEO;
		}
		if (type.equals("location")) {
			return MSG_TYPE_LOCATION;
		}
		if (type.equals("link")) {
			return MSG_TYPE_LINK;
		}
		if(type.equals("event")){
			String eventType = requestMap.get("Event");
			if(eventType.equals("subscribe")){
				return MSG_TYPE_EVENT_SUBSCRIBE;				
			}
			if(eventType.equals("unsubscribe")){
				return MSG_TYPE_EVENT_UNSUBSCRIBE;				
			}
			if(eventType.equals("CLICK")){
				return MSG_TYPE_EVENT_CLICK;				
			}
		}
		return TYPE_NONE;
	}
	
	public int getMsgType() {
		return mMsgType;
	}

	public Map<String, String> getRequestMap() {
		return mRequestMap;

	}

}
