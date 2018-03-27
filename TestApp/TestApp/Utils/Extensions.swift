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
        
        let formateDate = self
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: formateDate)
    }
}
