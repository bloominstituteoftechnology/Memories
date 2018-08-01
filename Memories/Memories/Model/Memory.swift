//
//  Memory.swift
//  Memories
//
//  Created by Simon Elhoej Steinmejer on 01/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable
{
    var title: String
    var bodyText: String
    var imageData: Data
}
