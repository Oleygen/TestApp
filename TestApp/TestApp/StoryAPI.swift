//
//  TagsAPI.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import UIKit

class StoryAPI: NSObject {
    private let urlString = "https://hn.algolia.com/api/v1/search_by_date?tags=story"
    
    func fetchStories(completionHander:@escaping (Bool, [Story]?, Error?) -> ()) {
        URLSession(configuration: .default).dataTask(with: URL(string:urlString)!) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let decoded = try! decoder.decode(StoryResponse.self, from: data)
                
                completionHander(true, decoded.hits, nil)
            } else {
                completionHander(false, nil, error)
            }
        }.resume()
    }
}
