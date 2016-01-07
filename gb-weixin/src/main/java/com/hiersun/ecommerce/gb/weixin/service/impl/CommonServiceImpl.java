package com.hiersun.ecommerce.gb.weixin.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.PropertyResourceBundle;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.hiersun.ecommerce.gb.weixin.model.sms.SmsMessage;
import com.hiersun.ecommerce.gb.weixin.model.sms.SmsSendResult;
import com.hiersun.ecommerce.gb.weixin.service.ICommonService;

/**
 * 公共服务
 * 
 * @author zhengruifeng
 *
 */
@Service("commonService")  
public class CommonServiceImpl implements ICommonService {
	private static final Logger logger = Logger.getLogger(CommonServiceImpl.class);
	private static final String smsServiceUrl = PropertyResourceBundle.getBundle("sms").getString("smsservice");
	
	/**
	 * 发送短信
	 */
	@Override
	public SmsSendResult sendSmsMessage(SmsMessage message){
		if(message == null || 
				message.getMobiles() == null || message.getMobiles().length < 1 ||
				message.getAppName() == null ||
				message.getScenario() == null
				){
			return new SmsSendResult(false, "参数传递不全");
		}		

		Map<String, String> params = new HashMap<String, String>();
		params.put("mobiles", String.join(",", message.getMobiles()));
		params.put("content", message.getContent());
		params.put("appName", message.getAppName());
		params.put("scenario", message.getScenario());
		
		SmsSendResult result = null;
		try{
			 result = new RestTemplate().postForObject(smsServiceUrl, null, SmsSendResult.class, params);
		}catch(Exception ex){			
			logger.error("发送短信失败，详细信息：" + ex.getMessage());
			result = new SmsSendResult(false, "发送短信失败，详细请查阅日志.");
		}
		
		return result;
	}
}
