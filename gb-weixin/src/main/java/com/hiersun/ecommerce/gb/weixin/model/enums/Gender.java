package com.hiersun.ecommerce.gb.weixin.model.enums;

/**
 * 性别
 * 
 * @author zhengruifeng
 *
 */
public enum Gender{
	Male(1), Femal(2), Unknown(0), Other(3);
	
	private int value;
	
	Gender(int gender){
		this.value = gender;
	}
	
	public int getGender(){
		return this.value;
	}
}