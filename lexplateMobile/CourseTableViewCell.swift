//
//  CourseTableViewCell.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 06.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import CoreData

class CourseTableViewCell: UITableViewCell {

    var course: Course = Course()
    var amount: Double = 0.0
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var counterStepper: UIStepper!
    
    var linkTableView:CourseViewController?
    var basketCount : Int = 0
    
    //var basketList = [NSManagedObject]()
    
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBAction func buttonAction(sender: UIButton) {
        //print("1q")
        
        self.countLabel.text = "1"
        self.course.count = 1
        self.counterStepper.value = 1
        
        changeCount ()
        
        UIView.animateWithDuration(0.4, animations: {
            self.buttonOutlet.alpha = 0
            self.amountLabel.alpha = 1
            self.countLabel.alpha = 1
            self.counterStepper.alpha = 1
        })
        
    }
    
    @IBAction func counterStepperValueChanged(sender: UIStepper) {
        //print ("3q")
        self.countLabel.text = Int(sender.value).description
        self.course.count = Int(sender.value)
        
        changeCount()
        
        if (self.course.count == 0) {
            UIView.animateWithDuration(0.4, animations: {
                self.buttonOutlet.alpha = 1
                self.amountLabel.alpha = 0
                self.countLabel.alpha = 0
                self.counterStepper.alpha = 0
            })
        }
        
    }
    
    func changeCount () {
        //Vit
        //        switch self.course.count {
        //        case 0:
        //            self.amountLabel.text = self.course.price.description
        //        case 1:
        //            self.amountLabel.text = self.course.price.description
        //        default:
        //            self.amountLabel.text = (self.course.price*Double(self.course.count)).description
        //        }
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        request.returnsObjectsAsFaults = false
        
        let result:NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0) {
            //var isUpdated: Bool = false
            for res in result {
                if (res.valueForKey("id")! as! Int == self.course.id) {
                    //context.setValue(self.course.count, forKey: "count")
                    context.deleteObject(res as! NSManagedObject)
                    //amount = (self.course.count as NSNumber).doubleValue * self.course.price
                    //context.setValue(amount, forKey: "amount")
                }
            }
        }
        if (self.course.count != 0) {
            let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Basket", inManagedObjectContext: context)
            newCourse.setValue(self.course.id, forKey: "id")
            newCourse.setValue(self.course.count, forKey: "count")
            newCourse.setValue(self.course.pictureGUID, forKey: "pictureGUID")
            newCourse.setValue(self.course.title, forKey: "title")
            newCourse.setValue(self.course.price, forKey: "price")
            newCourse.setValue(self.course.foodMenuId, forKey: "foodMenuId")
            do {
                try context.save()
            } catch _ {
            }
        }
        
        //для инфы сверху в корзине
        //print(self.course.id.description)
        
            let resultBasket: NSArray = try! context.executeFetchRequest(request)
            
            self.basketCount = 0
            for res in resultBasket {
                if let _ = (res.valueForKey("count") as? Int) {
                    self.basketCount = self.basketCount + 1 //zz
                }
            }
            //print(self.basketCount.description)
            
            self.linkTableView!.labelBasketNew.text = self.basketCount.description
            if (self.basketCount == 0){
                UIView.animateWithDuration(0.4, animations: {
                    self.linkTableView!.labelBasketNew.alpha = 0
                })
            } else {
                UIView.animateWithDuration(0.4, animations: {
                    self.linkTableView!.labelBasketNew.alpha = 1
                })
            }
//        UIView.animateWithDuration(0.4, animations: {
//            self.linkTableView!.tabBarController?.setBadges(self.basketCount)
//            })
        //Конец для инфы сверху в корзине
        
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(course: Course) { //title: String, picture: String, price: Double) {
        self.course = course
        //self.counterStepper.wraps = true  // Vit -- когда 0 и жмем минус - не надо максимальное число   -- и наоборот  -- на форме wrap тоже снять
        self.counterStepper.autorepeat = true
        self.counterStepper.maximumValue = 100
        self.countLabel.text = course.count.description
        self.amountLabel.text = course.price.description   //Vit
        self.titleLabel.text = self.course.title
        
//        self.buttonOutlet.alpha = 1
//        self.amountLabel.alpha = 0
//        self.countLabel.alpha = 0
//        self.counterStepper.alpha = 0
        //self.buttonOutlet.titleLabel?.text = course.count.description
        self.buttonOutlet.setTitle(course.price.description, forState: UIControlState.Normal)
        self.buttonOutlet.layer.cornerRadius = 3
        if (self.course.count == 0){
            self.buttonOutlet.alpha = 1
            self.amountLabel.alpha = 0
            self.countLabel.alpha = 0
            self.counterStepper.alpha = 0
        }
        if (self.course.count != 0){
            self.buttonOutlet.alpha = 0
            self.amountLabel.alpha = 1
            self.countLabel.alpha = 1
            self.counterStepper.alpha = 1
        }
    }
    
    
}
