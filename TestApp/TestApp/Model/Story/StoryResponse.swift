//
//  StoryResponse.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import Foundation

class StoryResponse : NSObject, Decodable {
    // MARK: - Inner types
    enum CodingKeys : String, CodingKey {
        case hits
    }
    
    // MARK: - Properties
    let hits : [Story]
    
    // MARK: - Methodds
    required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let arrayContainer = try container.decode([Story].self, forKey: .hits)
        self.hits = arrayContainer        
    }
}
