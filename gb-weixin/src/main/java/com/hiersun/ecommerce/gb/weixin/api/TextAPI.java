package com.hiersun.ecommerce.gb.weixin.api;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.hiersun.ecommerce.gb.weixin.message.resp.TextMessage;
import com.hiersun.ecommerce.gb.weixin.model.AccountInfo;
import com.hiersun.ecommerce.gb.weixin.model.MemberInfo;
import com.hiersun.ecommerce.gb.weixin.model.Product;
import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;
import com.hiersun.ecommerce.gb.weixin.model.enums.Gender;
import com.hiersun.ecommerce.gb.weixin.model.enums.ProductType;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;
import com.hiersun.ecommerce.gb.weixin.service.MemberValidateResult;
import com.hiersun.ecommerce.gb.weixin.utils.DateUtil;
import com.hiersun.ecommerce.gb.weixin.utils.MessageType;
import com.hiersun.ecommerce.gb.weixin.utils.XMLTools;


public class TextAPI extends BaseAPI {
	private static final Logger logger = Logger.getLogger(TextAPI.class);
	
	public IWeixinService getWeixinService() {
		return weixinService;
	}

	public void setWeixinService(IWeixinService weixinService) {
		this.weixinService = weixinService;
	}

	private String mContent;

	private static final Pattern IDCARD_NO = Pattern.compile("^(\\d{15})|(\\d{18})|(\\d{17}x)$");
	private static final Pattern PHONE_NUMBER = Pattern.compile("^1[3-9][0-9]{9}$");
	private static final Pattern VERIFICATION_CODE = Pattern.compile("^[0-9]{6}$");

	public TextAPI(int type, Map<String, String> requestMap, IWeixinService wxService) {
		super(type, requestMap, wxService);
		mContent = requestMap.get("Content");
	}
	

	@Override
	public String doAPI(WeixinRequest wxRequest) {
		String resText = null;
		switch (checkInput(mContent)) {
		case 1:// 身份证
			resText = doIDCardNo(wxRequest, mContent);
			break;
		case 2:// 验证码
			resText = doVerificationCode(wxRequest, mContent);
			break;
		default:// 未识别的
			resText = API_TIPS.ANY_REPLY_TIPS;
			break;
		}
		
		TextMessage textMessage = new TextMessage();
		textMessage.setToUserName(mFromUserName);
		textMessage.setFromUserName(mToUserName);
		textMessage.setCreateTime(mCreateTime);
		textMessage.setMsgType(MessageType.TEXT);
		textMessage.setContent(resText);
		return XMLTools.toXML(textMessage);		
	}

	private int checkInput(String input) {// 0 未识别；1 身份证；2验证码
		if (isIDCardNo(input)) {
			return 1;
		}
		if (isVerificationCode(input)) {
			return 2;
		}
		return 0;
	}
	
	private boolean isIDCardNo(String content) {
		Matcher m = IDCARD_NO.matcher(content);
		return m.matches();
	}

	private boolean isPhoneNumber(String mobiles) {
		Matcher m = PHONE_NUMBER.matcher(mobiles);
		return m.matches();
	}

	public boolean isVerificationCode(String mobiles) {
		Matcher m = VERIFICATION_CODE.matcher(mobiles);
		return m.matches();
	}

	/**
	 * 身份证号码
	 * @param wxRequest
	 * @param content
	 * @return
	 */
	private String doIDCardNo(WeixinRequest wxRequest, String content) {
		MemberValidateResult result = weixinService.sendValidationCode(wxRequest, content);
		return result == MemberValidateResult.NotExist ? API_TIPS.PHONE_REPLY_NOTEXIST_TIPS : (result == MemberValidateResult.OKAndSentSmsSuccess ? API_TIPS.PHONE_REPLY_TIPS : API_TIPS.PHONE_REPLY_FAIL_TIPS);
	}

	private String doVerificationCode(WeixinRequest wxRequest, String content) {
		MemberInfo info = weixinService.getMemberInfo(wxRequest, content);
		return formatMsg(info);
	}

	private String formatMsg(MemberInfo memberInfo) {
		if (memberInfo == null) {
			return API_TIPS.VERFIYCODE_ERROR;
		} else {
			DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日", Locale.CHINA); 
			String msg = "【黄金钱庄】我的收益账单\n" + dateFormat.format(new Date()) + 
					"\n尊敬的" + memberInfo.getUserName() + (memberInfo.getGender() == Gender.Male ? "先生" : (memberInfo.getGender() == Gender.Femal ? "女士" : "")) +
					"，很乐意为您服务！\n感谢您对我们的信任，您签约购买的理财产品每天正稳稳增收，具体账单详细如下：" +
					"\n---------------------------\n";

			for (AccountInfo info : memberInfo.getAccountList()) {
				msg += (formatAccountInfo(info) + "---------------------------\n");
			}			
			msg += "感谢您购买我们的理财产品，如有疑问可到店咨询，点击下方的\"金店位置\"便可查询到我们门店具体地址";

			return msg;
		}
	}

	private String formatAccountInfo(AccountInfo info)  {
		if(info == null || info.getContractDate() == null){
			return "";
		}
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.CHINA); 
		
		BigDecimal smeltWeight = info.getSmeltWeight();
		smeltWeight = smeltWeight.setScale(2, BigDecimal.ROUND_DOWN); 
		
		String msg = 
				"理财产品：" + info.getProductName() + "\n" 
				+ "签约日期：" + dateFormat.format(info.getContractDate()) + "\n"
				+ "到期日期：" + dateFormat.format(info.getEndIncrementDate()) + "\n"
				+ "存入克重：" + smeltWeight.toString() + "g\n";				
		
		//项目一期，产品id固定：productYearId = 1    一年期；productHalfId = 2     半年期；	productFlexId = 3     以旧换新;
		if(info.getProductId() == 3){	//以旧换新
			if(info.getStatus() == 1 || info.getStatus() == 2){		//未到期
				msg += ("到期可免手续费换取等重新金饰\n" + "产品状态：" + (info.getStatus() == 1 ? "未到期" : "已到期") +  "\n");
			}else{
				msg += ("产品状态：" + (info.getStatus() == 3 ? "已提取" : "已续签") + "\n");
			}			
		}else{							//其它产品		
			if(info.getStatus() == 1 || info.getStatus() == 2){		//未到期
				//一年期产品，年化收益6.8%; 半年期，年化收益5.6%。其它，一期不做支持！
				BigDecimal rate = info.getProductId() == 1 ? 
						new BigDecimal(0.068) : 
							(info.getProductId() == 2 ? new BigDecimal(0.028) : new BigDecimal(0.00));
				BigDecimal willgetWeight = info.getSmeltWeight().multiply(rate);
				willgetWeight = willgetWeight.setScale(2,BigDecimal.ROUND_DOWN); 
				
				msg += ("到期预期收益：" + willgetWeight.toString() + "g\n产品状态：" + (info.getStatus() == 1 ? "未到期" : "已到期") + "\n");
			}else{				
				BigDecimal takeoutProfit = info.getTakeoutProfit();
				takeoutProfit = takeoutProfit.setScale(2, RoundingMode.DOWN);
				msg += ("已获取收益：" + takeoutProfit.toString() + "g\n产品状态：" + (info.getStatus() == 3 ? "已提取" : "已续签") + "\n");
			}	
		}

		return msg;
	}
}
