//
//  PopAnimator.swift
//  ClientPickerTableView
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 planning. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    //动画持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    //动画执行的方法
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        containerView!.addSubview(toView!)
        toView!.alpha = 0.0
        UIView.animateWithDuration(duration,
            animations: {
                toView!.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
    
}