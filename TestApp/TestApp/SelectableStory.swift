//
//  SelectableStory.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import Foundation

class SelectableStory {
    private var story : Story
    var isSelected : Bool = false
    
    init(item: Story) {
        self.story = item
    }
    
    
}

extension SelectableStory {
    func createViewModel() -> StoryViewModel {
        return StoryViewModel(title: self.story.title, createdAt: self.story.createdAt.description, switchIsOn: self.isSelected)
    }
}


