//
//  ViewController.swift
//  TestPresentationController
//
//  Created by WeiShengkun on 2/20/17.
//  Copyright © 2017 WeiShengkun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        
        if controller is OneViewController {
            slideInTransitioningDelegate.direction = .left
        } else if controller is TwoViewController {
            slideInTransitioningDelegate.direction = .right
        }
        
        
        controller.transitioningDelegate = slideInTransitioningDelegate
        controller.modalPresentationStyle = .custom
    }

}

