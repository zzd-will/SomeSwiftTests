package com.hiersun.ecommerce.gb.weixin.model;

import java.math.BigDecimal;
import java.util.Date;

import com.hiersun.ecommerce.gb.weixin.model.enums.ProductType;

/**
 * 理财产品
 * 
 * @author zhengruifeng
 *
 */
public class Product {	
	private long productId;
	private String productName;
	private String productCode;
	private ProductType productType;
	/**
	 * 年化收益
	 */
	private BigDecimal yearRate;
	/**
	 * 日化收益
	 */
	private BigDecimal dayRate;
	/**
	 * 产品期限（天）
	 */
	private int cycleDay;
	/**
	 * 期限描述[1个月；3个月；1年；自定义]
	 */
	private String deadline;
	/**
	 * 起购重量(g)
	 */
	private String startWeight;
	/**
	 * 产品开始时间
	 */
	private Date startDate;
	/**
	 * 产品截止时间
	 */
	private Date endDate;
	private String description;
	
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public ProductType getProductType() {
		return productType;
	}
	public void setProductType(ProductType productType) {
		this.productType = productType;
	}
	public int getCycleDay() {
		return cycleDay;
	}
	public void setCycleDay(int cycleDay) {
		this.cycleDay = cycleDay;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getStartWeight() {
		return startWeight;
	}
	public void setStartWeight(String startWeight) {
		this.startWeight = startWeight;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public BigDecimal getYearRate() {
		return yearRate;
	}
	public void setYearRate(BigDecimal yearRate) {
		this.yearRate = yearRate;
	}
	public BigDecimal getDayRate() {
		return dayRate;
	}
	public void setDayRate(BigDecimal dayRate) {
		this.dayRate = dayRate;
	}
	
	public Product(long productId, String productName, String productCode, ProductType productType, BigDecimal yearRate,
			BigDecimal dayRate, int cycleDay, String deadline, String startWeight, Date startDate, Date endDate,
			String description) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productCode = productCode;
		this.productType = productType;
		this.yearRate = yearRate;
		this.dayRate = dayRate;
		this.cycleDay = cycleDay;
		this.deadline = deadline;
		this.startWeight = startWeight;
		this.startDate = startDate;
		this.endDate = endDate;
		this.description = description;
	}	
	
	public Product(){
		super();
	}
}
