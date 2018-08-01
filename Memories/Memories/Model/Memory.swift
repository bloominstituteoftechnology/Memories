//
//  Memory.swift
//  Memories
//
//  Created by Linh Bouniol on 8/1/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

struct Memory: Equatable, Codable {
    var title: String
    var bodyText: String
    var imageData: Data
}
