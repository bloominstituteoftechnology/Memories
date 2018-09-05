//
//  Memory.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

struct Memory: Equatable, Codable {
    
    var title: String
    var bodyText: String
    var imageData: Data
}
