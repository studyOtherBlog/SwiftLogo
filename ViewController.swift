//
//  ViewController.swift
//  SwiftLogo
//
//  Created by I_MT on 16/9/24.
//  Copyright © 2016年 I_MT. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate {
    let transition = RevealAnimator()
     var logo :CAShapeLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate=self
        logo = swiftLogoLayer.logoLayer()
        self.view.backgroundColor = UIColor.darkGrayColor()
//        self.view.backgroundColor=UIColor.whiteColor()
        //        logo.position = CGPointMake(self.view.center.x, self.view.center.y+30)
        logo.position = CGPoint(x: view.layer.bounds.size.width/2,
                                y: view.layer.bounds.size.height/2+30+30)
        logo.fillColor=UIColor.whiteColor().CGColor
//        logo.fillColor=UIColor.clearColor().CGColor
//        logo.strokeColor=UIColor.blackColor().CGColor
//        logo.lineWidth = 3.0
//        logo.borderColor=UIColor.yellowColor().CGColor
//        logo.borderWidth = 5.0
     /*   let newLayer = swiftLogoLayer.logoLayer()
        newLayer.position = CGPoint.init(x: view.layer.bounds.size.width/2+20, y: view.layer.bounds.size.height/2+30+30)
        self.view.layer.mask = newLayer */
        self.view.layer.addSublayer(logo)
        addGesture()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
          }
    func addGesture() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action:#selector(ViewController.tapAction))
        self.view.addGestureRecognizer(tapGesture)
    }
    func tapAction() -> Void  {
        self.performSegueWithIdentifier("details", sender: nil)
    }

   func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        self.transition.operation=operation
        return self.transition
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

