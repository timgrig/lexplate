//
//  InformationTabBarController.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 27/08/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class InformationTabBarController: UITabBarController, UITabBarControllerDelegate {

    
    
    @IBOutlet weak var myTabBar: UITabBar!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.delegate = self -- self присваивается в KindMenuViewController - иначе в окно не передать данные
 

        // Do any additional setup after loading the view.
        
        self.myTabBar.tintColor = UIColor.whiteColor()
        self.myTabBar.barTintColor = UIColor.blue31
        
        
        
//        var i1 = self.myTabBar.items![1]
//        
//        
//        
//        for t in self.myTabBar.subviews{
//            if let e = t as? UIView {
//                //if (e.tag == 77) {
//                e.add
//                //}
//            }
//            
//        }
        
////        var v2 = self.myTabBar.subviews[1]
//        var l = UILabel()
//        l.text = "HELLO"
////        v2.addSubview(l)
//        
//        self.myTabBar.subviews[1].addSubview(l)
        
//        var lbl : UILabel = UILabel(frame: CGRectMake(225, 5, 20, 20))
//        lbl.layer.borderColor = UIColor.whiteColor().CGColor
//        lbl.layer.borderWidth = 2
//        lbl.layer.cornerRadius = lbl.bounds.size.height/2
//        lbl.textAlignment = NSTextAlignment.Center
//        lbl.layer.masksToBounds = true
//        //lbl.font = UIFont(name: hereaddyourFontName, size: 13)
//        lbl.textColor = UIColor.whiteColor()
//        lbl.backgroundColor = UIColor.redColor()
//        lbl.text = "1555" //if you no need remove this
//        // add subview to tabBarController?.tabBar
//        self.tabBarController?.tabBar.addSubview(lbl)
//        //self.myTabBar.subviews[1].addSubview(lbl)
        
 
        
        //self.myTabBar.items![1].badgeValue = "hello"
        
        for badgeView in (self.myTabBar.subviews[1]).subviews {
            let  className : NSString = NSStringFromClass(badgeView.classForCoder)
            //let className = "\(_stdlib_getDemangledTypeName(badgeView))"
            if className.rangeOfString("BadgeView").location != NSNotFound {
//                badgeView.layer.transform = CATransform3DMakeTranslation(0.0, 0.0, 0.0)
//                badgeView.layer.transform = CATransform3DMakeTranslation(0.0, 10.0, 20.0)
                //print("werty")
                //badgeView.backgroundColor = UIColor.greenColor()
                
                
                
                for badgeSubView in badgeView.subviews {
                    let  className2 : NSString = NSStringFromClass(badgeSubView.classForCoder)
                    if className2.rangeOfString("BadgeBackground").location != NSNotFound {
//                        print("fgnbht")
//                        badgeSubView.backgroundColor = UIColor.greenColor()
//                        badgeSubView.layer.backgroundColor = UIColor.greenColor().CGColor
                    }
                    
//                    if let labelL = badgeSubView as? UILabel {
//                        labelL.backgroundColor = UIColor.greenColor()
//                    }
                    
                }
            }
        }
    
        self.setBadges(0)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        
//        let tabViewControllers = tabBarController.viewControllers
//        let fromView = tabBarController.selectedViewController!.view
//        let toView = viewController.view
//        
//        if (fromView == toView) {
//            return false
//        }
//        
//        let fromIndex = find(tabViewControllers as! [UIViewController], tabBarController.selectedViewController!)
//        let toIndex = find(tabViewControllers as! [UIViewController], viewController)
//        
//        let offScreenRight = CGAffineTransformMakeTranslation(toView.frame.width, 0)
//        let offScreenLeft = CGAffineTransformMakeTranslation(-toView.frame.width, 0)
//        
//        // start the toView to the right of the screen
//        
//        
//        if (toIndex < fromIndex) {
//            toView.transform = offScreenLeft
//            fromView.transform = offScreenRight
//        } else {
//            toView.transform = offScreenRight
//            fromView.transform = offScreenLeft
//        }
//        
//        fromView.tag = 124
//        toView.addSubview(fromView)
//        
//        self.view.userInteractionEnabled = false
//        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//            
//            toView.transform = CGAffineTransformIdentity
//            
//            }, completion: { finished in
//                
//                let subViews = toView.subviews
//                for subview in subViews{
//                    if (subview.tag == 124) {
//                        subview.removeFromSuperview()
//                    }
//                }
//                tabBarController.selectedIndex = toIndex!
//                self.view.userInteractionEnabled = true
//                
//        })
//        
//        return true
//    }

}








