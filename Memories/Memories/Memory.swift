//
//  Memory.swift
//  Memories
//
//  Created by Yvette Zhukovsky on 10/16/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation

struct Memory: Codable,Equatable {
    var title: String
    var bodyText: String
    var imageData: Data
    
}
