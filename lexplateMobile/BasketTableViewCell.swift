//
//  BasketTableViewCell.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 08.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import CoreData

class BasketTableViewCell: UITableViewCell {

    var course = Course()
    var amount = 0.0
    
    //--Vit 20.07.15
    var sumMoneyD: Double = 0.0
    var linkTableView:BasketViewController?
    var indexPathV: NSIndexPath?
    //--Vit 20.07.15
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var counterStepper: UIStepper!
    
    @IBAction func counterStepperValueChanged(sender: UIStepper) {
        self.countLabel.text = Int(sender.value).description
        self.course.count = Int(sender.value)
        
        //Vit
//        switch self.course.count {
//        case 0:
//            self.amountLabel.text = self.course.price.description
//        case 1:
//            self.amountLabel.text = self.course.price.description
//        default:
//            self.amountLabel.text = (self.course.price*Double(self.course.count)).description
//        }
        setAmountLabelText()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        request.returnsObjectsAsFaults = false
        
        let result:NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0) {
            //var isUpdated: Bool = false
            for res in result {
                if (res.valueForKey("id")! as! Int == self.course.id) {
                    context.deleteObject(res as! NSManagedObject)
                    //context.setValue(self.course.count as AnyObject, forKey: "count")
                    //context.save(nil)
                    //amount = (self.course.count as NSNumber).doubleValue * self.course.price
                    //context.setValue(amount, forKey: "amount")
                }
            }
            if (self.course.count != 0) {
                let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Basket", inManagedObjectContext: context) 
                newCourse.setValue(self.course.id, forKey: "id")
                newCourse.setValue(self.course.count, forKey: "count")
                newCourse.setValue(self.course.pictureGUID, forKey: "pictureGUID")
                newCourse.setValue(self.course.title, forKey: "title")
                newCourse.setValue(self.course.price, forKey: "price")
                do {
                    try context.save()
                } catch _ {
                }
            }
        }
        
        //-------------------------------------
        sumMoneyD=0
        
        //var appDel2: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context2: NSManagedObjectContext = appDel.managedObjectContext!
        //var request = NSFetchRequest(entityName: "Basket")
        
        let result2: NSArray = try! context2.executeFetchRequest(request)
        if (result2.count > 0) {
            for res in result2 {
                
                let price = res.valueForKey("price")! as! Double
                let count = res.valueForKey("count")! as! Int
                
                sumMoneyD = sumMoneyD+price * Double(count)
                
            }
        }
        
        linkTableView?.sumMoney.text = "   Итого " + sumMoneyD.description
        
        if (self.course.count == 0){
            //self.removeFromSuperview()
            
            //linkTableView?.reloadInputViews()
            //linkTableView?.viewDidLoad()
            
            //linkTableView?.tableView(linkTableView?.courseTableView, UITableViewCellEditingStyle.Delete, indexPathV!)
            //indexPathV = ddfdfdf?.basketList[indexPath.row]
            
            linkTableView?.tableView(linkTableView!.courseTableView, commitEditingStyle: UITableViewCellEditingStyle.Delete, forRowAtIndexPath: indexPathV!)
            
            
            
            
        }
        
        //-------------------------------------
    }
    
    
    //Vit
    func setAmountLabelText(){
        switch self.course.count {
        case 0:
            self.amountLabel.text = self.course.price.description
        case 1:
            self.amountLabel.text = self.course.price.description
        default:
            self.amountLabel.text = (self.course.price*Double(self.course.count)).description
        }
    
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
        //self.counterStepper.wraps = true   -- Закомментил Vit когда 0 и жмем минус - не надо максимальное число   -- и наоборот  -- на форме wrap тоже снять
        self.counterStepper.autorepeat = true
        self.counterStepper.maximumValue = 100
        self.counterStepper.value = Double(self.course.count)
        self.countLabel.text = self.course.count.description
        self.amountLabel.text = course.price.description   //Vit
        //Vit
//        switch self.course.count {
//        case 0:
//            self.amountLabel.text = self.course.price.description
//        case 1:
//            self.amountLabel.text = self.course.price.description
//        default:
//            self.amountLabel.text = (self.course.price*Double(self.course.count)).description
//        }
        
        //Vit
        setAmountLabelText()
        
    /*    if self.course.pictureGUID != "none" {
            var urlStr: String = "http://back.lexplate.ru/Handlers/Content.ashx?Type=2&Id=" + self.course.pictureGUID
            var url = NSURL(string: urlStr)
            var imageData: NSData = NSData(contentsOfURL: url!)!
            var img = UIImage(data: imageData)
            pictureImageView.image = img
        }*/
        self.titleLabel.text = self.course.title
    }

}
