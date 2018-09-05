//
//  Memory.swift
//  Memories
//
//  Created by Dillon McElhinney on 9/5/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    
    // MARK: - Properties
    var title: String
    var bodyText: String
    var imageData: Data
}
