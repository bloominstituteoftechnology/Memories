//
//  Memory.swift
//  Memories
//
//  Created by Scott Bennett on 9/12/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    var title: String
    var bodyText: String
    var imageData: Data
}
