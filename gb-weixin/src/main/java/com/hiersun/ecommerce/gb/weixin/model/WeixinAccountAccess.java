package com.hiersun.ecommerce.gb.weixin.model;

import java.util.Date;

import com.hiersun.ecommerce.gb.weixin.model.enums.WeixinAccountAccessCategory;

/**
 * 微信用户账户查询
 * 
 * @author zhengruifeng
 *
 */
public class WeixinAccountAccess {
	/**
	 * 访问id
	 */
	private long accessId;
	/**
	 * 用户openId
	 */
	private String userOpenId;
	/**
	 * 请求id
	 */
	private long requestId;
	/**
	 * 请求内容
	 */
	private String requestContent;
	/**
	 * 请求类别
	 */
	private WeixinAccountAccessCategory requestCategory;
	/**
	 * 请求时间
	 */
	private Date requestTime;
	/**
	 * 相关联访问id
	 */
	private Long relatedAccessId;
	/**
	 * 反馈内容
	 */
	private String responseContent;
	/**
	 * 备注
	 */
	private String remark;
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public long getAccessId() {
		return accessId;
	}
	public void setAccessId(long accessId) {
		this.accessId = accessId;
	}
	public String getUserOpenId() {
		return userOpenId;
	}
	public void setUserOpenId(String userOpenId) {
		this.userOpenId = userOpenId;
	}
	public long getRequestId() {
		return requestId;
	}
	public void setRequestId(long requestId) {
		this.requestId = requestId;
	}
	public String getRequestContent() {
		return requestContent;
	}
	public void setRequestContent(String requestContent) {
		this.requestContent = requestContent;
	}
	public WeixinAccountAccessCategory getRequestCategory() {
		return requestCategory;
	}
	public void setRequestCategory(WeixinAccountAccessCategory requestCategory) {
		this.requestCategory = requestCategory;
	}
	public Date getRequestTime() {
		return requestTime;
	}
	public void setRequestTime(Date requestTime) {
		this.requestTime = requestTime;
	}
	public Long getRelatedAccessId() {
		return relatedAccessId;
	}
	public void setRelatedAccessId(Long relatedAccessId) {
		this.relatedAccessId = relatedAccessId;
	}
	public String getResponseContent() {
		return responseContent;
	}
	public void setResponseContent(String responseContent) {
		this.responseContent = responseContent;
	}
	
	public WeixinAccountAccess(String userOpenId, long requestId, String requestContent,
			WeixinAccountAccessCategory requestCategory, Date requestTime, Long relatedAccessId,
			String responseContent, String remark) {
		super();
		this.userOpenId = userOpenId;
		this.requestId = requestId;
		this.requestContent = requestContent;
		this.requestCategory = requestCategory;
		this.requestTime = requestTime;
		this.relatedAccessId = relatedAccessId;
		this.responseContent = responseContent;
		this.remark = remark;
	}	
	
	public WeixinAccountAccess(){
		super();
	}
}
