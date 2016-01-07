package com.hiersun.ecommerce.gb.weixin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.PropertyResourceBundle;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hiersun.ecommerce.gb.weixin.api.BaseAPI;
import com.hiersun.ecommerce.gb.weixin.api.ClickAPI;
import com.hiersun.ecommerce.gb.weixin.api.SubScribeAPI;
import com.hiersun.ecommerce.gb.weixin.api.TextAPI;
import com.hiersun.ecommerce.gb.weixin.message.req.RequestMessage;
import com.hiersun.ecommerce.gb.weixin.model.WeixinRequest;
import com.hiersun.ecommerce.gb.weixin.service.ICommonService;
import com.hiersun.ecommerce.gb.weixin.service.IMemberService;
import com.hiersun.ecommerce.gb.weixin.service.IWeixinService;
import com.hiersun.ecommerce.gb.weixin.utils.SignTools;

/**
 * 微信对接Api
 * 
 * @author zhengruifeng
 *
 */
@Controller
@RequestMapping("/api")
public class ApiController {
	@Resource
	private IWeixinService weixinService;
	@Resource
	private IMemberService memberService;
	@Resource
	private ICommonService commonService;

	/*
	 * 确认请求来自微信服务器
	 */
	@ResponseBody
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String token = PropertyResourceBundle.getBundle("weixin").getString("token");
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");
		if (signature == null || timestamp == null || nonce == null || echostr == null || token == null
				|| !SignTools.checkSignature(signature, timestamp, nonce, token)) {
			return "post checkSignature error";
		}
		PrintWriter out = response.getWriter();
		out.print(echostr);
		out.close();
		out = null;
		return null;
	}

	
	/*
	 * 处理微信服务器发来的消息
	 */
	@ResponseBody
	@RequestMapping(value = "/index", method = RequestMethod.POST)
	public String indexPost(HttpServletRequest request, HttpServletResponse response) throws IOException {		
		request.setCharacterEncoding("UTF-8");
		RequestMessage reqMsg = new RequestMessage(request);

		// 校验并记录weixin发送过来的全部消息和事件
		WeixinRequest wxRequest = checkSignature(request, reqMsg);
		if (!wxRequest.getIsValid()) {
			return "post checkSignature error";
		}
	
		int type = reqMsg.getMsgType();
		Map<String, String> requestMap = reqMsg.getRequestMap();
		BaseAPI api = null;
		switch (type) {
			case RequestMessage.MSG_TYPE_TEXT:
				api = new TextAPI(type, requestMap, weixinService);
				break;
			case RequestMessage.MSG_TYPE_EVENT_SUBSCRIBE:
				api = new SubScribeAPI(type, requestMap, weixinService);
			case RequestMessage.MSG_TYPE_EVENT_UNSUBSCRIBE:
				//TODO:
				break;
			case RequestMessage.MSG_TYPE_EVENT_CLICK:
				api = new ClickAPI(type, requestMap, weixinService);
				break;
			default:
				//TODO: 其他类型的消息和事件暂时不处理，后续如果需要，可自行加上
				break;
		}
		String respXml = api.doAPI(wxRequest);
		response.setCharacterEncoding("UTF-8");
		if (respXml == null) {
			return "respXml is null";
		}
		PrintWriter out = response.getWriter();
		out.print(respXml);
		out.close();
		out = null;
		return null;
	}

	
	/**
	 * 校验并记录weixin发送过来的消息
	 * 
	 * @param request
	 * @param reqMsg
	 * @return
	 */
	private WeixinRequest checkSignature(HttpServletRequest request, RequestMessage reqMsg) {		
		// 解析微信请求消息的信息，赋值到msg对象
		WeixinRequest wxRequest = new WeixinRequest(reqMsg);

		// 校验消息传递参数是否完整
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		if (signature == null || timestamp == null || nonce == null) {
			wxRequest.setIsValid(false);
			wxRequest.setValidationRemark("消息参数不完整");
		}else{
			// 校验消息是否合法
			String token = PropertyResourceBundle.getBundle("weixin").getString("token");
			if (!SignTools.checkSignature(signature, timestamp, nonce, token)) {
				wxRequest.setIsValid(false);
				wxRequest.setValidationRemark("消息非法");
			}else{
				wxRequest.setIsValid(true);
			}
		}

		weixinService.addWeixinRequest(wxRequest);
		return wxRequest;
	}	
}
