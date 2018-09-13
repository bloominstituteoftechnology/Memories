//
//  MemoryController.swift
//  Memories
//
//  Created by Scott Bennett on 9/12/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

class MemoryController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var memories: [Memory] = []
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("Memories.plist")
    }
    
    
    // Save data to device
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let memoriesData = try encoder.encode(memories)
            try memoriesData.write(to: url)
        } catch {
            NSLog("Error saving memories data: \(error)")
        }
    }
    
    
    // Load data from device
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let memoriesData = try Data(contentsOf: url)
            let decodeMemories = try decoder.decode([Memory].self, from: memoriesData)
            memories = decodeMemories
        } catch {
            NSLog("Error loading memories data: \(error)")
        }
    }
    
    
    // Create
    func createMemory(withName title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    
    // Update
    func updateMemory(with memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        saveToPersistentStore()
    }
    
    
    // Delete
    func deleteMemory(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        saveToPersistentStore()
    }


}









