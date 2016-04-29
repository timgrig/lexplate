//
//  LexplateSearchBar.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 06/10/15.
//  Copyright © 2015 EcoSoft. All rights reserved.
//

import Foundation
import UIKit

class LexplateSearchBar: UISearchBar {
    
    init(){
        super.init(frame: CGRectZero)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Именно из-за этого метода который необходимо переопределить пустым - чтобы не было кнопки cancel рядом с текстовым полем
    override func setShowsCancelButton(showsCancelButton: Bool, animated: Bool) {
        // Void
    }
    
}