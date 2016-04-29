//
//  Course.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 06.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import Foundation

class Course {
    var id: Int = 0
    var title: String = ""
    var price: Double = 0.0
    var weight: String = ""
    var description: String = ""
    var legend: String = ""
    var pictureGUID: String = ""
    var count: Int = 0
    var foodMenuId: Int = 0
    
    init(id: Int, title: String, foodMenuId: Int, price: Double) {
        self.id = id
        self.title = title
        self.foodMenuId = foodMenuId
        self.price = price
    }
    
    init(id: Int, title: String, foodMenuId: Int, price: Double, count: Int) {
        self.id = id
        self.title = title
        self.foodMenuId = foodMenuId
        self.price = price
        self.count = count
    }
    
    init () {
    }
    
    init (id: Int, title: String, price: Double) {
        self.id = id
        self.title = title
        self.price = price
    }
}