//
//  OrganizationViewController.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 27.05.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class OrganizationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
 
{

    
    @IBAction func unwindToRest(segue: UIStoryboardSegue) {
    }
    
    var priznakShowAlert: Bool = false
    
    
    @IBOutlet weak var organizationTableView: UITableView!
    var organizationList = [Organization] ()
    
    //Колесико Spinner
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(OrganizationViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()
    
    var countLoad: Int = 0
    var priznakLoad: Bool = false
    //----------------------------------------------------------------------
    var flagEnterZapros:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.organizationTableView.setNeedsLayout()
        self.organizationTableView.layoutIfNeeded()
        
        self.organizationTableView.addSubview(self.refreshControl)

        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate        //очистка корзины при переходе в список ресторанов
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        //============
        var result : [AnyObject]
        result = [""]
        do {
            let result22 = try context.executeFetchRequest(request)
            result = result22
        } catch let error as NSError {
            // failure
            print("Fetch  failed: \(error.localizedDescription)")
        }
        //====================
        
        if (result.count > 0) {
            for res in result {
                context.deleteObject(res as! NSManagedObject)
            }
        }
        
        //----------------------
        // Добавим наш Entity DBaseName если его нет
        let requestDbasen = NSFetchRequest(entityName: "Dbasen")
        //============
        var resultDbasen : [AnyObject]
        resultDbasen = ["kn"]
        do {
            resultDbasen = try context.executeFetchRequest(requestDbasen)
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        //====================
        
        if (resultDbasen.count == 0) {
            _ = NSEntityDescription.insertNewObjectForEntityForName("Dbasen", inManagedObjectContext: context)
            do {
                try context.save()
            } catch _ {
            }
        }
        //----------------------
        self.refresh()
        self.tabBarController?.tabBar.hidden = true
    }

    func refreshTableOrganization()
    {
        _ = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: #selector(OrganizationViewController.myMetod1(_:)), userInfo: nil, repeats: true)
    }
    
    func myMetod1(timer: NSTimer){
        if (self.flagEnterZapros == 3){
            self.flagEnterZapros = 1
        }

        timer.fireDate = timer.fireDate.dateByAddingTimeInterval(2)

        countLoad += 1
        
        if (self.flagEnterZapros == 1) {
 
            self.flagEnterZapros = 2

            Alamofire.request(.GET,"http://mobile.lexplate.ru/lexplateservice.svc/getrestaurants").responseJSON { response in
                if let resDictionary = response.result.value as? NSDictionary {
                    let resArray = resDictionary["GetRestaurantsResult"] as! NSArray
                    self.flagEnterZapros = 3
                    timer.invalidate()
                    self.priznakLoad = true
                    var i = 0
                    var address: String = ""
                    var addressPriznak: Int = 0
                    var title: String = ""
                    var titlePriznak: Int = 0
                    var averageCheck: String = ""
                    var averageCheckPriznak: Int = 0
                    var averageTime: String = ""
                    var averageTimePriznak: Int = 0
                    var dBase: String = ""
                    var dBasePriznak: Int = 0
                    
                    var cuisineType: String = ""
                    var cuisineTypePriznak: Int = 0
                    var phone: String = ""
                    var phonePriznak: Int = 0
                    var WebSite: String = ""
                    var WebSitePriznak: Int = 0
                    
                    var TimeTable_Mo_Start: String = ""
                    var TimeTable_Mo_StartPriznak: Int = 0
                    var TimeTable_Mo_End: String = ""
                    var TimeTable_Mo_EndPriznak: Int = 0
                    var TimeTable_Tu_Start: String = ""
                    var TimeTable_Tu_StartPriznak: Int = 0
                    var TimeTable_Tu_End: String = ""
                    var TimeTable_Tu_EndPriznak: Int = 0
                    var TimeTable_We_Start: String = ""
                    var TimeTable_We_StartPriznak: Int = 0
                    var TimeTable_We_End: String = ""
                    var TimeTable_We_EndPriznak: Int = 0
                    var TimeTable_Th_Start: String = ""
                    var TimeTable_Th_StartPriznak: Int = 0
                    var TimeTable_Th_End: String = ""
                    var TimeTable_Th_EndPriznak: Int = 0
                    var TimeTable_Fr_Start: String = ""
                    var TimeTable_Fr_StartPriznak: Int = 0
                    var TimeTable_Fr_End: String = ""
                    var TimeTable_Fr_EndPriznak: Int = 0
                    var TimeTable_Sa_Start: String = ""
                    var TimeTable_Sa_StartPriznak: Int = 0
                    var TimeTable_Sa_End: String = ""
                    var TimeTable_Sa_EndPriznak: Int = 0
                    var TimeTable_Su_Start: String = ""
                    var TimeTable_Su_StartPriznak: Int = 0
                    var TimeTable_Su_End: String = ""
                    var TimeTable_Su_EndPriznak: Int = 0
                    //var resArray: NSArray = res["GetRestaurantsResult"] as! NSArray
                    while (i < resArray.count) {

                        //address = resArray[i]["Address"] as! String
			if let address0  = resArray[i]["Address"] as? String {
                            address = address0
                            addressPriznak  = 1
                        }

                        //title = resArray[i]["Title"] as! String
			if let title0  = resArray[i]["Title"] as? String {
                            title = title0
                            titlePriznak  = 1
                        }

                        //dBase = resArray[i]["DbName"] as! String
			if let dBase0  = resArray[i]["DbName"] as? String {
                            dBase = dBase0
                            dBasePriznak  = 1
                        }

                        //cuisineType = resArray[i]["Cuisine"] as! String
			if let cuisineType0  = resArray[i]["Cuisine"] as? String {
                            cuisineType = cuisineType0
                            cuisineTypePriznak  = 1
                        }

                        //averageCheck = resArray[i]["AverageCheck"] as! String
			if let averageCheck0  = resArray[i]["AverageCheck"] as? String {
                            averageCheck = averageCheck0
                            averageCheckPriznak  = 1
                        }

                        //averageTime = resArray[i]["AverageTime"] as! String
			if let averageTime0  = resArray[i]["AverageTime"] as? String {
                            averageTime = averageTime0
                            averageTimePriznak  = 1
                        }

                        //phone = resArray[i]["Phone"] as! String
			if let phone0  = resArray[i]["Phone"] as? String {
                            phone = phone0
                            phonePriznak  = 1
                        }

                        //WebSite = resArray[i]["WebSite"] as! String
			if let WebSite0  = resArray[i]["WebSite"] as? String {
                            WebSite = WebSite0
                            WebSitePriznak  = 1
                        }

                        //TimeTable_Mo_Start = resArray[i]["TimeTable_Mo_Start"] as! String
			if let TimeTable_Mo_Start0  = resArray[i]["TimeTable_Mo_Start"] as? String {
                            TimeTable_Mo_Start = TimeTable_Mo_Start0
                            TimeTable_Mo_StartPriznak  = 1
                        }

                        //TimeTable_Mo_End = resArray[i]["TimeTable_Mo_End"] as! String
			if let TimeTable_Mo_End0  = resArray[i]["TimeTable_Mo_End"] as? String {
                            TimeTable_Mo_End = TimeTable_Mo_End0
                            TimeTable_Mo_EndPriznak  = 1
                        }

                        //TimeTable_Tu_Start = resArray[i]["TimeTable_Tu_Start"] as! String
			if let TimeTable_Tu_Start0  = resArray[i]["TimeTable_Tu_Start"] as? String {
                            TimeTable_Tu_Start = TimeTable_Tu_Start0
                            TimeTable_Tu_StartPriznak  = 1
                        }

                        //TimeTable_Tu_End = resArray[i]["TimeTable_Tu_End"] as! String
			if let TimeTable_Tu_End0  = resArray[i]["TimeTable_Tu_End"] as? String {
                            TimeTable_Tu_End = TimeTable_Tu_End0
                            TimeTable_Tu_EndPriznak  = 1
                        }

                        //TimeTable_We_Start = resArray[i]["TimeTable_We_Start"] as! String
			if let TimeTable_We_Start0  = resArray[i]["TimeTable_We_Start"] as? String {
                            TimeTable_We_Start = TimeTable_We_Start0
                            TimeTable_We_StartPriznak  = 1
                        }

                        //TimeTable_We_End = resArray[i]["TimeTable_We_End"] as! String
			if let TimeTable_We_End0  = resArray[i]["TimeTable_We_End"] as? String {
                            TimeTable_We_End = TimeTable_We_End0
                            TimeTable_We_EndPriznak  = 1
                        }

                        //TimeTable_Th_Start = resArray[i]["TimeTable_Th_Start"] as! String
			if let TimeTable_Th_Start0  = resArray[i]["TimeTable_Th_Start"] as? String {
                            TimeTable_Th_Start = TimeTable_Th_Start0
                            TimeTable_Th_StartPriznak  = 1
                        }

                        //TimeTable_Th_End = resArray[i]["TimeTable_Th_End"] as! String
			if let TimeTable_Th_End0  = resArray[i]["TimeTable_Th_End"] as? String {
                            TimeTable_Th_End = TimeTable_Th_End0
                            TimeTable_Th_EndPriznak  = 1
                        }

                        //TimeTable_Fr_Start = resArray[i]["TimeTable_Fr_Start"] as! String
			if let TimeTable_Fr_Start0  = resArray[i]["TimeTable_Fr_Start"] as? String {
                            TimeTable_Fr_Start = TimeTable_Fr_Start0
                            TimeTable_Fr_StartPriznak  = 1
                        }

                        //TimeTable_Fr_End = resArray[i]["TimeTable_Fr_End"] as! String
			if let TimeTable_Fr_End0  = resArray[i]["TimeTable_Fr_End"] as? String {
                            TimeTable_Fr_End = TimeTable_Fr_End0
                            TimeTable_Fr_EndPriznak  = 1
                        }

                        //TimeTable_Sa_Start = resArray[i]["TimeTable_Sa_Start"] as! String
			if let TimeTable_Sa_Start0  = resArray[i]["TimeTable_Sa_Start"] as? String {
                            TimeTable_Sa_Start = TimeTable_Sa_Start0
                            TimeTable_Sa_StartPriznak  = 1
                        }

                        //TimeTable_Sa_End = resArray[i]["TimeTable_Sa_End"] as! String
			if let TimeTable_Sa_End0  = resArray[i]["TimeTable_Sa_End"] as? String {
                            TimeTable_Sa_End = TimeTable_Sa_End0
                            TimeTable_Sa_EndPriznak  = 1
                        }

                        //TimeTable_Su_Start = resArray[i]["TimeTable_Su_Start"] as! String
			if let TimeTable_Su_Start0  = resArray[i]["TimeTable_Su_Start"] as? String {
                            TimeTable_Su_Start = TimeTable_Su_Start0
                            TimeTable_Su_StartPriznak  = 1
                        }

                        //TimeTable_Su_End = resArray[i]["TimeTable_Su_End"] as! String
			if let TimeTable_Su_End0  = resArray[i]["TimeTable_Su_End"] as? String {
                            TimeTable_Su_End = TimeTable_Su_End0
                            TimeTable_Su_EndPriznak  = 1
                        }

                        //let risris: String = resArray[i]["Picture"] as! String
                        var risris : String! = ""
                        var risPriznak : Int = 0
                        if let risris0  = resArray[i]["Picture"] as? String {
                            risris = risris0
                            risPriznak  = 1
                        }
                        
                        let decodedData = NSData(base64EncodedString: risris as String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                        //let decodedData2 = NSData(base64EncodedString: imageString as String, options: NSDataBase64DecodingOptions(rawValue: 0))
                        let decodedIamge = UIImage(data: decodedData!)
                        //self.organizationList.append(Organization(title: title,address: address,dBase: dBase, description: cuisineType))
                        
                        //if let found = find(lazy(self.organizationList).map({ $0.dBase }), dBase) {
                        
                        //find(filter(map(numbers, { $0 * 2}), { $0 % 3 == 0 }), 90)
                        
                        // Swift 2
                        //self.organizationList.map { $0 * 2 }.filter { $0 % 3 == 0 }.indexOf(90) // returns 2
                        //let fff = self.organizationList.indexOf({$0.dBase == dBase})
                        
                        if let _ = self.organizationList.indexOf({$0.dBase == dBase}) {
                            //let obj = organizationList[found]
                            //println(found.description)
                            //Такой элемент уже есть - не надо добавлять просто пустой код
                        }
                        else {
                            //Элемента нет - добавляем
                        
                            self.organizationList.append(Organization(title: title, titlePriznak: titlePriznak,
                                address: address, addressPriznak: addressPriznak,
                                dBase: dBase, dBasePriznak: dBasePriznak,
                                description: cuisineType, descriptionPriznak: cuisineTypePriznak,
                                averageCheck: averageCheck, averageCheckPriznak: averageCheckPriznak,
                                averageTime: averageTime, averageTimePriznak: averageTimePriznak,
                                ris: decodedIamge, risPriznak: risPriznak,
                                phone: phone, phonePriznak: phonePriznak,
                                WebSite: WebSite, WebSitePriznak: WebSitePriznak,
                                TimeTable_Mo_Start: TimeTable_Mo_Start, TimeTable_Mo_StartPriznak: TimeTable_Mo_StartPriznak,
                                TimeTable_Mo_End: TimeTable_Mo_End, TimeTable_Mo_EndPriznak: TimeTable_Mo_EndPriznak,
                                TimeTable_Tu_Start: TimeTable_Tu_Start, TimeTable_Tu_StartPriznak: TimeTable_Tu_StartPriznak,
                                TimeTable_Tu_End: TimeTable_Tu_End, TimeTable_Tu_EndPriznak: TimeTable_Tu_EndPriznak,
                                TimeTable_We_Start: TimeTable_We_Start, TimeTable_We_StartPriznak: TimeTable_We_StartPriznak,
                                TimeTable_We_End: TimeTable_We_End, TimeTable_We_EndPriznak: TimeTable_We_EndPriznak,
                                TimeTable_Th_Start: TimeTable_Th_Start, TimeTable_Th_StartPriznak: TimeTable_Th_StartPriznak,
                                TimeTable_Th_End: TimeTable_Th_End, TimeTable_Th_EndPriznak: TimeTable_Th_EndPriznak,
                                TimeTable_Fr_Start: TimeTable_Fr_Start, TimeTable_Fr_StartPriznak: TimeTable_Fr_StartPriznak,
                                TimeTable_Fr_End: TimeTable_Fr_End, TimeTable_Fr_EndPriznak: TimeTable_Fr_EndPriznak,
                                TimeTable_Sa_Start: TimeTable_Sa_Start, TimeTable_Sa_StartPriznak: TimeTable_Sa_StartPriznak,
                                TimeTable_Sa_End: TimeTable_Sa_End, TimeTable_Sa_EndPriznak: TimeTable_Sa_EndPriznak,
                                TimeTable_Su_Start: TimeTable_Su_Start, TimeTable_Su_StartPriznak: TimeTable_Su_StartPriznak,
                                TimeTable_Su_End: TimeTable_Su_End, TimeTable_Su_EndPriznak: TimeTable_Su_EndPriznak
                                
                                ))
                        }
                        i += 1
                    } // while (i < resArray.count)
                    //println("xxx")
                    self.organizationTableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.flagEnterRefresh = false
                    //self.priznakLoad = true
                    self.countLoad = 0
                    //timer.invalidate()
                    
                    
                    //                println("bbbb")
                    //priznakYesNo = true
                    
                }
            } // responseJSON {
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
            countLoad = 0
            refreshControl.endRefreshing()
            self.flagEnterRefresh = false
            timer.invalidate()
            
        }
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
        
        
        if (self.priznakLoad == false)&&(self.organizationList.count<1)&&(self.flagEnterRefresh == false) {
            self.flagEnterRefresh = true
            
            dispatch_async(dispatch_get_main_queue()) {()-> Void in
                //---------------------------------------------------------------------------------------------------------------
                self.refreshTableOrganization()
                //var  timer1 = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: Selector("refreshTableOrganization:"), userInfo: nil, repeats: true)
                //---------------------------------------------------------------------------------------------------------------
            }
        }
        
        if (self.priznakLoad == true)||(self.organizationList.count>0) {
            refreshControl.endRefreshing()
        }
        //self.organizationTableView.reloadData()
        //refreshControl.endRefreshing()
    }
    
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&& Конец Загрузка с колесиком Spinner &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.tabBarController?.tabBar.hidden = true
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest(entityName: "Basket")
        
        
        //var result: NSArray = context.executeFetchRequest(request, error: nil)!
        //============
        var result : [AnyObject]
        result = [""]
        do {
            let result22 = try context.executeFetchRequest(request)
            result = result22
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        //====================
        
        //print("qazert")
        if (result.count > 0) {
            //print("qazert2")
            for res in result {
                //print("qazert3")
                context.deleteObject(res as! NSManagedObject)
            }
        }
        
//        if (priznakShowAlert == true){
//            
//            let alertController = UIAlertController(title: "Подтверждение отправлено", message: nil, preferredStyle: .Alert)
//            self.presentViewController(alertController, animated: true, completion: nil)
//            let delay = 1.0 * Double(NSEC_PER_SEC)
//            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//            dispatch_after(time, dispatch_get_main_queue(), {
//                alertController.dismissViewControllerAnimated(true, completion: nil)
//            })
//            self.priznakShowAlert=false
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return organizationList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrganizationCell", forIndexPath: indexPath) as! OrganizationTableViewCell
        let org = organizationList[indexPath.row]
        //cell.setCell(org.title, description: org.description)
        
        if (indexPath.row+1 <= organizationList.count) {
            cell.setCell(org.title, description: org.description, cheque: org.averageCheck, time: org.averageTime, image: org.ris)
            cell.labelInfo.text = org.textInfoCalcText()
            //print(cell.labelInfo.text)
        }
        
        cell.s2()
        //print(indexPath.row.description)
        if (self.currentSelection == indexPath.row){
            cell.s1()
        }
        
        //print(indexPath.row.description)
        return cell
    }
    
    var currentSelection : Int = -1
    var currentSelectionDC : Int = 0
    var indexPathOld : NSIndexPath?
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        print(indexPath.row.description)
//        var p : Bool = false
//        var cellOld : OrganizationTableViewCell
//        if (currentSelection != -1){
//            p = true
//        }
//        let cellNew = tableView.dequeueReusableCellWithIdentifier("OrganizationCell", forIndexPath: indexPath) as! OrganizationTableViewCell
//        
//        //print("qazxsw")
//        self.currentSelectionDC = 0
//        
//        var forSega : Bool = false
//        if (self.currentSelection == indexPath.row){
//            self.currentSelectionDC = 1
//            forSega = true
//            //performSegueWithIdentifier("SegueFromRestToKind", sender: nil)
//        }
//        
//        self.currentSelection = indexPath.row
//        if (self.currentSelectionDC == 0){
//            
//            var listIndexs = [NSIndexPath] ()
//            listIndexs.append(indexPath)
//            
//            
//            if (p == true) {
//                if (self.indexPathOld!.row != indexPath.row){
//                    listIndexs.append(self.indexPathOld!)
//                    print("old " + indexPathOld!.row.description)
//                    cellOld = tableView.dequeueReusableCellWithIdentifier("OrganizationCell", forIndexPath: indexPathOld!) as! OrganizationTableViewCell
//                    //cellOld.s2()
//                }
//            }
//            //print("qaz")
//            tableView.beginUpdates()
//            
//            //tableView.reloadRowsAtIndexPaths(listIndexs, withRowAnimation: UITableViewRowAnimation.Fade)
//            //tableView.reloadRowsAtIndexPaths(listIndexs, withRowAnimation: nil as UITableViewRowAnimation)
//            //tableView.reloadData()
//            tableView.endUpdates()
//            //cellNew.s1()
//            //tableView.reloadData()
//            
//            //cellNew.s1()
//        }
//        
//        //print(self.currentSelection.description)
//        self.indexPathOld = indexPath
//        //cellNew.s1()
//        if (forSega == true){
//            performSegueWithIdentifier("SegueFromRestToKind", sender: nil)
//        }
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        //print("qw "+self.currentSelection.description)
//        if (indexPath.row == self.currentSelection){
//            //print("350")
//            return 350 //267 //350
//        }
//        else {
//            //print("255")
//            return 255 //125 //255
//        }
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //print(indexPath.row.description)
        var p : Bool = false
        //var cellOld : OrganizationTableViewCell
        if (currentSelection != -1){
            p = true
        }
//        let cellNew = tableView.dequeueReusableCellWithIdentifier("OrganizationCell", forIndexPath: indexPath) as! OrganizationTableViewCell
//        print(cellNew.labelInfo.font.fontName)
        
        //print("qazxsw")
        self.currentSelectionDC = 0
        
        var forSega : Bool = false
        if (self.currentSelection == indexPath.row){
            self.currentSelectionDC = 1
            forSega = true
            //performSegueWithIdentifier("SegueFromRestToKind", sender: nil)
        }
        
        self.currentSelection = indexPath.row
        if (self.currentSelectionDC == 0){
            
            var listIndexs = [NSIndexPath] ()
            listIndexs.append(indexPath)
            
            
            if (p == true) {
                if (self.indexPathOld!.row != indexPath.row){
                    listIndexs.append(self.indexPathOld!)
                    //print("old " + indexPathOld!.row.description)
                    //cellOld = tableView.dequeueReusableCellWithIdentifier("OrganizationCell", forIndexPath: indexPathOld!) as! OrganizationTableViewCell
                    //cellOld.s2()
                }
            }
            //print("qaz")
            ///////////tableView.beginUpdates()
            
            tableView.reloadRowsAtIndexPaths(listIndexs, withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            
            //или в tableView.selectRowAtIndexPath сделать тогда scrollToRowAtIndexPath не нужно
//            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
            
            //tableView.reloadRowsAtIndexPaths(listIndexs, withRowAnimation: nil as UITableViewRowAnimation)
            //tableView.reloadData()
            ///////////tableView.endUpdates()
            //cellNew.s1()
            //tableView.reloadData()
            
            //cellNew.s1()
        }
        
        //print(self.currentSelection.description)
        self.indexPathOld = indexPath
        //cellNew.s1()
        if (forSega == true){
            performSegueWithIdentifier("SegueFromRestToKind", sender: nil)
        }
        
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
    
    
    @IBOutlet var viewOrg: UIView!
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("OrganizationCell", forIndexPath: indexPath) as! OrganizationTableViewCell
        let org = organizationList[indexPath.row]
        let widthLabelInfo : CGFloat = self.viewOrg.frame.size.width - 40 // 19 18 20  //cell.labelInfo.frame.size.width
        let fontLabelInfo : UIFont = UIFont(name: ".SFUIText-Regular", size: 17)! //cell.labelInfo.font
        let textInfo = org.textInfoCalcText()
        let textSize = self.dynamicType.sizeForContentString(textInfo, forMaxWidth: widthLabelInfo, fontMy: fontLabelInfo)
        let textSizeHeight = textSize.height
        
        
        //print("qw "+self.currentSelection.description)
        if (indexPath.row == self.currentSelection){
            //print("350")
            return 247 + textSizeHeight //267 //350
        }
        else {
            //print("255")
            return 247 //125 //255
        }
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let kindMenuViewController = (segue.destinationViewController as!  KindMenuViewController)
        let index = organizationTableView.indexPathForSelectedRow!
        kindMenuViewController.dBase = organizationList[index.row].dBase
        kindMenuViewController.title = organizationList[index.row].title //Vit 21.07.15 при переходе на след окно отображать название ячейки пред окна

        kindMenuViewController.OrganizationInf = organizationList[index.row]
        //print(kindMenuViewController.modalPresentationStyle)
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let requestDbasen = NSFetchRequest(entityName: "Dbasen")
        
        //var resultDbasen:NSArray = context.executeFetchRequest(requestDbasen, error: nil)!
        //resultDbasen[0].setValue(organizationList[index.row].dBase, forKey: "name")
        
        var resultDbasen : [AnyObject]
        resultDbasen = [""]

        
        do {
            let resultDbasen22 = try context.executeFetchRequest(requestDbasen)
            resultDbasen = resultDbasen22
            //resultDbasen22[0].setValue(organizationList[index.row].dBase, forKey: "name")
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        resultDbasen[0].setValue(organizationList[index.row].dBase, forKey: "name")
      
        
//        resultDBaseName[0].valueForKey("name")!
//        valueForKey("id")! as! Int == self.course.i
        
        
//        let tb = self.parentViewController!.parentViewController as! UITabBarController
//        
//        let v = tb.viewControllers![tb.viewControllers!.count-1] as! InformationViewController
//        
//        v.setP(organizationList[index.row].title, description: organizationList[index.row].description, cheque: organizationList[index.row].averageCheck, time: organizationList[index.row].averageTime)
        
//        let infvc = storyboard?.instantiateViewControllerWithIdentifier("InformationStbId") as? InformationViewController
//        infvc?.idescription.text = "ffvfrvf"
        
//        let infvc = storyboard?.instantiateViewControllerWithIdentifier("InformationTestStbId") as? InformationViewControllerTest
//        infvc?.cvcvc = "qazsff"
//        infvc!.titleLabel.text = "gdbgfbgtbgbg"
//        presentViewController(infvc!, animated: true, completion: nil)
        
        
        //infvc?.titleLabel.text = "dfdfgertg"
        
        
//        infoVC.ititle.text = organizationList[index.row].title
//        infoVC.idescription.text = organizationList[index.row].description
//        infoVC.iAddress.text = organizationList[index.row].address
//        infoVC.iaverageCheck.text = organizationList[index.row].averageCheck
//        infoVC.iaverageTime.text = organizationList[index.row].averageTime
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        //kindMenuViewController.hidesBottomBarWhenPushed = true
        
    
        
    }
}
