//
//  KindMenuViewController.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 27.05.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class KindMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating,  UIPopoverPresentationControllerDelegate, UIActionSheetDelegate
//UITabBarControllerDelegate
{
    
    @IBOutlet weak var basketView: UIView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var basketLabel: UILabel!
    var basketCount : Int = 0
    
    var navtitleView:UIView?
    var navtitleView1:UIView?
    var navtitleView2:UIView?
    
    @IBAction func basketButtonS(sender: UIButton) {
        UIView.animateWithDuration(0.4, animations: {
            //self.navigationItem.titleView = self.lexplateSearchController.searchBar
            //            self.navtitleView1?.alpha = 0
            //            self.navtitleView2?.alpha = 1
            self.searchSViewS1.alpha = 1
            self.titleLabel.alpha=0
        })
    }
    
    @IBOutlet weak var kindMenuTableView: UITableView!
    var kindMenuList = [KindMenu]()
    
    var informationList = [Information]()
    // var categoryCourseList = [CategoryCourse]()
    // var courseList = [Course]()
    var dBase: String = ""
    
    
    var OrganizationInf : Organization?
    //var OrganizationVC
    
    @IBOutlet weak var searchSView: UIView!
    @IBOutlet weak var searchSViewS1: UIView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serchTView: UIView!
    
    
    var lexplateSearchController = LexplateSearchController(searchViewController: nil)
    //var lexplateSearchController = UISearchController(searchResultsController: nil)
    var searchKindMenuList = [KindMenu]()
    
    //let labelBasketNew = UILabel()
    
    @IBOutlet weak var labelBasketNew: UILabel!
    @IBOutlet weak var buttonBasketNew: UIButton!    
    @IBOutlet weak var viewBasketNew: UIView!
    
    
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Возврат в рестораны с заданием вопроса &&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //----------------------------------------------------------------------
    @IBOutlet weak var viewRest: UIView!
    @IBOutlet weak var ButtonRest: UIButton!
    
    
    //Кнопка внизу
    @IBAction func buttonRestS(sender: UIButton) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        let result: NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0)
        {
            let alert = UIAlertController(title: "Назад к выбору ресторана", message: "В корзине имеются выбранные товары! Очистить корзину и вернуться к выбору ресторана?", preferredStyle: UIAlertControllerStyle.Alert)
            let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: OkActionFuncR)
            let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(OkAction)
            alert.addAction(CancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("USegaToRestFromKindMenu", sender: nil)
        }
    }
    func OkActionFuncR(alertAction: UIAlertAction!) -> Void
    {
        performSegueWithIdentifier("USegaToRestFromKindMenu", sender: nil)
    }
    
    //Событие назад именно из этого окна - в других двух нет этого
    //Переопределение метода нажатия назад - этого метода в swift нет в отличие от objective c - поэтому добавлен код в файл forExtensions где классы дополнены недостающими методами
    override func navigationShouldPopOnBackButton() -> Bool {
        var Ret : Bool = false
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        let result: NSArray = try! context.executeFetchRequest(request)
        if (result.count > 0)
        {
            let alert = UIAlertController(title: "Назад к выбору ресторана", message: "В корзине имеются выбранные товары! Очистить корзину и вернуться к выбору ресторана?", preferredStyle: UIAlertControllerStyle.Alert)
            let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: OkActionFuncR2)
            let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(OkAction)
            alert.addAction(CancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            Ret = true
        }
        return Ret
    }
    func OkActionFuncR2(alertAction: UIAlertAction!) -> Void
    {
//        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController?.popViewControllerAnimated(true)
    }
    //----------------------------------------------------------------------
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Возврат в рестораны с заданием вопроса &&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        navigationController?.setToolbarHidden(false, animated: true)

        
     
        
        //self.kindMenuList.append(KindMenu(id: 1, title: "asdf"))
        //self.kindMenuList.append(KindMenu(id: 2, title: "zxcv"))
        
        self.kindMenuTableView.addSubview(self.refreshControl)
        
        //        var link: String = "http://192.168.0.2:55777/LexplateService.svc/GetMenu/" + self.dBase
        //        Alamofire.request(.GET,link).responseJSON { (_,_,json,_) in
        //            if let result:AnyObject = json {
        //                var resDictionary = result as! NSDictionary
        //                var resArray: NSArray = resDictionary["GetMenuResult"] as! NSArray
        //                self.kindMenuList = self.kindMenuCalc(0, kmArray: resArray)
        //                self.kindMenuTableView.reloadData()
        //            } else {
        //                println("KindMenu: ошибка подключения")
        //            }
        //        }
        self.refresh()
        
        
        
