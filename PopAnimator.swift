//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by User on 5/13/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originName = CGRect.zero
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let herbView = presenting ? toView : transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        let initialFrame = presenting ? originName : herbView.frame
        let finalFrame = presenting ? herbView.frame : originName
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)
        
        let herbController = transitionContext.viewController(forKey: presenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from) as! HerbDetailsViewController
        
        if presenting {
            herbController.containerView.alpha = 0.0
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            
            herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            herbController.containerView.alpha = self.presenting ? 1.0 : 0.0
            
        }, completion: {_ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
        
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = !presenting ? 0.0 : 20.0/xScaleFactor
        round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        round.duration = duration / 2
        herbView.layer.add(round, forKey: nil)
        herbView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
    }
}
