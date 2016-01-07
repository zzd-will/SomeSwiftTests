package com.hiersun.ecommerce.gb.weixin.utils;

public enum MessageType {
	
	TEXT("text"), IMAGE("image"), VOICE("voice"), VIDEO("video"), SHORTVIDEO(
			"shortvideo"), LOCATION("location"), LINK("link"),EVENT("event")
	,EVENT_TYPE_SUBSCRIBE("subscribe"),EVENT_TYPE_UNSUBSCRIBE("unsubscribe")
	,EVENT_TYPE_CLICK("CLICK");

	private String type;

	private MessageType(String type) {
		this.type = type;
	}

	public String toString() {
		return type;
	}

	public boolean isEqual(String type) {
		if (this.type.equals(type)) {
			return true;
		} else {
			return false;
		}

	}

}