//        self.tabBarController?.tabBar.hidden = false
//        self.tabBarController?.delegate = self
        //        println("dfgbgbgbgbg")
        
        //        nav.ititle.text = OrganizationInf?.title
        //        nav.idescription.text = OrganizationInf?.description
        //        nav.iAddress.text = OrganizationInf?.address
        //        nav.iaverageCheck.text = OrganizationInf?.averageCheck
        //        nav.iaverageTime.text = OrganizationInf?.averageTime
        //        nav.iimage.image = OrganizationInf?.ris
        
        kindMenuTableView.showsHorizontalScrollIndicator = false
        kindMenuTableView.showsVerticalScrollIndicator = false
        
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
        
        //        let recognizerTapCourse = UITapGestureRecognizer(target: self, action: "handleTapCourse:")
        ////        self.lexplateSearchController.searchBar.addGestureRecognizer(recognizerTapCourse)
        ////        self.lexplateSearchController.searchBar.userInteractionEnabled = true
        //                self.searchSViewS1.addGestureRecognizer(recognizerTapCourse)
        //                self.searchSViewS1.userInteractionEnabled = true
        
        
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
        
        self.lexplateSearchController.searchBar.backgroundColor = UIColor.blue11
        self.lexplateSearchController.searchBar.layer.backgroundColor = UIColor.blue11.CGColor
        self.lexplateSearchController.searchBar.layer.borderWidth = 1
        self.lexplateSearchController.searchBar.layer.borderColor = UIColor.blue11.CGColor
        self.lexplateSearchController.searchBar.layer.shadowColor = UIColor.blue11.CGColor
        
        self.searchSViewS1.addSubview(self.lexplateSearchController.searchBar)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.lexplateSearchController.searchBar.sizeToFit()
        
        
    }
    
    // --- UISearchResultsUpdating !!!!!!!!!!
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.searchKindMenuList.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //let array = (self.kindMenuList as NSArray).filteredArrayUsingPredicate(searchPredicate)
        let array = self.kindMenuList.filter { searchPredicate.evaluateWithObject($0.title) }
        //let array = self.kindMenuList.filteredArrayUsingPredicate(searchPredicate)
        //self.searchKindMenuList = array as! [KindMenu]
        self.searchKindMenuList = array
        if (searchController.searchBar.text == nil)||(searchController.searchBar.text! == ""){
            self.searchKindMenuList = self.kindMenuList
        }
        self.kindMenuTableView.reloadData()
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
            //UIView.animateWithDuration(0.4, animations: {
            //    self.navigationItem.titleView = self.navtitleView
            //})
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //print("qa1")
        searchBar.resignFirstResponder()
    }
    
    //    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
    //        print("gkmyhkmbkh")
    //        return true
    //    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //if (self.lexplateSearchController.searchBar.isFirstResponder()){
        //print("162")
        self.lexplateSearchController.searchBar.resignFirstResponder()
        //            UIView.animateWithDuration(0.4, animations: {
        //            self.navigationItem.titleView = self.navtitleView
        //            })
        
        UIView.animateWithDuration(0.4, animations: {
            self.searchSViewS1.alpha = 0
            self.titleLabel.alpha=1
        })
        //}
        //        print(self.searchSViewS1.frame.size.height.description)
        //        print(self.lexplateSearchController.searchBar.frame.size.height.description)
    }
    
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Загрузка с колесиком Spinner &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //----------------------------------------------------------------------
    //Колесико Spinner
    //    var refreshControl:UIRefreshControl!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(KindMenuViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
        }()
    var countLoad: Int = 0
    var priznakLoad: Bool = false
    var flagEnterZapros:Int = 1
    
    //----------------------------------------------------------------------
    func refreshTableKind()
    {
        //println("func refreshTableOrganization()")
        _ = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: #selector(KindMenuViewController.myMetod1(_:)), userInfo: nil, repeats: true)
    }
    
    func OkActionFunc(alertAction: UIAlertAction!) -> Void
    {
    }
    
    func refresh (){
        
        refreshControl.beginRefreshing()
        handleRefresh(refreshControl)
        
    }
    
    var countCallRefresh: Int = 0
    var flagEnterRefresh: Bool = false
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        countCallRefresh += 1
        //println("Вызван refresh organization "+self.countCallRefresh.description)
        
        
        if (self.priznakLoad == false)&&(self.kindMenuList.count<1)&&(self.flagEnterRefresh == false) {
            self.flagEnterRefresh = true
            
            dispatch_async(dispatch_get_main_queue()) {()-> Void in
                //---------------------------------------------------------------------------------------------------------------
                self.refreshTableKind()
                //var  timer1 = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: Selector("refreshTableOrganization:"), userInfo: nil, repeats: true)
                //---------------------------------------------------------------------------------------------------------------
            }
        }
        
        if (self.priznakLoad == true)||(self.kindMenuList.count>0) {
            refreshControl.endRefreshing()
        }
        //self.organizationTableView.reloadData()
        //refreshControl.endRefreshing()
    }
    
    
    func myMetod1(timer: NSTimer){
        //println("вошли")
        
        if (self.flagEnterZapros == 3){
            self.flagEnterZapros = 1
        }
        
        //if (countLoad == 0){
        //println("увеличили")
        // Только один раз надо увеличить
        timer.fireDate = timer.fireDate.dateByAddingTimeInterval(2)
        //}
        
        
        //====================================================================
        countLoad += 1

        if (self.flagEnterZapros == 1) {
            self.flagEnterZapros = 2
            let link: String = "http://mobile.lexplate.ru/lexplateservice.svc/GetMenu/" + self.dBase
            
            Alamofire.request(.GET,link).responseJSON { response in
                if let resDictionary = response.result.value as? NSDictionary {
                    let resArray = resDictionary["GetMenuResult"] as! NSArray
                    self.flagEnterZapros = 3
                    timer.invalidate()
                    self.priznakLoad = true
                    self.kindMenuList = self.kindMenuCalc(0, kmArray: resArray)
                    self.kindMenuTableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.flagEnterRefresh = false
                    self.countLoad = 0
                }
            }
        }
        //====================================================================
        
        
        //if (countLoad>10)&&(self.organizationList.count<1){
        if (countLoad>10){
            
            //Показать сообщение
            
            //Без кнопок на 2 сек
            //            let alertController = UIAlertController(title: "Ошибка подключения!", message: nil, preferredStyle: .Alert)
            //            self.presentViewController(alertController, animated: true, completion: nil)
            //            let delay = 2.0 * Double(NSEC_PER_SEC)
            //            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            //            dispatch_after(time, dispatch_get_main_queue(), {
            //                alertController.dismissViewControllerAnimated(true, completion: nil)
            //            })
            // С кнопкой ОК пока не нажмет
            let alert = UIAlertController(title: "Ошибка подключения!", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: OkActionFunc)
            alert.addAction(OkAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            print("Ошибка подключения")
            countLoad = 0
            refreshControl.endRefreshing()
            self.flagEnterRefresh = false
            timer.invalidate()
            
        }
    }
    

    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Конец Загрузка с колесиком Spinner &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    //var SearchYN : Bool = false
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setToolbarHidden(true, animated: true)
        //print("3")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        super.viewWillAppear(animated)
        self.basketLabel.alpha = 0
        
        
        //Нужно было когда был TabBar
        //self.tabBarController?.tabBar.hidden = true

        
        
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
        
        //navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    private func kindMenuCalc(i: Int, kmArray: NSArray) -> [(KindMenu)] {
        var resultArray = [KindMenu]()
        if (i < kmArray.count) {
            if let id: Int = kmArray[i]["Id"] as? Int {
                
                //if let found = lazy(self.kindMenuList).map({ $0.id }).indexOf(id) {
                if let _ = self.kindMenuList.indexOf({$0.id == id}) {
                    // уже есть - не надо
                }
                else {
                    //нет такого элемента - добавляем
                    if let title: String = kmArray[i]["Title"] as? String {
                        if let categoriesCourse:NSArray = kmArray[i]["Categories"] as? NSArray {
                            let categoryList = self.categoryCourseCalc(0, ccArray: categoriesCourse)
                            resultArray = self.kindMenuCalc(i+1, kmArray: kmArray)
                            resultArray.append(KindMenu(id: id, title: title, categoryCourseList: categoryList))
                        }
                    }
                }
                
                
                
            }
            
        }
        return resultArray
    }
    
    private func categoryCourseCalc(i: Int, ccArray: NSArray) -> [(CategoryCourse)] {
        var resultArray = [CategoryCourse]()
        if (i < ccArray.count) {
            let id: Int = ccArray[i]["Id"] as! Int
            let title: String = ccArray[i]["Title"] as! String
            let courses: NSArray = ccArray[i]["Courses"] as! NSArray
            let courseList = courseCalc(0, cArray: courses)
            resultArray = categoryCourseCalc(i+1, ccArray: ccArray)
            resultArray.append(CategoryCourse(id: id, title: title, courses: courseList))
        }
        return resultArray
    }
    
    private func courseCalc(i: Int, cArray: NSArray) -> [(Course)] {
        var resultArray = [Course]()
        if (i < cArray.count) {
            let id: Int = cArray[i]["Id"] as! Int
            let title: String = cArray[i]["Title"] as! String
            let price: Double = cArray[i]["Price"] as! Double
            let foodMenuId: Int = cArray[i]["FoodMenuId"] as! Int
            //cList.append(Course(id: id, title: title, price: price))
            //self.courseCalc(i+1, cArray: cArray)
            resultArray = self.courseCalc(i+1, cArray: cArray)
            resultArray.append(Course(id: id,  title: title, foodMenuId: foodMenuId, price: price))
        }
        return resultArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return kindMenuList.count
        
        if(self.lexplateSearchController.active)
        {
            return searchKindMenuList.count
        }
        else
        {
            return kindMenuList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCellWithIdentifier("KindMenuCell", forIndexPath: indexPath) as! KindMenuTableViewCell
        //        let kindMenu = kindMenuList[indexPath.row]
        //        cell.setCell(kindMenu.title)
        //        return cell
        let cell = tableView.dequeueReusableCellWithIdentifier("KindMenuCell", forIndexPath: indexPath) as! KindMenuTableViewCell
        
        if(self.lexplateSearchController.active){
            let kindMenu = searchKindMenuList[indexPath.row]
            cell.setCell(kindMenu.title)
            
        }
        else
        {
            let kindMenu = kindMenuList[indexPath.row]
            cell.setCell(kindMenu.title)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        let infoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("InformationStbId") as! InformationViewController
        //        println((infoVC.idescription!.text))
        //println("fgghbhybhyntnthntnhybn")
        
        if let _ = sender as? KindMenuTableViewCell { //  Vit 21.07.2015 Без этой строки если нажали на корзину - то обрабатывалось как нажатие на элемент меню - ошибка
            if let index = kindMenuTableView.indexPathForSelectedRow {
                let categoryCourseViewController = segue.destinationViewController as! CategoryCourseViewController
                categoryCourseViewController.categoryCourseList = kindMenuList[index.row].categoryCourseList as [(CategoryCourse)]
                categoryCourseViewController.title = kindMenuList[index.row].title  //sender as? String Vit 21.07.15 при переходе на след окно отображать название ячейки пред окна
                //categoryCourseViewController.lexplateSearchControllerCat = self.lexplateSearchController
                
                
                
                            }
        }
        
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "" //"Тип меню"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        //self.lexplateSearchController.searchBar.resignFirstResponder()
        self.definesPresentationContext = false
    }
    

    
//    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
//        if let nav = viewController as? InformationViewController {
//            
//            self.definesPresentationContext = false
//            
//            nav.informationList.removeAll(keepCapacity: true)
//            self.informationList.removeAll(keepCapacity: true)
//            
//            self.informationList.append(Information(title: self.OrganizationInf!.title, iimage: self.OrganizationInf!.ris, risPriznak: self.OrganizationInf!.risPriznak))
//            
//            //self.informationList.append(Information(title: self.OrganizationInf!.title))
//            if (self.OrganizationInf!.descriptionPriznak == 1)&&(self.OrganizationInf!.description != "Нет данных")
//            {
//                self.informationList.append(Information(title: self.OrganizationInf!.description))
//            }
//            
//            if (self.OrganizationInf!.addressPriznak == 1)&&(self.OrganizationInf!.address != "Нет данных")
//            {
//                self.informationList.append(Information(title: "Адрес: "+self.OrganizationInf!.address))
//            }
//            
//            if (self.OrganizationInf!.phonePriznak == 1)&&(self.OrganizationInf!.phone != "Нет данных")
//            {
//                self.informationList.append(Information(title: "Телефон: "+self.OrganizationInf!.phone))
//            }
//            
//            if (self.OrganizationInf!.WebSitePriznak == 1)&&(self.OrganizationInf!.WebSite != "Нет данных")
//            {
//                self.informationList.append(Information(title: "Веб сайт: "+self.OrganizationInf!.WebSite))
//            }
//            
//            if (self.OrganizationInf!.averageCheckPriznak == 1)&&(self.OrganizationInf!.averageCheck != "Нет данных")
//            {
//                self.informationList.append(Information(title: "Средний чек: "+self.OrganizationInf!.averageCheck ))
//            }
//            
//            if (self.OrganizationInf!.averageTimePriznak == 1)&&(self.OrganizationInf!.averageTime != "Нет данных")
//            {
//                self.informationList.append(Information(title: "Среднее время приготовления: "+self.OrganizationInf!.averageTime ))
//            }
//            
//            if (self.OrganizationInf!.TimeTable_Mo_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_Mo_EndPriznak == 1)&&(self.OrganizationInf!.TimeTable_Tu_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_Tu_EndPriznak == 1)&&(self.OrganizationInf!.TimeTable_We_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_We_EndPriznak == 1)&&(self.OrganizationInf!.TimeTable_Th_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_Th_EndPriznak == 1)&&(self.OrganizationInf!.TimeTable_Fr_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_Fr_EndPriznak == 1)&&(self.OrganizationInf!.TimeTable_Sa_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_Sa_EndPriznak == 1)&&(self.OrganizationInf!.TimeTable_Su_StartPriznak == 1)&&(self.OrganizationInf!.TimeTable_Su_EndPriznak == 1)
//            {
//                self.informationList.append(Information(title: "Время работы:"))
//                self.informationList.append(Information(title: "Понедельник: "+self.OrganizationInf!.TimeTable_Mo_Start+"-"+self.OrganizationInf!.TimeTable_Mo_End ))
//                self.informationList.append(Information(title: "Вторник: "+self.OrganizationInf!.TimeTable_Tu_Start+"-"+self.OrganizationInf!.TimeTable_Tu_End ))
//                self.informationList.append(Information(title: "Среда: "+self.OrganizationInf!.TimeTable_We_Start+"-"+self.OrganizationInf!.TimeTable_We_End ))
//                self.informationList.append(Information(title: "Четверг: "+self.OrganizationInf!.TimeTable_Th_Start+"-"+self.OrganizationInf!.TimeTable_Th_End ))
//                self.informationList.append(Information(title: "Пятница: "+self.OrganizationInf!.TimeTable_Fr_Start+"-"+self.OrganizationInf!.TimeTable_Fr_End ))
//                self.informationList.append(Information(title: "Суббота: "+self.OrganizationInf!.TimeTable_Sa_Start+"-"+self.OrganizationInf!.TimeTable_Sa_End ))
//                self.informationList.append(Information(title: "Воскресенье: "+self.OrganizationInf!.TimeTable_Su_Start+"-"+self.OrganizationInf!.TimeTable_Su_End ))
//            }
//            
//            
//            
//            //nav.ititle.text = OrganizationInf?.title
//            //            nav.idescription.text = OrganizationInf?.description
//            //            nav.iAddress.text = OrganizationInf?.address
//            //            nav.iaverageCheck.text = OrganizationInf?.averageCheck
//            //            nav.iaverageTime.text = OrganizationInf?.averageTime
//            //nav.iimage.image = OrganizationInf?.ris
//            nav.informationList = self.informationList
//            nav.informationTableView.reloadData()
//            
//        }
//        //print("tt")
//    }
    
    
    //    //Плавная смена окна -- справа налево переезд
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
    
    // Плавное изменение окна - просто изменение
    class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
        
        func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
            let fromView: UIView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            let toView: UIView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            transitionContext.containerView()!.addSubview(fromView)
            transitionContext.containerView()!.addSubview(toView)
            
            UIView.transitionFromView(fromView, toView: toView, duration: transitionDuration(transitionContext), options: UIViewAnimationOptions.TransitionCrossDissolve) { finished in
                transitionContext.completeTransition(true)
            }
        }
        
        func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
            return 0.25
        }
    }
    
