//
//  InformationViewController.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 27/08/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var informationList = [Information]()
    
//    @IBOutlet weak var ititle: UILabel!
//
//    
//    
//    @IBOutlet weak var iimage: UIImageView!
    
    
    @IBOutlet weak var informationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.informationTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //Фон синим
        // self.topLayoutGuide.length не работает в viewDidLoad(), поэтому в viewDidAppear
        let addStatusBar = UIView()
        addStatusBar.frame = CGRectMake(0, 0, self.view.frame.width, self.topLayoutGuide.length+8)   // 8 - это высота констрайнта vertical от таблицы до нижнего края topLayoutGuide
        addStatusBar.backgroundColor = UIColor.blue31 //global().UIColorFromRGB(0x65b4d9)
        self.view!.addSubview(addStatusBar)
        
    }
    
    //Текстовку белым цветом
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setP(title: String, description: String, cheque: String, time: String) {
        //self.logoImage.layer.cornerRadius = self.logoImage.frame.size.height / 2.0

        //self.ititle.text = title

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        
        if (indexPath.row == 0) {
            let cellLogo = tableView.dequeueReusableCellWithIdentifier("InformationLogoCell", forIndexPath: indexPath) as! InformationLogoTableViewCell
            let cCourse = informationList[indexPath.row]
            cellLogo.setCell(cCourse.title, iimage: cCourse.iimage, risPriznak: cCourse.risPriznak)
            return cellLogo
        }
        
        if (indexPath.row != 0) {
        let cell = tableView.dequeueReusableCellWithIdentifier("InformationCell", forIndexPath: indexPath) as! InformationTableViewCell
        let cCourse = informationList[indexPath.row]
        cell.setCell(cCourse.title)
        return cell
        }
        
        let rr = tableView.dequeueReusableCellWithIdentifier("rr", forIndexPath: indexPath) as! InformationLogoTableViewCell
        return rr
    }
    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var ff: CGFloat = 200
//        
//        if (indexPath.row == 0) {
//            ff = 191
//        }
//      
//        
//        return ff
//        
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var ff: CGFloat = 41
        
        if (indexPath.row == 0) {
            ff = 191
            if (informationList[indexPath.row].risPriznak == 0){
                ff = 41
            }
        }
        
        
        return ff
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
