//
//  KindMenuTableViewCell.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 06.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class KindMenuTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String) {
        self.titleLabel.text = title
    }

}
