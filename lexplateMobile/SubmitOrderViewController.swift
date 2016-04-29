//
//  SubmitOrderView.swift
//  lexplateMobile
//
//  Created by Артем on 14.07.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import Foundation

class SubmitOrderView: UITableViewController, UITextFieldDelegate {
    
    var selectedSegment: Int = 0
    var orderType: Int = 2
    var datePreOrder: String = ""
    var timePreOrder: String = ""
    var strTime: String = ""
    var strDate: String = ""
    var dbName: String = ""
    
    @IBOutlet weak var CellSegment: UITableViewCell!
    
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.CellSegment.frame = CGRect(x: CellSegment.frame.origin.x, y: CellSegment.frame.origin.y, width: CellSegment.frame.size.width, height: 100)
        
//        self.CellSegment.addConstraint(
//            NSLayoutConstraint(
//                item: self.CellSegment,
//                attribute: NSLayoutAttribute.Height,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: nil,
//                attribute: NSLayoutAttribute.NotAnAttribute,
//                multiplier: 1,
//                constant: 100
//            ))
//        
//        println("dfvgdbfgbfbfgbfbfbg")
//        submitOrderTableView.estimatedRowHeight = submitOrderTableView.rowHeight
//        submitOrderTableView.rowHeight = UITableViewAutomaticDimension
//        //self.submitOrderTableView.estimatedRowHeight = CGFloat(44)
//        submitOrderTableView.reloadData()
//        println("priiv")
        
        
////Думал что нужен вертикальный радиобуттон
//        //Высоту в сториборд нельзя задать
//        // Через frame не получатеся сделать высоту поэтому через констрайнт
//        typeSegmentControl.addConstraint(
//            NSLayoutConstraint(
//                item: typeSegmentControl,
//                attribute: NSLayoutAttribute.Height,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: nil,
//                attribute: NSLayoutAttribute.NotAnAttribute,
//                multiplier: 1,
//                constant: 100
//            )
//        )
//        
//        //Перевернем на 90 градусов вправо компонент
//        typeSegmentControl.transform = CGAffineTransformRotate(typeSegmentControl.transform, CGFloat(M_PI / 2.0))
//        //segcont.transform = CGAffineTransformMakeRotation(M_PI / 2.0)
//
//        // Так как содержимое тоже повернулось-содержимое повернем обратно
//        for sv in typeSegmentControl.subviews {
//            for svv in sv.subviews {
//                if let ll = svv as? UILabel {
//                    ll.transform = CGAffineTransformRotate(ll.transform, CGFloat(-M_PI / 2.0))
//                }
//            }
//        }
////  Конец Думал что нужен вертикальный радиобуттон
        
