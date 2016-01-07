package com.hiersun.ecommerce.gb.weixin.api;


import java.util.Map;

import com.hiersun.ecommerce.gb.weixin.message.req.RequestMessage;
import com.hiersun.ecommerce.gb.weixin.message.resp.TextMessage;
import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;
import com.hiersun.ecommerce.gb.weixin.utils.MessageType;
import com.hiersun.ecommerce.gb.weixin.utils.XMLTools;

public class SubScribeAPI extends BaseAPI {

	public SubScribeAPI(int type, Map<String, String> requestMap, IWeixinService wxService) {
		super(type, requestMap, wxService);
	}

	@Override
	public String doAPI(WeixinRequest wxRequest) {
		String resp = "金苹果";
		switch (mMsgType) {
		case RequestMessage.MSG_TYPE_EVENT_SUBSCRIBE:
			resp = doSubscribe();
			break;
		case RequestMessage.MSG_TYPE_EVENT_UNSUBSCRIBE:
			resp = doUnSubscribe();
			break;
		}

		return resp;
	}

	private String doSubscribe() {	
		TextMessage textMessage = new TextMessage();
		textMessage.setToUserName(mFromUserName);
		textMessage.setFromUserName(mToUserName);
		textMessage.setCreateTime(mCreateTime);
		textMessage.setMsgType(MessageType.TEXT);
		
		textMessage.setContent(API_TIPS.SUBSCRIBE_TIPS);
		return XMLTools.toXML(textMessage);
	}

	private String doUnSubscribe() {
		return "";
	}

}
