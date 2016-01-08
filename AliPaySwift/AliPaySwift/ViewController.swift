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
  AliSwift.shareInstance.pay("24232324234", productName: "sdfsdf", productDes: "iiisdfsdf", amount: 0.013) { (CBResultDic) -> Void in
     print("it's here")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

