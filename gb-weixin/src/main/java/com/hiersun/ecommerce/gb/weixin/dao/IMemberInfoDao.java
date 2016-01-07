package com.hiersun.ecommerce.gb.weixin.dao;

import com.hiersun.ecommerce.gb.weixin.model.MemberInfo;

/**
 * 会员信息DAO
 * @author zhengruifeng
 *
 */
public interface IMemberInfoDao {
	/**
	 * 根据手机号获取会员信息
	 * @param mobile
	 * @return
	 */
	public MemberInfo getMemberInfoByMobile(String mobile);
	/**
	 * 根据用户手机号获取账户信息
	 * @param idCardNo
	 * @return
	 */
	public MemberInfo getMemberInfoByIDCard(String idCardNo);
}
