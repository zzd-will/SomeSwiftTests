//
//  AliSwift.swift
//  AliPaySwift
//
//  Created by mac on 16/1/8.
//  Copyright © 2016年 planning. All rights reserved.
//
//  zzd ali swift
// 道生一

import Foundation

public struct AliReCode{
    // 订单支付成功
    public static let SUCCESS:String =  "9000"
    // 正在处理中
    public static let DOING:String =  "8000"
    // 订单支付失败
    public static let FAILED:String =  "4000"
    // 用户中途取消
    public static let CANCELED:String =  "6001"
    // 网络连接出错
    public static let NETFAILED:String =  "6002"
}

private struct AliParam{
    // 商户PID
    private static let PARTNER:String = "2088121543485658";
    // 商户收款账号
    private static let SELLER:String = "hxktcaiwu@hiersun.com";
    // 商户私钥，pkcs8格式
    private static let RSA_PRIVATE:String = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALg9Pi/ZpZy7oyIZFLkvL4Ng3k3zdignA3KgZylZq99pwStVydfauQELrEgALrnahbZlPZ4MonK/m7XknYArYDvujYRBaT5Um28s7waaCQBDdk7ALuNgLvLUttXfl8nJH/vtbxtbCE4ynpWdixl00d5+eDmDGey5WGMIdjED5BDPAgMBAAECgYEAmFTy1QeE2kl+gZPxQYhVJbBzPkp9uIdBX4ZmpZbh+BBtylHdWN8ctlObd9DG0Z5vjja5MrPJoUzyBvvmifHTV3F14t1zZ0KfJ+yYXoyT/USRPlv9/SROcBk/j/cdp8WPFXXL29j0TzcjufL95RLrY17yp2xzlbQ2jvI2s9vbFzECQQDveOViK9GbYX9veacQvnmQx3IW5p9bpkGHVOhAPuqAPEm0TwVLDfz1Jt/wDlRmVyaebEOj4cGfHDH+tOWSClMZAkEAxPR3BTHAixrdyxd3S6KqOQJKRnS/?==";
    // 支付宝公钥
    private static let  RSA_PUBLIC:String = "*************";
    //回调服务URL
    private  static let ALIPAY_CALLBACK:String = "http://pay.gb.hiersun.com/alipay/paycallback";
    // 应用注册scheme,在Info.plist定义URL types
    private  static let  ALIURLSCHEME:String = "DiamondAliPay"
    // 签名方式,目前只有"RSA"
    private  static let  ALISIGNTYPE:String = "RSA"
    //接口名称，固定值。
    private  static let SERVICE:String = "mobile.securitypay.pay"
    //支付类型。默认值为：1（商品购买）
    private  static let PAYMENTTYPE:String = "1"
    //商户网站使用的编码格式，固定为utf-8。
    private  static let INPUTCHARSET:String =  "utf-8"
    //设置未付款交易的超时时间，一旦超时，该笔交易就会自动被关闭。当用户输入支付密码、点击确认付款后（即创建支付宝交易后）开始计时。取值范围：1m～15d，或者使用绝对时间（示例格式：2014-06-13 16:00:00）。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。该参数数值不接受小数点，如1.5h，可转换为90m。
    private  static let ITBPAY:String = "10m"
    //显示URL
    private  static let SHOWURL:String = "m.alipay.com"
}

//typealias CB = (resultDic:NSDictionary) -> Void

class AliSwift{
    
    static let shareInstance = AliSwift()
    private init(){
    }
    
    func pay(tradeNO:String,productName:String,amount:Float,productDes:String = "",callBack:(CBResultDic:NSDictionary)->Void){
    
        let order          = Order()
        order.partner      = AliParam.PARTNER
        order.seller       = AliParam.SELLER
        order.tradeNO      = tradeNO //订单ID
        order.productName  = productName //商品标题
        order.productDescription = productDes //商品描述
        
        if amount <= 0.0
        {
            return
        }
        order.amount       = String(format: "%.2f", amount)
        if order.amount == "0.00"
        {
            return
        }
        
        order.notifyURL    = AliParam.ALIPAY_CALLBACK  //回调URL
        order.service      = AliParam.SERVICE
        order.paymentType  = AliParam.PAYMENTTYPE
        order.inputCharset = AliParam.INPUTCHARSET
        order.itBPay       = AliParam.ITBPAY
        order.showUrl      = AliParam.SHOWURL
        
        
        //将商品信息拼接成字符串
        let orderSpec      = order.description
//        print("orderSpec:\(orderSpec)\n")
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        let signer = CreateRSADataSigner(AliParam.RSA_PRIVATE)
        let signedString = signer.signString(orderSpec)
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        var orderString = ""
        if (signedString != nil) {
            
            orderString = "\(orderSpec)&sign=\"\(signedString)\"&sign_type=\"RSA\""
            AlipaySDK.defaultService().payOrder(orderString, fromScheme: AliParam.ALIURLSCHEME, callback: { (resultDic) -> Void in
                callBack(CBResultDic: resultDic)
            })
            
        }    }
    
}