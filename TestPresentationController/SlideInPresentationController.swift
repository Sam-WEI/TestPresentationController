//
//  SlideInPresentationController.swift
//  TestPresentationController
//
//  Created by WeiShengkun on 2/20/17.
//  Copyright © 2017 WeiShengkun. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    private var direction: PresentationDirection
    
    fileprivate var dimmingView: UIView!
    
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        
        
        dimmingView.leftAnchor.constraint(equalTo: containerView!.leftAnchor).isActive = true
        dimmingView.rightAnchor.constraint(equalTo: containerView!.rightAnchor).isActive = true
        dimmingView.topAnchor.constraint(equalTo: containerView!.topAnchor).isActive = true
        dimmingView.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: 2 / 3.0 * parentSize.width, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height * 2.0/3.0)
        }
    }
    
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame = CGRect.zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width * (1.0/3.0)
        case .bottom:
            frame.origin.y = containerView!.frame.height * (1/3.0)
        default:
            frame.origin = .zero
        }
        
        return frame
    }
}


private extension SlideInPresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
