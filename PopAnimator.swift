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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        container.addSubview(toView)
        toView.alpha = 0.0
        
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
    })
        
    }
}
