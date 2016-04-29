//
//  BasketNavigationController.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 07/10/15.
//  Copyright © 2015 EcoSoft. All rights reserved.
//

import UIKit

class BasketNavigationController: UINavigationController {
    
    

    @IBOutlet weak var NavBar: UINavigationBar!
    
    
    @IBOutlet weak var KorzinaBar: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavBar.barTintColor = UIColor.blue31  // Цвет фона
        NavBar.tintColor = UIColor.whiteColor()  // Цвет надписей и надписей влево вправо
        NavBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]  // Цвет надписи title
        
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

}
