package com.hiersun.ecommerce.gb.weixin.message.resp;



/*
 * 文本消息xml格式
 <xml>
<ToUserName><![CDATA[toUser]]></ToUserName>
<FromUserName><![CDATA[fromUser]]></FromUserName>
<CreateTime>12345678</CreateTime>
<MsgType><![CDATA[text]]></MsgType>
<Content><![CDATA[你好]]></Content>
</xml>
  */

public class TextMessage extends BaseMessage {
	
	private String Content;

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}

	 public String toString() {
	        return this.Content;
	    }
	 public TextMessage(){
		 super();
	 }


}