//    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return TransitioningObject()
//    }
    

    
//    
//    var countPerehodTabBarCon : Int = 0
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        
//        var gotoViewController : Bool = true
//        
//        //if let _ = viewController as? InformationViewController {
//        if let _ = viewController as? BasketNavigationController {
//            //print("t")
//            countPerehodTabBarCon = 1
//            gotoViewController = true
//            self.definesPresentationContext = false
//        }
//        else {
//            //print("o")
//            countPerehodTabBarCon = countPerehodTabBarCon - 1
//            if (countPerehodTabBarCon < 0 ) {
//                
//                gotoViewController = false
//                self.definesPresentationContext = true
//            }
//        }
//        //        println(countPerehodTabBarCon.description)
//        //        println(viewController.description)
//        
//        return gotoViewController
//    }
    
    //    var i : Int = 0
    //    func handleTapCourse(recognizer: UISwipeGestureRecognizer)
    //    {
    //        i = i + 1
    //        print("tap" + i.description)
    //    }
    
//    func didDismissSearchController(searchController: UISearchController) {
//        print("f1")
//        if (self.lexplateSearchController.active) {
//            self.lexplateSearchController.active = false
//        }
//    }
//    
//        override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
//            print("f2")
//            if (self.lexplateSearchController.active) {
//                self.lexplateSearchController.active = false
//            }
//        }
    
    
}