extension UITabBarController {
    func setBadges(value:Int){
        
        var existsbadgeView : Bool = false
        for view in self.tabBar.subviews {
            if view.isKindOfClass(LexplateTabBadge) {
                existsbadgeView = true
                let badgeView = view as! LexplateTabBadge

                    badgeView.text = value.description
                if (value == 0) {
                    badgeView.alpha=0
                }
                if (value != 0) {
                    badgeView.alpha=1
                }

            }
        }

        if (existsbadgeView == false){
        addBadge(0, value: value, color:UIColor.orangeColor(), font: UIFont(name: "Helvetica-Light", size: 11)!, badgeValue: 0)
    }
  
    }
    
    func addBadge(index:Int,value:Int, color:UIColor, font:UIFont, badgeValue: Int){
        
        let itemPosition = CGFloat(2) //CGFloat(index+1)
        let itemWidth:CGFloat = tabBar.frame.width / CGFloat(tabBar.items!.count)
        
        let bgColor = color
        
        let xOffset:CGFloat = 12
        let yOffset:CGFloat = -9
        
        let badgeView = LexplateTabBadge()
        badgeView.font = UIFont(name: badgeView.font.fontName, size: 11)
        //badgeView.frame.size=CGSizeMake(17, 17)
        
        badgeView.text = value.description
        var newLabelFrame = badgeView.frame
        let maxWidth: CGFloat! = CGFloat(0)
        var textSize = self.dynamicType.sizeForContentString(value.description, forMaxWidth: maxWidth, fontMy: badgeView.font)
        textSize.width = textSize.width+10
        textSize.height = textSize.height+2
        newLabelFrame.size = textSize
        badgeView.frame = newLabelFrame
        
        badgeView.center=CGPointMake((itemWidth * itemPosition)-(itemWidth/2)+xOffset+(textSize.width/2), 20+yOffset)
        if (value == 0) {
            badgeView.alpha=0
        }
        if (value != 0) {
            badgeView.alpha=1
        }

        badgeView.layer.cornerRadius=badgeView.frame.size.height / 2.0
        
        badgeView.layer.masksToBounds = true
        badgeView.layer.borderWidth = CGFloat(1)
        badgeView.layer.borderColor = UIColor.whiteColor().CGColor
    
        badgeView.clipsToBounds = true
        //badgeView.layer.shouldRasterize = true
        badgeView.textColor=UIColor.whiteColor()
        badgeView.textAlignment = .Center
        //badgeView.font = font
        
        badgeView.backgroundColor = bgColor
        badgeView.tag=index
        tabBar.addSubview(badgeView)
        
    }
    
    class func sizeForContentString(s: String, forMaxWidth maxWidth: CGFloat, fontMy:UIFont) -> CGSize {
        //return CGSizeZero
        let maxSize = CGSizeMake(maxWidth, 1000)
        let opts = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.ByCharWrapping
        //let attributes = [ NSFontAttributeName: self.defaultFont(), NSParagraphStyleAttributeName: style]
        let attributes = [ NSFontAttributeName: fontMy, NSParagraphStyleAttributeName: style]
        
        let string = s as NSString
        let rect = string.boundingRectWithSize(maxSize, options: opts,
            attributes: attributes, context: nil)
        return rect.size
    }
    
    class func defaultFont() -> UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
}

//Сделаем идентичный класс но с другим названием чтобы наши label отличать от других системных label-ов
class LexplateTabBadge: UILabel {
    
}
