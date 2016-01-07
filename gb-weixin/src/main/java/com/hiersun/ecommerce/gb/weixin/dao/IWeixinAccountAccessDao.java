package com.hiersun.ecommerce.gb.weixin.dao;

import org.apache.ibatis.annotations.Param;

import com.hiersun.ecommerce.gb.weixin.model.WeixinAccountAccess;

/**
 * 微信用户账户访问DAO
 * 
 * @author zhengruifeng
 *
 */
public interface IWeixinAccountAccessDao {
	/**
	 * 增加微信账户访问记录
	 * @param accountAccess
	 * @return
	 */
	public Boolean addWeixinAccountAccess(WeixinAccountAccess accountAccess);
	/**
	 * 根据校验码获取匹配访问信息
	 * @param userOpenId
	 * @param verifyCode
	 * @return
	 */
	public WeixinAccountAccess getAccountAccessByValidationCode(@Param("userOpenId")String userOpenId, @Param("verifyCode")String verifyCode);
}
