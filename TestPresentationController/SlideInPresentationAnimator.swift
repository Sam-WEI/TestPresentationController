//
//  SlideInPresentationAnimator.swift
//  TestPresentationController
//
//  Created by WeiShengkun on 2/20/17.
//  Copyright © 2017 WeiShengkun. All rights reserved.
//

import UIKit

class SlideInPresentationAnimator: NSObject {
    let direction: PresentationDirection
    let isPresentation: Bool
    
    init(direction: PresentationDirection, isPresentation: Bool) {
        self.direction = direction
        self.isPresentation = isPresentation
        super.init()
    }
    
    
}


extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        
        let controller = transitionContext.viewController(forKey: key)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentFrame = transitionContext.finalFrame(for: controller)
        var dismissFrame = presentFrame
        switch direction {
        case .left:
            dismissFrame.origin.x = -presentFrame.width
        case .right:
            dismissFrame.origin.x = transitionContext.containerView.frame.width
        case .top:
            dismissFrame.origin.y = -presentFrame.height
        case .bottom:
            dismissFrame.origin.y = transitionContext.containerView.frame.height
        }
        
//        let rotate = CGAffineTransform(rotationAngle: -CGFloat.pi / 3)
//        dismissFrame = dismissFrame.applying(rotate)
        
        let initialFrame = isPresentation ? dismissFrame: presentFrame
        let finalFrame = isPresentation ? presentFrame: dismissFrame
        
        controller.view.frame = initialFrame
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: { 
            controller.view.frame = finalFrame
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
        
    }
}
