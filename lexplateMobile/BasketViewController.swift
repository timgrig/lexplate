//
//  BasketViewController.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 28.05.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import CoreData

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //--Vit 20.07.15
    @IBOutlet weak var sumMoney: UILabel!
    var sumMoneyD: Double = 0.0
    //--Vit 20.07.15
    
    @IBOutlet weak var courseTableView: UITableView!
    var basketList = [Course]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //--Vit 20.07.15
        
        //Уберем лишние полоски!  VIT пока не работает
        //courseTableView.tableFooterView = UIView()
        

        
    }
    
    func loadAgain(){
        //print("loadAgain")
        self.basketList.removeAll(keepCapacity: false)
        //print("loadAgain" + self.basketList.count.description)
        self.sumMoneyD = 0
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        let result: NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0) {
            for res in result {
                let id = res.valueForKey("id")! as! Int
                let title = res.valueForKey("title")! as! String
                let foodMenuId = res.valueForKey("foodMenuId")! as! Int
                let price = res.valueForKey("price")! as! Double
                let count = res.valueForKey("count")! as! Int
                let course = Course(id: id, title: title, foodMenuId: foodMenuId, price: price, count: count)
                
                //--Vit 20.07.15
                sumMoneyD = sumMoneyD+price * Double(count)
                //--Vit 20.07.15
                
                basketList.append(course)
                
                //self.courseTableView.reloadData()
            }
        }
        
        //--Vit 20.07.15
        sumMoney.text = "   Итого " + sumMoneyD.description
        self.courseTableView.reloadData()
        //self.tabBarController?.tabBar.hidden = true
        ////self.tabBarController?.tabBar.frame.s
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadAgain()
        
        


        
        //self.tabBarController?.tabBar.hidden = true
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasketCell", forIndexPath: indexPath) as! BasketTableViewCell
        let course = basketList[indexPath.row]
        cell.setCell(course)
        
        //--Vit 20.07.15
        cell.linkTableView = self
        cell.indexPathV = indexPath
        //--Vit 20.07.15
        
        return cell
    }
    
    //--Vit 20.07.15
    func tableView(tableView: UITableView, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            courseTableView.beginUpdates()
            basketList.removeAtIndex(indexPath.row)
            
            courseTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            courseTableView.endUpdates()
            self.courseTableView.reloadData()
            
            UIView.animateWithDuration(0.4, animations: {
                self.tabBarController?.setBadges(self.basketList.count)
            })
            
            
            //            basketList.removeAtIndex(indexPath.row) //langData is array from i delete values
            //            courseTableView.deleteRowsAtIndexPaths([indexPath],  withRowAnimation: .Fade)
            
            
        }
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
