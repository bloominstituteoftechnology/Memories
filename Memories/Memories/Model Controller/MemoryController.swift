//
//  MemoryController.swift
//  Memories
//
//  Created by Linh Bouniol on 8/1/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class MemoryController {
    
    // MARK: - CRUD
    
    var memories: [Memory] = []
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        
        guard let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documentDirectory.appendingPathComponent("memories.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    func createMemory(withTitle title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        
        saveToPersistentStore()
    }
    
    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        
        var memory = memory
        memory.title = title
        memory.bodyText = bodyText
        memory.imageData = imageData
        
        memories.remove(at: index)
        memories.insert(memory, at: index)
        
        saveToPersistentStore()
    }
    
    func delete(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        
        saveToPersistentStore()
    }
    
    
    
    // MARK: - Archiving
    
    // Archiving
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(memories)
            try data.write(to: url)
            
        } catch {
            NSLog("Error saving memories data \(error)")
        }
    }
    
    // Unarchiving
    func loadFromPersistentStore() {
        let fm = FileManager.default
        
        do {
            guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedMemories = try decoder.decode([Memory].self, from: data)
            memories = decodedMemories
            
        } catch {
            NSLog("Error saving memories data \(error)")
        }
    }
    
    
}
