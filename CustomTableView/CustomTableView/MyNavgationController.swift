//
//  MyNavgationController.swift
//  CustomTableView
//
//  Created by mac on 16/1/4.
//  Copyright © 2016年 planning. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    var popoverDelegate: PresentingModalViewControllerDelegate?
    
    func SELdone() {
        if let delegate = popoverDelegate {
            delegate.dismissPresentedModalViewController(self, animated: true)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    func SELright(){
        print("RIGHT SELECT ")
        popoverDelegate?.gotoSetting()
    }
}

protocol PresentingModalViewControllerDelegate {
    func dismissPresentedModalViewController(modalViewController: UIViewController, animated: Bool)
    func  gotoSetting()
}
