//
//  Data+Extension.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import Foundation

extension Data {
    func jsonObject(of type: AnyClass) -> [Story]? {
        
        do {
            
            if let stories = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [Story] {
                return stories
            } else {
                print("Object has been not parsed")
            }
            
            
        } catch  {
            print("error occured: \(error)")
        }
        
        print("Error occured while parsing response")
      return nil
    }

}
