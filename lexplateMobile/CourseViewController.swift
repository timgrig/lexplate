//
//  CourseViewController.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 28.05.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import CoreData

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    

    //@IBOutlet weak var basketButton: UIBarButtonItem!
    
    @IBOutlet weak var basketView: UIView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var basketLabel: UILabel!
    var basketCount : Int = 0
    
    //Блюда
    @IBOutlet weak var searchSView: UIView!
    @IBOutlet weak var searchSViewS1: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var navtitleView:UIView?
    @IBAction func basketButtonS(sender: UIButton) {
        //self.navigationItem.titleView = self.lexplateSearchController.searchBar
        UIView.animateWithDuration(0.4, animations: {
            self.searchSViewS1.alpha = 1
            self.titleLabel.alpha=0
        })
    }
    
    //self.bo1.layer.cornerRadius = self.bo1.frame.size.height / 2.0
    //self.bo1.layer.masksToBounds = true
    
    @IBOutlet weak var courseTableView: UITableView!
    var courseList = [Course]()
    
    
    
    @IBOutlet weak var serchTView: UIView!
    var lexplateSearchController = LexplateSearchController(searchViewController: nil)
    var searchCourseList = [Course] ()
    
    @IBOutlet weak var viewBasketNew: UIView!
    @IBOutlet weak var buttonBasketNew: UIButton!
    @IBOutlet weak var labelBasketNew: UILabel!
    
    
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Возврат в рестораны с заданием вопроса &&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //----------------------------------------------------------------------
    @IBOutlet weak var viewRest: UIView!
    @IBOutlet weak var ButtonRest: UIButton!
    
    @IBAction func buttonRestS(sender: UIButton) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        let result: NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0)
        {
            let alert = UIAlertController(title: "Назад к выбору ресторана", message: "В корзине имеются выбранные товары! Очистить корзину и вернуться к выбору ресторана?", preferredStyle: UIAlertControllerStyle.Alert)
            let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: OkActionFunc)
            let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(OkAction)
            alert.addAction(CancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("USegaToRestFromCourse", sender: nil)
        }
    }
    func OkActionFunc(alertAction: UIAlertAction!) -> Void
    {
        performSegueWithIdentifier("USegaToRestFromCourse", sender: nil)
    }
    //----------------------------------------------------------------------
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Возврат в рестораны с заданием вопроса &&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //courseList.append(Course(id: 1, title: "водичка", pictureGUID: "none", price: 99.50))
        //courseList.append(Course(id: 2, title: "чаек", pictureGUID: "none", price: 149.50))
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.hidden = false
        
        courseTableView.showsHorizontalScrollIndicator = false
        courseTableView.showsVerticalScrollIndicator = false
        
        //self.basketButton.tintColor = UIColor.darkGrayColor()
        //self.basketButton.tintColor = UIColor.lightGrayColor()
        self.basketView.backgroundColor = UIColor.blue11
        self.basketButton.tintColor = UIColor.lightGrayColor()
        self.basketLabel.layer.cornerRadius = self.basketLabel.frame.size.height / 2.0
        self.basketLabel.layer.masksToBounds = true
        self.basketLabel.backgroundColor = UIColor.orangeColor()
        
        
        //--------
        self.viewBasketNew.backgroundColor = UIColor.blue31
        self.buttonBasketNew.tintColor = UIColor.lightGrayColor()
        self.labelBasketNew.layer.cornerRadius = self.basketLabel.frame.size.height / 2.0
        self.labelBasketNew.layer.masksToBounds = true
        self.labelBasketNew.backgroundColor = UIColor.orangeColor()
    
        self.viewRest.backgroundColor = UIColor.blue31
        //--------
        
        configureSearchBar()
        self.definesPresentationContext = true // Когда ставим курсов на поиск - то менялся цвет надписей вверху - чтобы не было - эта строка кода
        self.navtitleView = self.navigationItem.titleView
        
        self.searchSView.backgroundColor = UIColor.blue11
        self.searchSViewS1.backgroundColor = UIColor.blue11
        
        self.searchSViewS1.alpha = 0
        self.titleLabel.alpha=1
        self.titleLabel.textColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.lexplateSearchController.searchBar.sizeToFit()
    }
    
    func configureSearchBar() {
        
        self.lexplateSearchController.searchResultsUpdater = self
        
        self.lexplateSearchController.hidesNavigationBarDuringPresentation = false
        
        self.lexplateSearchController.delegate = self
        self.lexplateSearchController.searchBar.delegate = self
        
        
        //self.lexplateSearchController.definesPresentationContext = true
        self.lexplateSearchController.dimsBackgroundDuringPresentation = false
        
        //self.lexplateSearchController.searchBar.sizeToFit()
        self.lexplateSearchController.searchBar.barTintColor = UIColor.blue11
        self.lexplateSearchController.searchBar.tintColor = UIColor.whiteColor()
        self.lexplateSearchController.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //self.lexplateSearchController.navigationController.
        //        self.v1.alpha = 1
        self.lexplateSearchController.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        //self.serchTView.addSubview(self.lexplateSearchController.searchBar)
        //-----
        self.lexplateSearchController.searchBar.backgroundColor = UIColor.blue11
        self.lexplateSearchController.searchBar.layer.backgroundColor = UIColor.blue11.CGColor
        self.lexplateSearchController.searchBar.layer.borderWidth = 1
        self.lexplateSearchController.searchBar.layer.borderColor = UIColor.blue11.CGColor
        self.lexplateSearchController.searchBar.layer.shadowColor = UIColor.blue11.CGColor
        
        self.searchSViewS1.addSubview(self.lexplateSearchController.searchBar)
    }
    

    
    // --- UISearchResultsUpdating !!!!!!!!!!
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.searchCourseList.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //let array = (self.kindMenuList as NSArray).filteredArrayUsingPredicate(searchPredicate)
        let array = self.courseList.filter { searchPredicate.evaluateWithObject($0.title) }
        //let array = self.kindMenuList.filteredArrayUsingPredicate(searchPredicate)
        //self.searchKindMenuList = array as! [KindMenu]
        self.searchCourseList = array
        if (searchController.searchBar.text == nil)||(searchController.searchBar.text! == ""){
            self.searchCourseList = self.courseList
        }
        self.courseTableView.reloadData()
    }
    
    //Вот этот функционал - коммент выше
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //print("qaz1")
        if(!searchBar.text!.isEmpty)
        {
            self.lexplateSearchController.active=true
        }
        else
        {
            self.lexplateSearchController.active=false
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //print("qa1")
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //if (self.lexplateSearchController.searchBar.isFirstResponder()){
            //print("162")
            self.lexplateSearchController.searchBar.resignFirstResponder()
       //}
        UIView.animateWithDuration(0.4, animations: {
            self.searchSViewS1.alpha = 0
            self.titleLabel.alpha=1
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return courseList.count
        
        if(self.lexplateSearchController.active)
        {
            return searchCourseList.count
        }
        else
        {
            return courseList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
        
        
//        let course = courseList[indexPath.row]
//        cell.setCell(course)
//        cell.counterStepper.value = Double(courseList[indexPath.row].count)
        
        if(self.lexplateSearchController.active){
            let course = searchCourseList[indexPath.row]
            cell.setCell(course)
            cell.counterStepper.value = Double(searchCourseList[indexPath.row].count)
        }
        else
        {
            let course = courseList[indexPath.row]
            cell.setCell(course)
            cell.counterStepper.value = Double(courseList[indexPath.row].count)
        }
        
        
        
        cell.linkTableView = self
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let deselectedCell = tableView.cellForRowAtIndexPath(indexPath)!
//        deselectedCell.backgroundColor = UIColor.clearColor()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.basketLabel.alpha = 0
        
        //println("\(courseList.count)")
        var i = 0
        //Vit 20.07.2015 когда в корзине обнулили - то и здесь тоже должен быть ноль
        while (i < courseList.count) {
            courseList[i].count = 0
            i += 1
        }
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        let result: NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0) {
            //var i = 0
            i = 0
            while (i < courseList.count) {
                
//                //Vit 20.07.2015 когда в корзине обнулили - то и здесь тоже должен быть ноль
//                courseList[i].count = 0
                
                for res in result {
                    let resId = res.valueForKey("id") as! Int
                    if (courseList[i].id == resId) {
                        courseList[i].count = res.valueForKey("count") as! Int
                        //println("\(courseList[i].count)")
                    }
                }
                i += 1
            }
            //self.courseTableView.reloadData()
        }
        self.courseTableView.reloadData()
        
        self.tabBarController?.tabBar.hidden = false
        
        //для инфы сверху в корзине
        //var countB : Int = 0
        self.basketCount = 0
        for res in result {
            if let _ = (res.valueForKey("count") as? Int) {
                self.basketCount = self.basketCount + 1 //(res.valueForKey("count") as! Int)
            }
        }
        
        self.labelBasketNew.text = self.basketCount.description
        if (self.basketCount == 0){
            //UIView.animateWithDuration(0.4, animations: {
            self.labelBasketNew.alpha = 0
            //})
        } else {
            //UIView.animateWithDuration(0.4, animations: {
            self.labelBasketNew.alpha = 1
            //})
        }
//        self.basketLabel.alpha = 0
//        UIView.animateWithDuration(0.4, animations: {
//            self.tabBarController?.setBadges(self.basketCount)
//        })
 
        
        //Конец для инфы сверху в корзине
        self.definesPresentationContext = true
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


