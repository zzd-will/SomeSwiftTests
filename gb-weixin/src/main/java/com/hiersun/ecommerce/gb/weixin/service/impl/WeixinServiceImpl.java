package com.hiersun.ecommerce.gb.weixin.service.impl;

import java.util.Date;
import java.util.List;
import java.util.PropertyResourceBundle;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hiersun.ecommerce.gb.weixin.dao.IWeixinAccountAccessDao;
import com.hiersun.ecommerce.gb.weixin.dao.IWeixinRequestDao;
import com.hiersun.ecommerce.gb.weixin.model.AccountInfo;
import com.hiersun.ecommerce.gb.weixin.model.MemberInfo;
import com.hiersun.ecommerce.gb.weixin.model.Product;
import com.hiersun.ecommerce.gb.weixin.model.Shop;
import com.hiersun.ecommerce.gb.weixin.model.WeixinAccountAccess;
import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;
import com.hiersun.ecommerce.gb.weixin.model.enums.WeixinAccountAccessCategory;
import com.hiersun.ecommerce.gb.weixin.model.sms.SmsMessage;
import com.hiersun.ecommerce.gb.weixin.model.sms.SmsSendResult;
import com.hiersun.ecommerce.gb.weixin.service.ICommonService;
import com.hiersun.ecommerce.gb.weixin.service.IMemberService;
import com.hiersun.ecommerce.gb.weixin.service.IProductService;
import com.hiersun.ecommerce.gb.weixin.service.IShopService;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;
import com.hiersun.ecommerce.gb.weixin.service.MemberValidateResult;

/**
 * 微信日志服务
 * 
 * @author zhengruifeng
 *
 */
@Service("weixinService")
public class WeixinServiceImpl implements IWeixinService {
    @Resource  
    private IWeixinRequestDao wxRequestDao;
	@Resource
	private IWeixinAccountAccessDao wxAccountAccessDao;
	@Resource
	private ICommonService commonService;
	@Resource
	private IMemberService memberService;
	@Resource
	private IProductService productService;
	@Resource
	private IShopService shopService;
	
	/**
	 * 手机验证时验证码短信模板
	 */
	private final static String ValidateMobileSmsMessage = PropertyResourceBundle.getBundle("sms").getString("validatemobilemessage");
    
    /**
     * 记录微信消息
     * @param request
     */
	@Override
	public void addWeixinRequest(WeixinRequest request){
		wxRequestDao.addWeixinRequest(request);
	}
	
	
	public WeixinServiceImpl() {
		super();
	}


	/**
	 * 发送验证码
	 */
	@Override
	public MemberValidateResult sendValidationCode(WeixinRequest wxRequest, String idCardNo){		
		MemberValidateResult validateResult;		
		String responseContent = null, remark = null;
				
		//校验身份证是否存在
		MemberInfo memberInfo = memberService.getMemberInfoByIDCard(idCardNo);
		if(memberInfo == null){
			responseContent = "";
			remark = "身份证号码不存在";
			validateResult = MemberValidateResult.NotExist;
		}else{
			//生成6位验证码
			String validationCode = "" + (int)((Math.random()*9+1)*100000);		
			
			//发送短信
			String mobile = memberInfo.getMobile();
			String content = ValidateMobileSmsMessage.replace("$ValidationCode$", validationCode);
			SmsMessage message = new SmsMessage(new String[]{mobile}, content, "黄金银行微信公众号", "用户查询账号信息，验证手机号");
			SmsSendResult result = commonService.sendSmsMessage(message);
			
			//TODO: 可针对短信发送失败做重试或者切换提供商
			
			responseContent = result.getResult() ? validationCode : "";
			remark = result.getResult() ? "" : "验证码短信发送失败";
			validateResult = result.getResult() ? MemberValidateResult.OKAndSentSmsSuccess : MemberValidateResult.OKButSendSmsFail;
		}
		
		//记录相关信息(如果短信发送失败，不记录验证码，但标注在备注中)
		WeixinAccountAccess accountAccess = new WeixinAccountAccess(
				wxRequest.getUserOpenId(), wxRequest.getRequestId(), idCardNo, WeixinAccountAccessCategory.Mobile,
				new Date(), null, 
				responseContent, 
				remark);
		wxAccountAccessDao.addWeixinAccountAccess(accountAccess);	
		
		return validateResult;
	}
	
	
	/**
	 * 根据验证码获取账户信息
	 * 如果返回null，则说明验证码错误；如果member的AccountList的items数为0，则说明会员无理财信息
	 */
	@Override
	public MemberInfo getMemberInfo(WeixinRequest wxRequest, String verifyCode){
		MemberInfo result = null;
		
		//获取同时与验证码和openId相关联的信息并且验证时间在3分钟以内
		WeixinAccountAccess relatedAccountAccess = wxAccountAccessDao.getAccountAccessByValidationCode(
				wxRequest.getUserOpenId(), verifyCode);
		if(relatedAccountAccess != null){
			result = memberService.getMemberInfoByIDCard(relatedAccountAccess.getRequestContent());
		}
		
		//不管是否查询匹配、超时，均记录相关信息
		String responseContent = null, remark = null;
		if(relatedAccountAccess != null){
			if(result == null){
				responseContent = "";
				remark = "验证成功，但已超时，不再返回账户信息";
			}else{
				if(result.getAccountList().size() > 0){
					responseContent = "";
					for(AccountInfo info : result.getAccountList()){
						responseContent += ("," + info.getAccountId());
					}
					responseContent = responseContent.replaceFirst(",", "");
					remark = "验证成功，获取激活状态的黄金理财成功";
				}else{
					responseContent = "";
					remark = "验证成功，但该会员暂时无激活状态的黄金理财";
				}
			}
		}else{
			responseContent = "";
			remark = "验证失败";
		}
		WeixinAccountAccess accountAccess = new WeixinAccountAccess(
				wxRequest.getUserOpenId(), wxRequest.getRequestId(), verifyCode, WeixinAccountAccessCategory.ValidationCode,
				new Date(), 
				relatedAccountAccess == null ? null : relatedAccountAccess.getAccessId(), 
				responseContent, remark);
		wxAccountAccessDao.addWeixinAccountAccess(accountAccess);	
		
		return result;
	}


	@Override
	public Product getProductById(long id) {
		return productService.getProductById(id);
	}


	@Override
	public List<Product> getAllProducts() {
		return productService.getAllProducts();
	}
	
	@Override
	public List<Shop> getAllShops(){		
		return shopService.getAllShops();
	}
}
