package com.hiersun.ecommerce.gb.weixin.model.sms;

/**
 * 短信发送结果
 * 
 * @author zhengruifeng
 *
 */
public class SmsSendResult {
	private Boolean result;
	private String message;
	
	public Boolean getResult() {
		return result;
	}
	public void setResult(Boolean result) {
		this.result = result;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	public SmsSendResult(Boolean result, String message) {
		super();
		this.result = result;
		this.message = message;
	}	
	
	public SmsSendResult(){
		
	}
}
