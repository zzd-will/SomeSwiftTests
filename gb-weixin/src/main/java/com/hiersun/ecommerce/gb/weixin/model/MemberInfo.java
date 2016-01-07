package com.hiersun.ecommerce.gb.weixin.model;

import java.util.ArrayList;

import com.hiersun.ecommerce.gb.weixin.model.enums.Gender;

public class MemberInfo {
	/**
	 * 会员Id
	 */
	private long memberId;
	/**
	 * 会员昵称
	 */
	private String nickName;
	/**
	 * 手机号
	 */
	private String mobile;
	/**
	 * 性别
	 */
	private Gender gender;
	/**
	 * 会员姓名
	 */
	private String userName;
	/**
	 * 身份证
	 */
	private String idCard;
	/**
	 * 黄金理财产品账户列表信息
	 */
	private ArrayList<AccountInfo> accountList;
	
	public long getMemberId() {
		return memberId;
	}
	public void setMemberId(long memberId) {
		this.memberId = memberId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Gender getGender() {
		return gender;
	}
	public void setGender(Gender gender) {
		this.gender = gender;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public ArrayList<AccountInfo> getAccountList() {
		return accountList;
	}
	public void setAccountList(ArrayList<AccountInfo> accountList) {
		this.accountList = accountList;
	}
	
	public MemberInfo() {
		super();
	}
	
	public MemberInfo(long memberId, String nickName, String mobile, Gender gender, String userName, String idCard) {
		super();
		this.memberId = memberId;
		this.nickName = nickName;
		this.mobile = mobile;
		this.gender = gender;
		this.userName = userName;
		this.idCard = idCard;
	}
	
	public MemberInfo(long memberId, String nickName, String mobile, Gender gender, String userName, String idCard,
			ArrayList<AccountInfo> accountList) {
		this(memberId, nickName, mobile, gender, userName, idCard);
		this.accountList = accountList;
	}	
}