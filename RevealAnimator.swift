//
//  RevealAnimator.swift
//  SwiftLogo
//
//  Created by I_MT on 16/9/24.
//  Copyright © 2016年 I_MT. All rights reserved.
//

import UIKit

class RevealAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    weak var storedContext: UIViewControllerContextTransitioning?
    var duration:NSTimeInterval! = 2.0
    var operation :UINavigationControllerOperation = .Push
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return self.duration
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //保存跳转上下文
        storedContext = transitionContext
        if self.operation == .Push{
            pushAnimation(transitionContext)
        }else if self.operation == .Pop{
            popAnimation(transitionContext)
        }
        
        
        }
    func pushAnimation(transitionContext: UIViewControllerContextTransitioning) -> Void {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! SecondViewController
        //添加跳转上下文的容器中目标视图的view
        transitionContext.containerView()!.addSubview(toVC.view)
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue.init(CATransform3D: CATransform3DIdentity)
        
        let concatTranform = CATransform3DConcat(
            //向上
            CATransform3DMakeTranslation(0.0, -10.0, 0.0),
            //放大
            CATransform3DMakeScale(150.0, 150.0, 1.0)
        )
        animation.toValue = NSValue.init(CATransform3D: concatTranform)
        animation.duration = self.duration
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards

        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        //同时给遮罩和logo添加变形动画
//        toVC.maskLayer.addAnimation(animation, forKey: nil)
        fromVC.logo.addAnimation(animation, forKey: nil)
        
        //配置逐渐显示的图层动画
        let fadeInAnimation = CABasicAnimation.init(keyPath: "opacity")
        fadeInAnimation.fromValue = 0.0
        fadeInAnimation.toValue = 1.0
        fadeInAnimation.duration = self.duration
        //给目的视图控制器的视图添加fade-in动画
        toVC.view.layer.addAnimation(fadeInAnimation, forKey: nil)
    }
    /**
     *注意pop动画进行的时候是无法对视图控制器进行操作的，只能对他们的视图进行操作；
     */
    func popAnimation(transitionContext: UIViewControllerContextTransitioning) -> Void {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)! as UIView
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)! as UIView
        
        transitionContext.containerView()!.insertSubview(toView, belowSubview: fromView)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            fromView.transform = CGAffineTransformMakeScale(0.1, 0.1)
            fromView.alpha = 0.0
            
            }, completion: { (finish) -> Void in
                transitionContext.completeTransition(true)
                
        })
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled())
            //重置logo
            let fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as!ViewController
            fromVC.logo.removeAllAnimations()
            storedContext=nil
         }
    }

}
