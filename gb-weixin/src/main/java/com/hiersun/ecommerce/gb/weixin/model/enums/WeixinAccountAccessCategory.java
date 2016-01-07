package com.hiersun.ecommerce.gb.weixin.model.enums;

/**
 * 微信账户查询类别
 * 
 * @author zhengruifeng
 *
 */
public enum WeixinAccountAccessCategory {
	Mobile(1, "手机号"), ValidationCode(2, "手机验证码"), Unknown(100, "未知");
	
	private int _value;
	private String _name;
	
	private WeixinAccountAccessCategory(int value, String name){
		this._value = value;
		this._name = name;
	}
	
	public int getValue(){
		return this._value;
	}
	
	public String getName(){
		return this._name;
	}
}
