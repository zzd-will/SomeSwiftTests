package com.hiersun.ecommerce.gb.weixin.service;

import com.hiersun.ecommerce.gb.weixin.model.MemberInfo;

/**
 * 会员服务
 * 
 * @author zhengruifeng
 *
 */
public interface IMemberService {
	/**
	 * 根据用户手机号获取账户信息
	 * @param mobile
	 * @return
	 */
	public MemberInfo getMemberInfo(String mobile);
	
	/**
	 * 根据用户身份证获取账户信息
	 * @param idCardNo
	 * @return
	 */
	public MemberInfo getMemberInfoByIDCard(String idCardNo);
}
