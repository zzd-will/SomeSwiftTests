package com.hiersun.ecommerce.gb.weixin.service;

/**
 * 手机号验证结果
 * @author zhengruifeng
 *
 */
public enum MemberValidateResult {
	/**
	 * 验证存在，并且发送验证码短信成功
	 */
	OKAndSentSmsSuccess, 
	/**
	 * 验证存在，但发送验证码短信失败
	 */
	OKButSendSmsFail, 
	/**
	 * 验证不存在
	 */
	NotExist
}
