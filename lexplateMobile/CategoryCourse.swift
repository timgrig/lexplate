//
//  CategoryCourse.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 06.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import Foundation

class CategoryCourse {
    var id: Int = 0
    var title: String = ""
    var courseList = [Course]()
    
    init (id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    init (id: Int, title: String, courses: [(Course)]) {
        self.id = id
        self.title = title
        self.courseList = courses
    }
}