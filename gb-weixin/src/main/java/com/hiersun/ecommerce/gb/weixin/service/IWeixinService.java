package com.hiersun.ecommerce.gb.weixin.service;

import java.util.List;

import com.hiersun.ecommerce.gb.weixin.model.MemberInfo;
import com.hiersun.ecommerce.gb.weixin.model.Product;
import com.hiersun.ecommerce.gb.weixin.model.Shop;
import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;

/**
 * 微信服务
 * 
 * @author zhengruifeng
 *
 */
public interface IWeixinService {
	/**
	 * 增加微信访问信息
	 * @param request
	 */
	public void addWeixinRequest(WeixinRequest request);

	/**
	 * 发送验证码
	 * @param wxRequest
	 * @param idCardNo
	 * @return
	 */
	public MemberValidateResult sendValidationCode(WeixinRequest wxRequest, String idCardNo);
	
	/**
	 * 根据验证码获取账户信息
	 * 如果返回null，则说明验证码错误；如果member的AccountList的items数为0，则说明会员无理财信息
	 * @param wxRequest
	 * @return
	 */
	public MemberInfo getMemberInfo(WeixinRequest wxRequest, String verifyCode);
	
	/**
	 * 获取产品详情
	 * @param id
	 * @return
	 */
	public Product getProductById(long id);
	/*
	 * 获取所有产品
	 */
	public List<Product> getAllProducts();
	/**
	 * 获取所有金店
	 * @return
	 */
	public List<Shop> getAllShops();
}
