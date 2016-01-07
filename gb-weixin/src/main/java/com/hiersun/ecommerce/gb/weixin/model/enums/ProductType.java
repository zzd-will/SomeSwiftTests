package com.hiersun.ecommerce.gb.weixin.model.enums;

/**
 * 产品类型
 * 
 * @author zhengruifeng
 *
 */
public enum ProductType {
	/**
	 * 活期
	 */
	CurrentDeposit(1),
	/**
	 * 定期 
	 */
	FixedDeposit(2);
	
	private int productType;
	
	ProductType(int productType){
		this.productType = productType;
	}
	
	public int getProductType(){
		return this.productType;
	}
}
