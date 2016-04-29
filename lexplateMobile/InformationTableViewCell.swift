//
//  InformationTableViewCell.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 31/08/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
  
    @IBOutlet weak var labelText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String) {
        self.labelText.text = title
    }

}
