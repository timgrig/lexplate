//
//  CategoryCourseViewController.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 28.05.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import CoreData

class CategoryCourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    @IBOutlet weak var basketView: UIView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var basketLabel: UILabel!
    var basketCount : Int = 0
    
    //Категория блюд
//    @IBOutlet weak var searchSView: UIView!    
//    @IBOutlet weak var searchSViewS1: UIView!
//    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var searchSView: UIView!
    @IBOutlet weak var searchSViewS1: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    var navtitleView:UIView?
    @IBAction func basketButtonS(sender: UIButton) {
        //self.navigationItem.titleView = self.lexplateSearchController.searchBar
        UIView.animateWithDuration(0.4, animations: {
            self.searchSViewS1.alpha = 1
            self.titleLabel.alpha=0
//            self.lexplateSearchController.searchBar.becomeFirstResponder()
//            self.lexplateSearchController.searchBar.resignFirstResponder()
//            self.lexplateSearchController.searchBar.window?.makeKeyAndVisible()
//            self.lexplateSearchController.searchBar
//            self.lexplateSearchController.searchBar.placeholder = "Search for info"
//            self.lexplateSearchController.active = true
            
        })
    }
    
    @IBOutlet weak var categoryCourseTableView: UITableView!
    var categoryCourseList = [CategoryCourse] ()
    
    @IBOutlet weak var serchTView: UIView!
    var lexplateSearchController = LexplateSearchController(searchViewController: nil)
    //var lexplateSearchController : LexplateSearchController!
    
    //var lexplateSearchController : LexplateSearchController
    //var l = LexplateSearchController(searchViewController: )
    var searchCategoryCourseList = [CategoryCourse] ()
    
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
            performSegueWithIdentifier("USegaToRestFromCategoryCourse", sender: nil)
        }
    }
    func OkActionFunc(alertAction: UIAlertAction!) -> Void
    {
        performSegueWithIdentifier("USegaToRestFromCategoryCourse", sender: nil)
    }
    //----------------------------------------------------------------------
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Возврат в рестораны с заданием вопроса &&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--------
        self.viewBasketNew.backgroundColor = UIColor.blue31
        self.buttonBasketNew.tintColor = UIColor.lightGrayColor()
        self.labelBasketNew.layer.cornerRadius = self.basketLabel.frame.size.height / 2.0
        self.labelBasketNew.layer.masksToBounds = true
        self.labelBasketNew.backgroundColor = UIColor.orangeColor()
        
        self.viewRest.backgroundColor = UIColor.blue31
        //--------
        //self.lexplateSearchController = LexplateSearchController(searchViewController: self)
        //categoryCourseList.append(CategoryCourse(id: 1, title: "qwerqwer"))
        //categoryCourseList.append(CategoryCourse(id: 2, title: "asdfasdf"))
        // Do any additional setup after loading the view.
        
        
        //self.tabBarController?.tabBar.hidden = false
        
        
        //self.navigationController?.navigationBar.translucent = false
        
        categoryCourseTableView.showsHorizontalScrollIndicator = false
        categoryCourseTableView.showsVerticalScrollIndicator = false
        
        //self.basketButton.tintColor = UIColor.darkGrayColor()
        //self.basketButton.tintColor = UIColor.lightGrayColor()
        self.basketView.backgroundColor = UIColor.blue11
        self.basketButton.tintColor = UIColor.lightGrayColor()
        self.basketLabel.layer.cornerRadius = self.basketLabel.frame.size.height / 2.0
        self.basketLabel.layer.masksToBounds = true
        self.basketLabel.backgroundColor = UIColor.orangeColor()
        
        
        
        configureSearchBar()
        self.definesPresentationContext = true // Когда ставим курсов на поиск - то менялся цвет надписей вверху - чтобы не было - эта строка кода
        self.navtitleView = self.navigationItem.titleView
        
        self.searchSView.backgroundColor = UIColor.blue11
        self.searchSViewS1.backgroundColor = UIColor.blue11
        
        self.searchSViewS1.alpha = 0
        self.titleLabel.alpha=1
        self.titleLabel.textColor = UIColor.whiteColor()
        
