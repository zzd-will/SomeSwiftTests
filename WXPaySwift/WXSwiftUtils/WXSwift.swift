//
//  WXPay.swift
//  WXPaySwift
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 planning. All rights reserved.
//

import Foundation
/**
 字段名	变量名	类型	必填	示例值	描述
 公众账号ID	appid	String(32)	是	wx8888888888888888	微信分配的公众账号ID
 商户号	partnerid	String(32)	是	1900000109	微信支付分配的商户号
 预支付交易会话ID	prepayid	String(32)	是	WX1217752501201407033233368018	微信返回的支付交易会话ID
 扩展字段	package	String(128)	是	Sign=WXPay	暂填写固定值Sign=WXPay
 随机字符串	noncestr	String(32)	是	5K8264ILTKCH16CQ2502SI8ZNMTM67VS	随机字符串，不长于32位。推荐随机数生成算法
 时间戳	timestamp	String(10)	是	1412000000	时间戳，请见接口规则-参数规定
 签名	sign	String(32)	是	C380BEC2BFD727A4B6845133519F3AD6	签名，详见签名生成算法
 */

private struct WXState{
    static  let   NOTINSTALL:Int = 1
    static  let   NOTSUPPORT:Int = 2
    static  let   SENDREQ:Int = 3
}



class WXSwift {

    static let shareInstance = WXSwift()
    private init(){
    }
    
    
//    //调起微信支付
    func pay(dict:NSDictionary)->Int{
        
        if !WXApi.isWXAppInstalled(){
            return WXState.NOTINSTALL
        }
        if !WXApi.isWXAppSupportApi(){
            return WXState.NOTSUPPORT
            
        }
        
        let timeFormat = NSDateFormatter()
        timeFormat.dateFormat = "yyyyMMddHHmmss"
        
        let timeStr:String = timeFormat.stringFromDate(NSDate())
        
        let req:PayReq = PayReq()
        req.partnerId = dict.objectForKey("partnerid") as! String
        req.prepayId  = dict.objectForKey("prepayId") as! String
        req.nonceStr  = dict.objectForKey("nonceStr") as! String
        req.package   = dict.objectForKey("package") as! String
        req.sign = dict.objectForKey("sign") as! String
        
        req.timeStamp = UInt32(timeStr)!
        
        WXApi.sendReq(req)
        return WXState.SENDREQ
    }
    
    func pay(partnerId:String,prepayId:String,nonceStr:String,package:String,sign:String)->Int{
        
        if !WXApi.isWXAppInstalled(){
            return WXState.NOTINSTALL
        }
        if !WXApi.isWXAppSupportApi(){
            return WXState.NOTSUPPORT
            
        }
        
        let timeFormat = NSDateFormatter()
        timeFormat.dateFormat = "yyyyMMddHHmmss"
        
        let timeStr:String = timeFormat.stringFromDate(NSDate())
        
        let req:PayReq = PayReq()

        req.partnerId = partnerId
        req.prepayId  = prepayId
        req.nonceStr  = nonceStr
        req.package   = package
        req.sign = sign
        
        req.timeStamp = UInt32(timeStr)!
        
        WXApi.sendReq(req)
        
        return WXState.SENDREQ
        
    }
}