//
//  Information.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 31/08/15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import Foundation
import UIKit

class Information{

    var title: String = ""
    var iimage: UIImage?
    var risPriznak: Int = 0
    
    init(title: String) {
        self.title = title
    }

    init(title: String, iimage: UIImage?, risPriznak: Int) {
        self.title = title
        self.iimage = iimage
        self.risPriznak = risPriznak
    }

}
