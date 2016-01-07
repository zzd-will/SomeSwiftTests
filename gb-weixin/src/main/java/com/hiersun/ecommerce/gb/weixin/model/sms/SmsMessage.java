package com.hiersun.ecommerce.gb.weixin.model.sms;

/**
 * 短信发送信息
 * 
 * @author zhengruifeng
 *
 */
public class SmsMessage {
	private String[] mobiles;
	private String content;
	private String appName;
	private String scenario;
	
	public String[] getMobiles() {
		return mobiles;
	}
	public void setMobiles(String[] mobiles) {
		this.mobiles = mobiles;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public String getScenario() {
		return scenario;
	}
	public void setScenario(String scenario) {
		this.scenario = scenario;
	}
	
	public SmsMessage(String[] mobiles, String content, String appName, String scenario) {
		super();
		this.mobiles = mobiles;
		this.content = content;
		this.appName = appName;
		this.scenario = scenario;
	}
}
