//
//  StoryModel.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import Foundation

class StoryModel {
    
    // MARK: - Properties
    var selectableStories: [SelectableStory] = []
    var selectedCount : Int {
        return selectableStories.filter({$0.isSelected}).count
    }
    
    // MARK: - Methods
    func fetchStories(completionHander:@escaping (Bool, Error?) -> ()) {
        NetworkManger.shared.fetchStories { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let decoded = try! decoder.decode(StoryResponse.self, from: data)
                let stories = decoded.hits
                self.selectableStories = stories.map({return SelectableStory(item:$0)})
                completionHander(true, nil)
            } else {
                completionHander(false, error)
            }
        }
    }
}
