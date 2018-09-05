//
//  MemoryController.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

class MemoryController {
    
    func create(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        
        memories.append(memory)
        saveToPersistence()
    }
    
    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        
        var scratch = memory
        scratch.title = title
        scratch.bodyText = bodyText
        scratch.imageData = imageData
        
        memories.remove(at: index)
        memories.insert(scratch, at: index)
        saveToPersistence()
    }
    
    func delete(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        
        memories.remove(at: index)
        saveToPersistence()
    }
    
    var memories: [Memory] = []
    
}
