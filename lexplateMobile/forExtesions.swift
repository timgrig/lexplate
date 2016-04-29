//
//  forExtesions.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 28/10/15.
//  Copyright © 2015 EcoSoft. All rights reserved.
//
import UIKit

extension UIViewController {
    func navigationShouldPopOnBackButton() -> Bool {
        return true
    }
}

extension UINavigationController {
    
    func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        if let vc = self.topViewController {
            if vc.navigationShouldPopOnBackButton() {
                self.popViewControllerAnimated(true)
            } else {
                for it in navigationBar.subviews {
                    //let view = it as! UIView
                    let view = it 
                    if view.alpha < 1.0 {
                        [UIView .animateWithDuration(0.25, animations: { () -> Void in
                            view.alpha = 1.0
                        })]
                    }
                }
                return false
            }
        }
        return true
    }
    
}