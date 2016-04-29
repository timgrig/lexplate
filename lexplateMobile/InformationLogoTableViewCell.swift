//
//  InformationLogoTableViewCell.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 01/09/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class InformationLogoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var iimage: UIImageView!
    
    var risPriznak : Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, iimage: UIImage?, risPriznak: Int) {
        self.labelText.text = title
        self.iimage.image = iimage
        self.risPriznak = risPriznak
        
        if (self.risPriznak == 0){
//            print(risPriznak.description)
//            //self.iimage.frame.height = CGFloat(0)
//            self.iimage.frame = CGRectMake(0,0, 1, 1)
//            print(self.iimage.frame.size.height)
//            //self.iimage.frame.size.height = CGFloat(0)
////            self.iimage.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
////            let myConstraint01 =
////            NSLayoutConstraint(item: labelText,
////                attribute: NSLayoutAttribute.Top,
////                relatedBy: NSLayoutRelation.Equal,
////                toItem: self.contentView ,
////                attribute: NSLayoutAttribute.Bottom,
////                multiplier: 1.0,
////                constant: 4)
////
////            self.contentView.addConstraint(myConstraint01)
//            self.contentView.frame = CGRectMake(0,0, self.contentView.frame.size.width, 5)
//            print(self.contentView.frame.size.height)
            //Так и не понял как здесь сделать изменеие размера рисунка - все попробовал с инета - не работает - поэтому изменение размера ячейки из InformationViewController
            
        }
    }
    
    

}
