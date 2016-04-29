//
//  Organization.swift
//  lexplateMobile
//
//  Created by Тимошин Григорий on 06.04.15.
//  Copyright (c) 2015 EcoSoft. All rights reserved.
//

import Foundation
import UIKit

class Organization {
    var id: Int = 0
    var dBase: String = ""
    var dBasePriznak: Int = 0
    var title: String = ""
    var titlePriznak: Int = 0
    var logoURL: String = ""
    var address: String = ""
    var addressPriznak: Int = 0
    var phone: String = ""
    var phonePriznak: Int = 0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var averageCheck: String = "" //Double = 0.0
    var averageCheckPriznak: Int = 0 //Double = 0.0
    var deliveryPrice: String = ""
    var deliveryPricePriznak: Int = 0
    var isDelivery: Bool = false
    var isResevation: Bool = false
    var description: String = ""
    var descriptionPriznak: Int = 0
    var login: String = ""
    var password: String = ""
    var averageTime: String = ""
    var averageTimePriznak: Int = 0
    var ris: UIImage?
    var risPriznak : Int = 0
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
    
    
    
    var photoURLs: NSArray = [String]()
    
    init(title: String, login: String, password: String, description: String) {
        self.title = title
        self.login = login
        self.password = password
        self.description = description
    }
    
    init (title: String, address: String,dBase: String, description: String) {
        self.title = title
        self.address = address
        self.dBase = dBase
        self.description = description
        
    }
    
    init (title: String, titlePriznak: Int,
        address: String, addressPriznak: Int,
        dBase: String, dBasePriznak: Int,
        description: String, descriptionPriznak:Int,
        averageCheck: String, averageCheckPriznak: Int,
        averageTime: String, averageTimePriznak: Int,
        ris: UIImage?, risPriznak:Int,
        phone: String, phonePriznak: Int,
        WebSite: String, WebSitePriznak: Int,
        TimeTable_Mo_Start: String, TimeTable_Mo_StartPriznak: Int, TimeTable_Mo_End: String, TimeTable_Mo_EndPriznak: Int,
        TimeTable_Tu_Start: String, TimeTable_Tu_StartPriznak: Int, TimeTable_Tu_End: String, TimeTable_Tu_EndPriznak: Int,
        TimeTable_We_Start: String, TimeTable_We_StartPriznak: Int, TimeTable_We_End: String, TimeTable_We_EndPriznak: Int,
        TimeTable_Th_Start: String, TimeTable_Th_StartPriznak: Int, TimeTable_Th_End: String, TimeTable_Th_EndPriznak: Int,
        TimeTable_Fr_Start: String, TimeTable_Fr_StartPriznak: Int, TimeTable_Fr_End: String, TimeTable_Fr_EndPriznak: Int,
        TimeTable_Sa_Start: String, TimeTable_Sa_StartPriznak: Int, TimeTable_Sa_End: String, TimeTable_Sa_EndPriznak: Int,
        TimeTable_Su_Start: String, TimeTable_Su_StartPriznak: Int, TimeTable_Su_End: String, TimeTable_Su_EndPriznak: Int
        )
    {
        self.title = title
        self.titlePriznak = titlePriznak
        self.address = address
        self.addressPriznak = addressPriznak
        self.dBase = dBase
        self.dBasePriznak = dBasePriznak
        self.description = description
        self.descriptionPriznak = descriptionPriznak
        self.averageCheck = averageCheck
        self.averageCheckPriznak = averageCheckPriznak
        self.averageTime = averageTime
        self.averageTimePriznak = averageTimePriznak
        self.ris = ris
        self.risPriznak = risPriznak
        self.phone = phone
        self.phonePriznak = phonePriznak
        self.WebSite = WebSite
        self.WebSitePriznak = WebSitePriznak
        self.TimeTable_Mo_Start = TimeTable_Mo_Start
        self.TimeTable_Mo_StartPriznak = TimeTable_Mo_StartPriznak
        self.TimeTable_Mo_End = TimeTable_Mo_End
        self.TimeTable_Mo_EndPriznak = TimeTable_Mo_EndPriznak
        self.TimeTable_Tu_Start = TimeTable_Tu_Start
        self.TimeTable_Tu_StartPriznak = TimeTable_Tu_StartPriznak
        self.TimeTable_Tu_End = TimeTable_Tu_End
        self.TimeTable_Tu_EndPriznak = TimeTable_Tu_EndPriznak
        self.TimeTable_We_Start = TimeTable_We_Start
        self.TimeTable_We_StartPriznak = TimeTable_We_StartPriznak
        self.TimeTable_We_End = TimeTable_We_End
        self.TimeTable_We_EndPriznak = TimeTable_We_EndPriznak
        self.TimeTable_Th_Start = TimeTable_Th_Start
        self.TimeTable_Th_StartPriznak = TimeTable_Th_StartPriznak
        self.TimeTable_Th_End = TimeTable_Th_End
        self.TimeTable_Th_EndPriznak = TimeTable_Th_EndPriznak
        self.TimeTable_Fr_Start = TimeTable_Fr_Start
        self.TimeTable_Fr_StartPriznak = TimeTable_Fr_StartPriznak
        self.TimeTable_Fr_End = TimeTable_Fr_End
        self.TimeTable_Fr_EndPriznak = TimeTable_Fr_EndPriznak
        self.TimeTable_Sa_Start = TimeTable_Sa_Start
        self.TimeTable_Sa_StartPriznak = TimeTable_Sa_StartPriznak
        self.TimeTable_Sa_End = TimeTable_Sa_End
        self.TimeTable_Sa_EndPriznak = TimeTable_Sa_EndPriznak
        self.TimeTable_Su_Start = TimeTable_Su_Start
        self.TimeTable_Su_StartPriznak = TimeTable_Su_StartPriznak
        self.TimeTable_Su_End = TimeTable_Su_End
        self.TimeTable_Su_EndPriznak = TimeTable_Su_EndPriznak
            
    }
    
