//
//  Memory.swift
//  Memories
//
//  Created by Welinkton on 9/13/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

struct Memory:Codable, Equatable {
    var title:String
    var bodyText:String
    var imageData:Data
    
    init(title:String, bodyText:String, imageData:Data) {
        self.title = title
        self.bodyText = bodyText
        self.imageData = imageData
    }
    
}
