package com.hiersun.ecommerce.gb.weixin.controller;

import java.io.IOException;
import java.util.List;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hiersun.ecommerce.gb.weixin.menu.Button;
import com.hiersun.ecommerce.gb.weixin.menu.CommonButton;
import com.hiersun.ecommerce.gb.weixin.menu.ComplexButton;
import com.hiersun.ecommerce.gb.weixin.menu.Menu;
import com.hiersun.ecommerce.gb.weixin.menu.MenuClickTags;
import com.hiersun.ecommerce.gb.weixin.model.Product;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;
import com.hiersun.ecommerce.gb.weixin.utils.AccessToken;
import com.hiersun.ecommerce.gb.weixin.utils.WeixinUtils;

@Controller
@RequestMapping("/hxgbwxmanage")
public class ManageController {
	@Resource
	private IWeixinService weixinService;
	
	@ResponseBody
	@RequestMapping(value = "/deletemenu", method = RequestMethod.GET,  produces = "application/json;charset=UTF-8")
	public String deleteMenu(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String msg = null;
		
		ResourceBundle bundle = PropertyResourceBundle.getBundle("weixin");
		String appID = bundle.getString("appId");
		String appsecret = bundle.getString("appSecret");
		AccessToken access_token = WeixinUtils.getAccessToken(appID, appsecret);

		// 能正常获取token后今夕创建工作
		if (access_token != null) {
			// 这里使用post进行菜单创建
			int result = WeixinUtils.deleteMenu(access_token.getToken());
			msg = result == 0 ? "菜单删除成功！" : "菜单删除失败，错误码：" + result;
		}else{
			msg = "token获取错误";
		}	
		
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value = "/createmenu", method = RequestMethod.GET,  produces = "application/json;charset=UTF-8")
	public String createMenu(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String msg = null;
		
		ResourceBundle bundle = PropertyResourceBundle.getBundle("weixin");
		String appID = bundle.getString("appId");
		String appsecret = bundle.getString("appSecret");
		AccessToken access_token = WeixinUtils.getAccessToken(appID, appsecret);
		
		// 能正常获取token后今夕创建工作
		if (access_token != null) {
			Menu menu = getMenu();
			
			// 这里使用post进行菜单创建
			int result = WeixinUtils.createMenu(menu, access_token.getToken());

			msg = result == 0 ? "菜单创建成功！" : "菜单创建失败，错误码：" + result;
		}
		
		return msg;
	}
	
	
	private Menu getMenu() {	
		ComplexButton mainBtn1 = new ComplexButton();
		mainBtn1.setName("产品介绍");
		
		// 说明: 一期项目，暂时先写死；二期项目，产品为动态时，可采用本段		
		/*
		List<Product> products = weixinService.getAllProducts();
		if(products != null && products.size() > 0){
			Button[] btnProducts = new Button[products.size()];
			for(int i=0;i<products.size();i++){
				Product p = products.get(i);
				
				CommonButton btn = new CommonButton();			
				btn.setName(p.getProductName());
				btn.setType("click");
				btn.setKey("Prd_" + p.getProductId());
				
				btnProducts[i] = btn;
			}
			mainBtn1.setSub_button(btnProducts);
		}	*/

		CommonButton btnProduct_A = new CommonButton();			
		btnProduct_A.setName("【产品金生金】");
		btnProduct_A.setType("click");
		btnProduct_A.setKey("Prd_A");
		
		CommonButton btnProduct_A1 = new CommonButton();			
		btnProduct_A1.setName("【产品旧金变新金】");
		btnProduct_A1.setType("click");
		btnProduct_A1.setKey("Prd_A1");
		
		Button[] btnProducts = {btnProduct_A, btnProduct_A1};
		mainBtn1.setSub_button(btnProducts);
		

		CommonButton mainBtn2 = new CommonButton();
		mainBtn2.setName("收益查询");
		mainBtn2.setType("click");
		mainBtn2.setKey(MenuClickTags.MID_MAINMENUE);

		CommonButton mainBtn3 = new CommonButton();
		mainBtn3.setName("金店位置");
		mainBtn3.setType("click");
		mainBtn3.setKey(MenuClickTags.RIGHT_MAINMENUE);

		Menu menu = new Menu();
		menu.setButton(new Button[] { mainBtn1, mainBtn2, mainBtn3 });

		return menu;
	}
}
