//
//  MemoryController.swift
//  Memories
//
//  Created by Nikita Thomas on 10/16/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

class MemoryController {
    static let shared = MemoryController()
    var memories = [Memory]()
    
    // Technically the correct way to do it...
//    var url: URL? {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        let fileName = "memories.json"
//        return documentDirectory?.appendingPathComponent(fileName)
//    }
    
    var url = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")

    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let encodedMemories = try encoder.encode(memories)
            try encodedMemories.write(to: url)
        } catch {
            print("Error: \(error)")
        }
    }

    
    
    func loadFromPersistentStore() {
        do {
            let decoder = JSONDecoder()
            let memoriesData = try Data(contentsOf: url)
            let decodedMemories = try decoder.decode([Memory].self, from: memoriesData)
            memories = decodedMemories
        } catch {
            print("Error: \(error)")
        }
    }
    
    func create(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.firstIndex(of: memory) else {return}
        let newMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        
        memories[index] = newMemory
        saveToPersistentStore()
    }
    
    func delete(memory: Memory) {
        guard let index = memories.firstIndex(of: memory) else {return}
        memories.remove(at: index)
        saveToPersistentStore()
    }
    
}
