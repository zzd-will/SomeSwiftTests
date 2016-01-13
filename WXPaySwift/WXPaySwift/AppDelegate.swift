//
//  AppDelegate.swift
//  WXPaySwift
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 planning. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiManagerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //向微信注册wxd930ea5d5a258f4f
//        [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];
        WXApi.registerApp("wxb4ba3c02aa476ea1",withDescription: "demo" )
        WXApiManager.sharedManager().delegate = self
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //////
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        return  WXApi.handleOpenURL(url, delegate: WXApiManager.sharedManager())
    
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if sourceApplication!.hasPrefix("weixin")  {
        
        return WXApi.handleOpenURL(url, delegate: WXApiManager.sharedManager())
        }
        return true
        
    }
    func managerDidRecvPayResponse(response: Int32) {
        
       
        if 0 == response {
            
            print("支付成功")
            
        }
       
    }
}



