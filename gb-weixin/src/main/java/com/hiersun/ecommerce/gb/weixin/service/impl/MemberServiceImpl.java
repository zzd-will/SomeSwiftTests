package com.hiersun.ecommerce.gb.weixin.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hiersun.ecommerce.gb.weixin.dao.IMemberInfoDao;
import com.hiersun.ecommerce.gb.weixin.model.MemberInfo;
import com.hiersun.ecommerce.gb.weixin.service.IMemberService;

/**
 * 会员服务
 * 
 * @author zhengruifeng
 *
 */
@Service("memberService") 
public class MemberServiceImpl implements IMemberService {
	@Resource
	private IMemberInfoDao memberInfoDao;
	
	/*
	 * 根据用户手机号获取账户信息
	 */
	public MemberInfo getMemberInfo(String mobile){
		return memberInfoDao.getMemberInfoByMobile(mobile);
	}
	
	public MemberInfo getMemberInfoByIDCard(String idCardNo){
		return memberInfoDao.getMemberInfoByIDCard(idCardNo);
	}
}
