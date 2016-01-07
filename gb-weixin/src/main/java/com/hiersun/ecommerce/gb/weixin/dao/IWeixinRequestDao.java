package com.hiersun.ecommerce.gb.weixin.dao;

import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;

/**
 * 微信请求DAO
 * 
 * @author zhengruifeng
 *
 */
public interface IWeixinRequestDao {
	/**
	 * 增加微信请求
	 * 
	 * @param request
	 * @return
	 */
	public boolean addWeixinRequest(WeixinRequest request);
}
