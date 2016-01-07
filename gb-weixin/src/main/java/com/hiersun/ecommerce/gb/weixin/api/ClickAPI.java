package com.hiersun.ecommerce.gb.weixin.api;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.hiersun.ecommerce.gb.weixin.menu.MenuClickTags;
import com.hiersun.ecommerce.gb.weixin.message.resp.TextMessage;
import com.hiersun.ecommerce.gb.weixin.model.Product;
import com.hiersun.ecommerce.gb.weixin.model.Shop;
import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;
import com.hiersun.ecommerce.gb.weixin.model.enums.ProductType;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;
import com.hiersun.ecommerce.gb.weixin.utils.MessageType;
import com.hiersun.ecommerce.gb.weixin.utils.XMLTools;

public class ClickAPI extends BaseAPI {

	protected String event_key;

	public ClickAPI(int type, Map<String, String> requestMap, IWeixinService wxService) {
		super(type, requestMap, wxService);
		event_key = requestMap.get("EventKey");
	}

	@Override
	public String doAPI(WeixinRequest wxRequest) {

		String resp = "";

		switch (event_key) {
			// 中间收益查询菜单点击
			case MenuClickTags.MID_MAINMENUE:
				resp = doMenuIncomeQuery();
				break;
			// 右边金店位置菜单点击
			case MenuClickTags.RIGHT_MAINMENUE:
				resp =doMenuPosition();
				break;
			default:
				//理财产品
				if(event_key.startsWith("Prd_")){
					/*long productId = Long.parseLong(event_key.replaceFirst("Prd_", ""));
					resp = doProductMenu(productId);*/
					
					//项目一期，先写死
					String productCode = event_key.trim().replaceFirst("Prd_", "");
					resp = doProductMenu(productCode);
				}
				break;
		}

		return resp;
	}
	
	public String doProductMenu(String productCode) {
		String content = null;
		switch(productCode){
			case "A":
				content = "【产品金生金】\n热情向您推荐我们这款【金生金】理财产品，让您的闲置金条、金饰，金生金！\n交易简单，如您熟悉的银行定期储蓄，只不过把“钱”换成“金”。\n您只需把黄金存到我们金店一定期限，到期后便可取走本金加利息。金进金出，既保值又有高收益！您还犹豫什么呢，赶快行动吧！\n点击下方“金店位置”，查询金店具体地址，具体业务请到店咨询！";
				break;
			case "A1":
				content = "【产品旧金变新金】\n还在为旧金换新金高昂的折旧费、工费发愁吗？热情向您推荐我们这款【旧金变新金】理财产品！\n您只需将您的旧金饰存到我们金店十个月，到期后，您便可免手续费在我们金店换取与旧金饰（拆融后克重）等重的新金饰，样式随你选哦！您还犹豫什么呢，赶快行动吧！\n点击下方“金店位置”，查询金店具体地址，具体业务请到店咨询！";
				break;
			default:
				content = "未知产品";
				break;				
		}		
		
		TextMessage textMessage = new TextMessage();
		textMessage.setToUserName(mFromUserName);
		textMessage.setFromUserName(mToUserName);
		textMessage.setCreateTime(mCreateTime);
		textMessage.setMsgType(MessageType.TEXT);
		textMessage.setContent(content);
		return XMLTools.toXML(textMessage);
	}

	public String doProductMenu(long productId) {
		Product product = weixinService.getProductById(productId);
		String content = formatProduct(product);
		
		TextMessage textMessage = new TextMessage();
		textMessage.setToUserName(mFromUserName);
		textMessage.setFromUserName(mToUserName);
		textMessage.setCreateTime(mCreateTime);
		textMessage.setMsgType(MessageType.TEXT);
		textMessage.setContent(content);
		return XMLTools.toXML(textMessage);
	}
	
	/**
	 * 输出单个产品
	 */
	private String formatProduct(Product product){
		if(product == null){
			return "";
		}
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日", Locale.CHINA); 
		DecimalFormat decimalFormat = new DecimalFormat("0.00");
		
		String msg = product.getProductName() + "\n"
				//+ "产品编码："  + product.getProductCode() + "\n"
				+ "产品类型："  + (product.getProductType() == ProductType.CurrentDeposit ? "活期" : "定期") + "\n"
				+ "年化收益率："  + decimalFormat.format(product.getYearRate())+ "%\n"
				+ "起购克重：" + decimalFormat.format(new BigDecimal(product.getStartWeight())) + "g\n"
				+ "产品期限："  + product.getCycleDay() + "天\n"
				//+ "开始时间："  + dateFormat.format(product.getStartDate()) + "\n"
				+ "截止时间："  + dateFormat.format(product.getEndDate()) + "\n"
				+ "产品简介："  + (product.getDescription() == null || product.getDescription().length() < 1 ? "暂无" : product.getDescription());		
		return msg;
	}
	
	

	private String doMenuIncomeQuery() {
		TextMessage textMessage = new TextMessage();
		textMessage.setToUserName(mFromUserName);
		textMessage.setFromUserName(mToUserName);
		textMessage.setCreateTime(mCreateTime);
		textMessage.setMsgType(MessageType.TEXT);
		textMessage.setContent(API_TIPS.QUERYDETIL_TIPS);
		return XMLTools.toXML(textMessage);
	}

	private String doMenuPosition() {
		List<Shop> shops = weixinService.getAllShops();
		String content = formatShops(shops);
		
		TextMessage textMessage = new TextMessage();
		textMessage.setToUserName(mFromUserName);
		textMessage.setFromUserName(mToUserName);
		textMessage.setCreateTime(mCreateTime);
		textMessage.setMsgType(MessageType.TEXT);
		textMessage.setContent(content);
		return XMLTools.toXML(textMessage);
	}

	
	private String formatShops(List<Shop> shops){
		if(shops == null || shops.size() < 1){
			return "暂无金店.";
		}
		
		String msg = "";
		for(Shop shop : shops){
			msg += ("\n\n" + shop.getShopName() + "\n地址：" + shop.getAddress() + "\n电话：" + shop.getTelephone());
		}
		msg += ("\n\n" + API_TIPS.POSITION2_TIPS);
		
		return msg.replaceFirst("\n\n", "");
	}
}
