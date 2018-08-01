//
//  MemoryController.swift
//  Memories
//
//  Created by De MicheliStefano on 01.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

class MemoryController {
    
    // MARK: - Methods
    
    func create(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        var memory = memories[index]
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
    
    // MARK: - Persistence
    
    private func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        guard let url = persistentFileURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode([Memory].self, from: data)
            memories = decodedData
        } catch {
            NSLog("Error while loading data from persistence: \(error)")
        }
        
    }
    
    private func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = persistentFileURL else { return }
        
        do {
            let encodedData = try encoder.encode(memories)
            try encodedData.write(to: url)
        } catch {
            NSLog("Error while saving data to persistence: \(error)")
        }
        
    }
    
    // MARK: - Properties
    
    private var persistentFileURL: URL? {
        let fm = FileManager()
        let fileName = "memories.plist"
        
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent(fileName)
    }
    
    var memories: [Memory] = []
    
}
