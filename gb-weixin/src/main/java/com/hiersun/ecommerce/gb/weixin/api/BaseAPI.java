package com.hiersun.ecommerce.gb.weixin.api;

import java.util.Map;

import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;

public abstract class BaseAPI {
	protected int mMsgType;
	protected String mToUserName; // 公众帐号
	protected String mFromUserName;// 发送方帐号（open_id）
	protected long mCreateTime;
	protected IWeixinService weixinService;

	public BaseAPI(int type, Map<String, String> requestMap, IWeixinService wxService) {
		mMsgType = type;
		mToUserName = requestMap.get("ToUserName");
		mFromUserName = requestMap.get("FromUserName");
		mCreateTime = System.currentTimeMillis();
		weixinService = wxService;
	}

	public BaseAPI(){
		
	}
	
	public abstract String doAPI(WeixinRequest wxRequest);

}
