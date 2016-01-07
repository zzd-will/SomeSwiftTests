package com.hiersun.ecommerce.gb.weixin.model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 账户信息
 */
public class AccountInfo {
	/**
	 * 理财产品账户Id
	 * 注：购买一次产品，生成一个账户Id
	 */
	private long accountId;
	/**
	 * 合同Id
	 */
	private String contractNo;
	/**
	 * 合同签约时间
	 */
	private Date contractDate;
	/**
	 * 账户开始增长时间
	 */
	private Date startIncrementDate;
	/**
	 * 账户截止增长时间
	 */
	private Date endIncrementDate;
	/**
	 * 会员Id
	 */
	private long memberId;
	/**
	 * 理财产品Id
	 */
	private long productId;
	/**
	 * 理财产品名称
	 */
	private String productName;
	/**
	 * 黄金初试重量
	 */
	private BigDecimal originWeight;
	/**
	 * 融化后重量
	 */
	private BigDecimal smeltWeight;
	/**
	 * 当前结算时间
	 */
	private Date currentSettledDate;
	/**
	 * 当前结算重量 （初始重量 + 增长重量）
	 */
	private BigDecimal currentSettledWeight;
	/**
	 * 账户状态
	 */
	private int status;
	/**
	 * 提取收益(用户可能提前提取)
	 */
	private BigDecimal takeoutProfit;
	
	public BigDecimal getTakeoutProfit() {
		return takeoutProfit;
	}
	public void setTakeoutProfit(BigDecimal takeoutProfit) {
		this.takeoutProfit = takeoutProfit;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCurrentSettledDate() {
		return currentSettledDate;
	}
	public void setCurrentSettledDate(Date currentSettledDate) {
		this.currentSettledDate = currentSettledDate;
	}
	public BigDecimal getCurrentSettledWeight() {
		return currentSettledWeight;
	}
	public void setCurrentSettledWeight(BigDecimal currentSettledWeight) {
		this.currentSettledWeight = currentSettledWeight;
	}
	public long getAccountId() {
		return accountId;
	}
	public void setAccountId(long accountId) {
		this.accountId = accountId;
	}
	public String getContractNo() {
		return contractNo;
	}
	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}
	public Date getContractDate() {
		return contractDate;
	}
	public void setContractDate(Date contractDate) {
		this.contractDate = contractDate;
	}
	public Date getStartIncrementDate() {
		return startIncrementDate;
	}
	public void setStartIncrementDate(Date startIncrementDate) {
		this.startIncrementDate = startIncrementDate;
	}
	public Date getEndIncrementDate() {
		return endIncrementDate;
	}
	public void setEndIncrementDate(Date endIncrementDate) {
		this.endIncrementDate = endIncrementDate;
	}
	public long getMemberId() {
		return memberId;
	}
	public void setMemberId(long memberId) {
		this.memberId = memberId;
	}
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return this.productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public BigDecimal getOriginWeight() {
		return originWeight;
	}
	public void setOriginWeight(BigDecimal originWeight) {
		this.originWeight = originWeight;
	}
	public BigDecimal getSmeltWeight() {
		return smeltWeight;
	}
	public void setSmeltWeight(BigDecimal smeltWeight) {
		this.smeltWeight = smeltWeight;
	}
	public int getStatus() {
		return status;
	}
	public void setSmeltWeight(int status) {
		this.status = status;
	}
	
	public AccountInfo() {
		super();
	}
	
	public AccountInfo(long accountId, String contractNo, Date contractDate, Date startIncrementDate, Date endIncrementDate, long memberId,
			long productId, String productName, BigDecimal originWeight, BigDecimal smeltWeight,
			Date currentSettledDate, BigDecimal currentSettledWeight, int status, BigDecimal takeoutProfit) {
		super();
		this.accountId = accountId;
		this.contractNo = contractNo;
		this.contractDate = contractDate;
		this.startIncrementDate = startIncrementDate;
		this.endIncrementDate = endIncrementDate;
		this.memberId = memberId;
		this.productId = productId;
		this.productName = productName;
		this.originWeight = originWeight;
		this.smeltWeight = smeltWeight;
		this.currentSettledDate = currentSettledDate;
		this.currentSettledWeight = currentSettledWeight;
		this.status = status;
		this.takeoutProfit = takeoutProfit;
	}
}