        //Выделим первое значение
        typeSegmentControl.selectedSegmentIndex = 0
        self.viewDost.alpha = 1
        self.viewPred.alpha=0
    }
 
    @IBAction func typeSegmentControlChanged(sender: UISegmentedControl) {
        switch typeSegmentControl.selectedSegmentIndex
        {
        case 0:
            self.selectedSegment = 0
            self.orderType = 2
        case 1:
            self.selectedSegment = 1
            self.orderType = 4
        case 2:
            self.selectedSegment = 2
            self.orderType = 3
        default:
            break; 
        }
        
        if (self.selectedSegment == 0){
            UIView.animateWithDuration(0.4, animations: {
                self.viewDost.alpha = 1
                self.viewPred.alpha=0
                self.submitOrderTableView.reloadData()
            })
        }
        
        if (self.selectedSegment == 1){
            UIView.animateWithDuration(0.2, animations: {
                self.viewDost.alpha = 0
                self.viewPred.alpha=0
                self.submitOrderTableView.reloadData()
            })
        }
        
        if (self.selectedSegment == 2){
            UIView.animateWithDuration(0.4, animations: {
                self.viewDost.alpha = 0
                self.viewPred.alpha=1
                self.submitOrderTableView.reloadData()
            })
        }
        

    }
    
    
    @IBOutlet weak var viewKanva: UIView!
    @IBOutlet weak var viewPred: UIView!
    @IBOutlet weak var viewDost: UIView!
    
    @IBOutlet weak var poleDateTime: UIDatePicker!

    @IBAction func poleDateTimeChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm"
        self.strDate = dateFormatter.stringFromDate(poleDateTime.date)
        self.strTime = timeFormatter.stringFromDate(poleDateTime.date)
    }
    
    @IBOutlet var submitOrderTableView: UITableView!
    
  
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 44
        if (indexPath.section == 1) {
            switch selectedSegment
            {
            case 0:                             //доставка
                height = 310 //380
            case 1:                             //самовывоз
                height = 55 //125
            case 2:                             //предзаказ
                height = 310 //380
            default: 44
            }
        }
        return height
    }
    
    
    @IBOutlet weak var fioTextField: UITextField!{
        didSet {
            fioTextField.delegate = self
        }
    }
    
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet {
            phoneTextField.delegate = self
        }
    }
    
    
    @IBOutlet weak var streetTextField: UITextField!{
        didSet {
            streetTextField.delegate = self
        }
    }
    
    @IBOutlet weak var streetNumberTextField: UITextField!{
        didSet {
            streetNumberTextField.delegate = self
        }
    }

    
    @IBOutlet weak var streetSubNumberTextField: UITextField!{
        didSet {
            streetSubNumberTextField.delegate = self
        }
    }
    
    @IBOutlet weak var flatNumberTextField: UITextField!{
        didSet {
            flatNumberTextField.delegate = self
        }
    }


    @IBOutlet weak var porchNumberTextField: UITextField!{
                didSet {
                    porchNumberTextField.delegate = self
                }
            }
    
    @IBOutlet weak var floorNumberTextField: UITextField!{
                didSet {
                    floorNumberTextField.delegate = self
                }
            }
    
    @IBOutlet weak var additionalCommentsTextField: UITextField!{
        didSet {
            additionalCommentsTextField.delegate = self
        }
    }
    
    var fio: String {
        get {
            return fioTextField.text!
        }
    }
    
    var phone: String {
        get {
            return phoneTextField.text!
        }
    }
    
    var street: String {
        get {
            return streetTextField.text!
        }
    }
    
    var streetNumber: String {
        get {
            return streetNumberTextField.text!
        }
    }
    
    var streetSubNumber: String {
        get {
            return streetSubNumberTextField.text!
        }
    }
    
    var flatNumber: String {
        get {
            return flatNumberTextField.text!
        }
    }
    
    var porchNumber: String {
        get {
            return porchNumberTextField.text!
        }
    }
    
    var floorNumber: String {
        get {
            return floorNumberTextField.text!
        }
    }
    
    var additionalComments: String {
        get {
            return additionalCommentsTextField.text!
        }
    }
    // действие по кнопке "подтвердить"
    @IBAction func confirmTouchDown(sender: UIButton) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let requestDB = NSFetchRequest(entityName: "Dbasen")
        let result: NSArray = try! context.executeFetchRequest(requestDB)
        if (result.count > 0) {
            let res: AnyObject = result[0]
            self.dbName = res.valueForKey("name")! as! String
            let requestBasket = NSFetchRequest(entityName: "Basket")
            var items : [NSDictionary] = []

            let resultBasket: NSArray = try! context.executeFetchRequest(requestBasket)
            if (resultBasket.count > 0) {
                for res in resultBasket {
                    let id = res.valueForKey("id")! as! Int
                    //var title = res.valueForKey("title")! as! String
                    _ = res.valueForKey("title")! as! String
                    let price = res.valueForKey("price")! as! Double
                    let count = res.valueForKey("count")! as! Int
                    let foodMenuID = res.valueForKey("foodMenuId")! as! Int
                    items.append(["CourseId": id, "FoodMenuId": foodMenuID, "Price": price, "Count": count])
                }
            }

            let parameters = ["order": ["DbName":dbName, "Name":self.fio, "Phone": self.phone, "OrderType": self.orderType, "Street": self.street, "House": self.streetNumber, "Housing": self.streetSubNumber, "Apartment": self.flatNumber, "Comment": self.additionalComments, "Items": items]]
           
            Alamofire.request(.POST,"http://mobile.lexplate.ru/LexplateService.svc/AddOrder", parameters: parameters, encoding: .JSON)
        } else {
            print("база данных не определена")
        }
        
        //Сообщение с кнопкой ОК - по нажатию подтверждения оформления заказа
        let alert = UIAlertController(title: "Заказ оформлен", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: OkActionFunc)
        alert.addAction(OkAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func OkActionFunc(alertAction: UIAlertAction!) -> Void
    {
        performSegueWithIdentifier("toStartSegue", sender: nil)
    }
    
   
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let organizationViewController = segue.destinationViewController as? OrganizationViewController {
            organizationViewController.priznakShowAlert = true
        }
    }
    
    
    
//    @IBOutlet weak var additionalCommentsTextArea: UITextView!
   

    
    // Действие по нажатию кнопки return на клавиатуре
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case fioTextField:
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            streetTextField.becomeFirstResponder()
        case streetTextField:
            streetNumberTextField.becomeFirstResponder()
        case streetNumberTextField:
            streetSubNumberTextField.becomeFirstResponder()
        case streetSubNumberTextField:
            flatNumberTextField.becomeFirstResponder()
        case flatNumberTextField:
            porchNumberTextField.becomeFirstResponder()
        case porchNumberTextField:
            floorNumberTextField.becomeFirstResponder()
        case floorNumberTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        //phoneTextField.becomeFirstResponder()
        //println("\(fioTextField.text)")
        return true
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
