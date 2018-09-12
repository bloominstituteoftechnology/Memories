//
//  Memory.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    var title: String
    var bodyText: String
    var imageData: Data
}
