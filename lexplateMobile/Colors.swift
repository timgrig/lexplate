//
//  Colors.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 17/09/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var blue:UIColor {
        get {
            return UIColor(red:0.421593, green: 0.657718, blue: 0.972549, alpha: 1)
        }
    }
    
    class var lightBlue:UIColor {
        get {
            return UIColor(red:0.700062, green: 0.817345, blue: 0.972549, alpha: 1)
        }
    }
    
    //Значения взяты из программки Digital Color Meter из папки Applications/Utilities - курсор навести на рисунок и прога покажет ее rgb цвет
    
    //Display native values
    class var blue1:UIColor {
        get {
            return UIColor(red: 64.0/255.0, green: 133.0/255.0, blue: 222.0/255.0, alpha: 1)
        }
    }
    
    //Display native values
    class var blue11:UIColor {
        get {
            return UIColor(red: 63.5/255.0, green: 132.5/255.0, blue: 221.5/255.0, alpha: 1)
        }
    }
    
    //Display in sRGB
    class var blue2:UIColor {
        get {
            return UIColor(red: 73.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1)
        }
    }
    
    
    //---------------------------------------------
    //Display in Generic RGB   наиболее близкий
    class var blue3:UIColor {
        get {
            return UIColor(red:59.0/255.0, green: 122.0/255.0, blue: 219.0/255.0, alpha: 1)
        }   //82  130 221
    }
    
    //Xcode почему-то сам меняет цвет
    class var blue31:UIColor {
        get {
            return UIColor(red:31.0/255.0, green: 112.0/255.0, blue: 217.0/255.0, alpha: 1)
        }   
    }
    //==============================================
    
    //Display in Adobe RGB
    class var blue4:UIColor {
        get {
            return UIColor(red:100.0/255.0, green: 142.0/255.0, blue: 223.0/255.0, alpha: 1)
        }
    }
    

    
}