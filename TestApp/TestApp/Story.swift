//
//  Story.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import UIKit





class Story: NSObject, Decodable {
    let createdAt : Date
    let title : String
    
    init(createdAt: Date, title:String) {
        self.createdAt = createdAt
        self.title = title
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try! values.decode(String.self, forKey: CodingKeys.title)
        let date = try! values.decode(Date.self, forKey:CodingKeys.createAt )
        self.createdAt = date
    }

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case createAt = "created_at"
    }
}




