//
//  Memory.swift
//  Memories
//
//  Created by Nikita Thomas on 10/16/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    var title: String
    var bodyText: String
    var imageData: Data
    
    init(title: String, bodyText: String, imageData: Data) {
        (self.title, self.bodyText, self.imageData) = (title, bodyText, imageData)
    }
}