//        let recognizerTapCourse = UITapGestureRecognizer(target: self, action: "handleTapCourse:")
//        self.lexplateSearchController.searchBar.addGestureRecognizer(recognizerTapCourse)
//        self.lexplateSearchController.searchBar.userInteractionEnabled = true
//        self.searchSViewS1.addGestureRecognizer(recognizerTapCourse)
//        self.searchSViewS1.userInteractionEnabled = true

        
        //self.lexplateSearchController.searchBar.resignFirstResponder()
        //self.lexplateSearchController.searchBar.window?.makeKeyAndVisible()
    }
    
    override func viewDidAppear(animated: Bool) {
        //print("wsx")
        //self.lexplateSearchController.searchBar.resignFirstResponder()
        super.viewDidAppear(animated)
        
        self.lexplateSearchController.searchBar.sizeToFit()
        //self.lexplateSearchController.searchBar.becomeFirstResponder()
        
        
    }
    
    
    func configureSearchBar() {
        //print("qwerty1")
        
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
        //--------

        self.lexplateSearchController.searchBar.backgroundColor = UIColor.blue11
        self.lexplateSearchController.searchBar.layer.backgroundColor = UIColor.blue11.CGColor //UIColor.orangeColor().CGColor // UIColor.blue11.CGColor
        self.lexplateSearchController.searchBar.layer.borderWidth = 1
        self.lexplateSearchController.searchBar.layer.borderColor = UIColor.blue11.CGColor
        self.lexplateSearchController.searchBar.layer.shadowColor = UIColor.blue11.CGColor
        
        self.searchSViewS1.addSubview(self.lexplateSearchController.searchBar)
        
        //serchTView.addSubview(self.lexplateSearchController.searchBar)
        

    }
    
    // --- UISearchResultsUpdating !!!!!!!!!!
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        //print("updateSearchResultsForSearchController")
        self.searchCategoryCourseList.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //let array = (self.kindMenuList as NSArray).filteredArrayUsingPredicate(searchPredicate)
        let array = self.categoryCourseList.filter { searchPredicate.evaluateWithObject($0.title) }
        //let array = self.kindMenuList.filteredArrayUsingPredicate(searchPredicate)
        //self.searchKindMenuList = array as! [KindMenu]
        self.searchCategoryCourseList = array
        if (searchController.searchBar.text == nil)||(searchController.searchBar.text! == ""){
            self.searchCategoryCourseList = self.categoryCourseList
        }
        self.categoryCourseTableView.reloadData()
    }
    
    
    //Вот этот функционал - коммент выше
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //print("searchBar(searchBar: UISearchBar, textDidChange searchText")
        //print("qaz1")
        if(!searchBar.text!.isEmpty)
        {
            self.lexplateSearchController.active=true
        }
        else
        {
            self.lexplateSearchController.active=false
//            UIView.animateWithDuration(0.4, animations: {
//                //self.navigationItem.titleView = self.navtitleView
//            })
        }
    }
    
//    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
//        print("gkmyhkmbkh")
//        return true
//    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //print("searchBarSearchButtonClicked")
        //print("qa1")
        searchBar.resignFirstResponder()
    }
        
//    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
//        print ("bggbgdb")
//        return true
//    }
    
//    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        print("fbfbfg")
//    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //print("scrollViewDidScroll")
        //if (self.lexplateSearchController.searchBar.isFirstResponder()){
            //print("162")
            self.lexplateSearchController.searchBar.resignFirstResponder()
        //}
        
        UIView.animateWithDuration(0.4, animations: {
            self.searchSViewS1.alpha = 0
            self.titleLabel.alpha=1
        })
        //print(self.lexplateSearchController.searchBar.frame.size.height.description)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.basketLabel.alpha = 0
        
        //self.tabBarController?.tabBar.hidden = false
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        let result: NSArray = try! context.executeFetchRequest(request)
        
        //для инфы сверху в корзине
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return categoryCourseList.count
        
        if(self.lexplateSearchController.active)
        {
            return searchCategoryCourseList.count
        }
        else
        {
            return categoryCourseList.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCourseCell", forIndexPath: indexPath) as! CategoryCourseTableViewCell
        
        
//        let cCourse = categoryCourseList[indexPath.row]
//        cell.setCell(cCourse.title)
        
        if(self.lexplateSearchController.active){
            let cCourse = searchCategoryCourseList[indexPath.row]
            cell.setCell(cCourse.title)
            
        }
        else
        {
            let cCourse = categoryCourseList[indexPath.row]
            cell.setCell(cCourse.title)
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let _ = sender as? CategoryCourseTableViewCell { //  Vit 21.07.2015 Без этой строки если нажали на корзину - то обрабатывалось как нажатие на элемент меню - ошибка
            if let index = categoryCourseTableView.indexPathForSelectedRow {
                let courseViewController = segue.destinationViewController as! CourseViewController
                courseViewController.courseList = categoryCourseList[index.row].courseList as [(Course)]
                courseViewController.title = categoryCourseList[index.row].title //Vit 21.07.15 при переходе на след окно отображать название ячейки пред окна
            }
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "" //"Назад"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        self.definesPresentationContext = false
    }
    
//    var i : Int = 0
//    func handleTapCourse(recognizer: UISwipeGestureRecognizer)
//    {
//        i = i + 1
//        print("tap" + i.description)
//        print(self.lexplateSearchController.searchBar.frame.size.height.description)
//        print(self.searchSViewS1.frame.size.height.description)
//    }

    
    

}
