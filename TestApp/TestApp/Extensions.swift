//
//  Extensions.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import Foundation

extension Date {
    func formatted() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz" // This formate is input formated .
        
        let formateDate = self
        dateFormatter.dateFormat = "dd-MM-yyyy" // Output Formated
        
        print ("Print :\(dateFormatter.string(from: formateDate))")//Print :02-02-2018
        return dateFormatter.string(from: formateDate)
    }
}
