//
//  OrganizationNavigationController.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 17/09/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class OrganizationNavigationController: UINavigationController {
    
    
    //@IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.barTintColor = UIColor.blue31  // Цвет фона
        navBar.tintColor = UIColor.whiteColor()  // Цвет надписей и надписей влево вправо
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]  // Цвет надписи title

        // Do any additional setup after loading the view.
        
        //Где файлы лежат
//        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        print("App Path: \(dirPaths)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func segueForUnwindingToViewController(toViewController: UIViewController,
//        fromViewController: UIViewController,
//        identifier: String?) -> UIStoryboardSegue {
//            print("qazwsxx")
//            return UIStoryboardSegue(identifier: identifier, source: fromViewController, destination: toViewController)
//                {
//                    print("print!")
//                    let fromView = fromViewController.view
//                    let toView = toViewController.view
//                    if let containerView = fromView.superview
//                    {
//                        let initialFrame = fromView.frame
//                        var offscreenRect = initialFrame
//                        offscreenRect.origin.x -= CGRectGetWidth(initialFrame)
//                        toView.frame = offscreenRect
//                        containerView.addSubview(toView)
//                        // Being explicit with the types NSTimeInterval and CGFloat are important
//                        // otherwise the swift compiler will complain
//                        let duration: NSTimeInterval = 1.0
//                        let delay: NSTimeInterval = 0.0
//                        let options = UIViewAnimationOptions.CurveEaseInOut
//                        let damping: CGFloat = 0.5
//                        let velocity: CGFloat = 4.0
//                        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: damping,
//                            initialSpringVelocity: velocity, options: options, animations: {
//                                toView.frame = initialFrame
//                            }, completion: { finished in
//                                toView.removeFromSuperview()
//                                if let navController = toViewController.navigationController {
//                                    navController.popToViewController(toViewController, animated: false)
//                                }
//                        })
//                    }
//            }
//    }

}
