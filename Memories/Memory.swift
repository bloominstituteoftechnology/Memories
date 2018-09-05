//
//  Memory.swift
//  Memories
//
//  Created by Spencer Curtis on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    
    var title: String
    var bodyText: String
    var imageData: Data

}
