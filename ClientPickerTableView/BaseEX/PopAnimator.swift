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
        /**
         UIViewControllerAnimatedTransitioning的协议都包含一个对象：transitionContext，通过这个对象能获取到切换时的上下文信息，比如从哪个VC切换到哪个VC等。我们从transitionContext获取containerView，这是一个特殊的容器，切换时的动画将在这个容器中进行；UITransitionContextFromViewControllerKey和UITransitionContextToViewControllerKey就是从哪个VC切换到哪个VC，容易理解；除此之外，还有直接获取view的UITransitionContextFromViewKey和UITransitionContextToViewKey等。
         */
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        containerView!.addSubview(toView!)
        toView!.alpha = 0.0
        toView?.backgroundColor = UIColor.blackColor()
        UIView.animateWithDuration(duration,
            animations: {
                toView!.alpha = 1.0
                toView?.backgroundColor = UIColor.yellowColor()
            }, completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
    
}