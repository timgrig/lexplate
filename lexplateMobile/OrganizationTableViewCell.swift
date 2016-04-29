//
//  OrganizationTableViewCell.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 06.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var chequeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    //@IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var labelInfo: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //print("qa" + self.titleLabel)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, description: String) {
        //self.logoImage.layer.cornerRadius = self.logoImage.frame.size.height / 2.0
        self.logoImage.layer.cornerRadius = CGRectGetWidth(self.logoImage.bounds) / 2.0
        self.logoImage.clipsToBounds = true
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    func setCell(title: String, description: String, cheque: String, time: String, image: UIImage?) {
        //self.logoImage.layer.cornerRadius = self.logoImage.frame.size.height / 2.0
        //self.logoImage.layer.cornerRadius = CGRectGetWidth(self.logoImage.bounds) / 2.0
        self.logoImage.clipsToBounds = true
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        if (description == "Нет данных")
        {
           
            let myConstraint01 =
            NSLayoutConstraint(item: chequeLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: titleLabel,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 8)
//            var myConstraint02 =
//            NSLayoutConstraint(item: timeLabel,
//                attribute: NSLayoutAttribute.Top,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: titleLabel,
//                attribute: NSLayoutAttribute.Bottom,
//                multiplier: 1.0,
//                constant: 8)
            
//            if var ccv = self.constr01.firstItem as? UILabel {
//                ccv = self.chequeLabel.self
//            }
            
            
            //self.descriptionLabel.removeFromSuperview()
//
            self.contentView.addConstraint(myConstraint01)
//            self.contentView.addConstraint(myConstraint02)
            
//            println(constr01.firstAttribute.hashValue.description)
//            println(myConstraint.firstAttribute.hashValue.description)
        }
        self.chequeLabel.text = "Средний чек " + cheque
        self.timeLabel.text = "время доставки "+time
        self.logoImage.image = image
        
        if (description == "Нет данных")
        {
            //self.descriptionLabel.removeFromSuperview()  // при резкой прокуртке вверх дает ошибку EXC_BAD_Instruction(code=EXC_I386_INVOP, subcode=0x0)
            //fatal error: unexpectedly found nil while unwrapping an Optional value
            // по всей видимости когда удаляем элемент и идет прокуртка он пытается найти этот элемент а его нет поэтому ошибка - может быть не прав
            //Поэтому просто скроем этот элемент
            self.descriptionLabel.hidden = true
        }
    }
    
    func s1(){
        //UIView.animateWithDuration(0.4, animations: {
            self.labelInfo.alpha = 1
            //self.viewInfo.transform = CGAffineTransformIdentity
            //print("self.viewInfo.alpha = 1")
        //})
        
        
        //self.labelInfo.numberOfLines = 0
        
        //self.labelInfo.preferredMaxLayoutWidth = 700
        
        //self.labelInfo.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.labelInfo.sizeToFit()
        //print(self.labelInfo.numberOfLines.description)
    }
    
    func s2(){
        //UIView.animateWithDuration(0.4, animations: {
            self.labelInfo.alpha = 0
        //})
    }
    
    

    

}
