//
//  Memory.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable
{
    var title: String
    var bodyText: String
    var imageData: Data
}