    var textInfo: String = ""
    
    func textInfoCalcText() -> String {
        
        self.textInfo = "Информация"+"\n"
        if (self.descriptionPriznak == 1)&&(self.description != "Нет данных")
        {
            self.textInfo = self.textInfo + self.description + "\n"
        }
        
        if (self.addressPriznak == 1)&&(self.address != "Нет данных")
        {
            self.textInfo = self.textInfo + "Адрес: " + self.address + "\n"
        }
        
        if (self.phonePriznak == 1)&&(self.phone != "Нет данных")
        {
            self.textInfo = self.textInfo + "Телефон: " + self.phone + "\n"
        }
        
        if (self.WebSitePriznak == 1)&&(self.WebSite != "Нет данных")
        {
            self.textInfo = self.textInfo + "Веб сайт: " + self.WebSite + "\n"
        }
        
        if (self.averageCheckPriznak == 1)&&(self.averageCheck != "Нет данных")
        {
            self.textInfo = self.textInfo + "Средний чек: " + self.averageCheck + "\n"
        }
        
        if (self.averageTimePriznak == 1)&&(self.averageTime != "Нет данных")
        {
            self.textInfo = self.textInfo + "Среднее время приготовления: " + self.averageTime + "\n"
        }
        
        if (self.TimeTable_Mo_StartPriznak == 1)&&(self.TimeTable_Mo_EndPriznak == 1)&&(self.TimeTable_Tu_StartPriznak == 1)&&(self.TimeTable_Tu_EndPriznak == 1)&&(self.TimeTable_We_StartPriznak == 1)&&(self.TimeTable_We_EndPriznak == 1)&&(self.TimeTable_Th_StartPriznak == 1)&&(self.TimeTable_Th_EndPriznak == 1)&&(self.TimeTable_Fr_StartPriznak == 1)&&(self.TimeTable_Fr_EndPriznak == 1)&&(self.TimeTable_Sa_StartPriznak == 1)&&(self.TimeTable_Sa_EndPriznak == 1)&&(self.TimeTable_Su_StartPriznak == 1)&&(self.TimeTable_Su_EndPriznak == 1)
        {
            self.textInfo = self.textInfo + "Время работы:" + "\n"
            self.textInfo = self.textInfo + "Понедельник: "+self.TimeTable_Mo_Start+"-"+self.TimeTable_Mo_End + "\n"
            self.textInfo = self.textInfo + "Вторник: "+self.TimeTable_Tu_Start+"-"+self.TimeTable_Tu_End + "\n"
            self.textInfo = self.textInfo + "Среда: "+self.TimeTable_We_Start+"-"+self.TimeTable_We_End + "\n"
            self.textInfo = self.textInfo + "Четверг: "+self.TimeTable_Th_Start+"-"+self.TimeTable_Th_End + "\n"
            self.textInfo = self.textInfo + "Пятница: "+self.TimeTable_Fr_Start+"-"+self.TimeTable_Fr_End + "\n"
            self.textInfo = self.textInfo + "Суббота: "+self.TimeTable_Sa_Start+"-"+self.TimeTable_Sa_End + "\n"
            self.textInfo = self.textInfo + "Воскресенье: "+self.TimeTable_Su_Start+"-"+self.TimeTable_Su_End
        }
        
        return self.textInfo

        
    }
}