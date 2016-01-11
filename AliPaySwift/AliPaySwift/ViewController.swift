//
//  ViewController.swift
//  AliPaySwift
//
//  Created by mac on 16/1/7.
//  Copyright © 2016年 planning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AliSwift.shareInstance.pay("2423232424", productName: "sdfsdf", amount: 0.013,productDes:"hell" ){ (CBResultDic) -> Void in
   
            let memo = CBResultDic["memo"] as! String
            let result = CBResultDic["result"] as! String
            let resultStatus = CBResultDic["resultStatus"] as! String
            print(memo)
            print(result)
            if resultStatus == AliReCode.SUCCESS {
                print("交易成功")
            }
    
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

