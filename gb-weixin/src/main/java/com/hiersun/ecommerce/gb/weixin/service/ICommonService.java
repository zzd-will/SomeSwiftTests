package com.hiersun.ecommerce.gb.weixin.service;

import com.hiersun.ecommerce.gb.weixin.model.sms.SmsMessage;
import com.hiersun.ecommerce.gb.weixin.model.sms.SmsSendResult;

/**
 * 基础服务
 * 
 * @author zhengruifeng
 *
 */
public interface ICommonService {
	/**
	 * 发送短信	 * 
	 * @param message
	 * @return
	 */
	public SmsSendResult sendSmsMessage(SmsMessage message);
}
