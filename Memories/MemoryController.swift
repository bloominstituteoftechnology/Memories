//
//  MemoryController.swift
//  Memories
//
//  Created by Spencer Curtis on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MemoryController {

    init() {
        loadFromPersistentStore()
    }
    
    func createMemory(with title: String, bodyText: String, imageData: Data) {
        
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        
        memories.append(memory)
        
        saveToPersistentStore()
    }
    
    func update(memory: Memory, with title: String, bodyText: String, imageData: Data) {
        
        guard let index = memories.index(of: memory) else { return }
        
        var scratch = memory
        
        scratch.title = title
        scratch.bodyText = bodyText
        scratch.imageData = imageData
        
        memories.remove(at: index)
        memories.insert(scratch, at: index)
        
        saveToPersistentStore()
    }
    
    func delete(memory: Memory) {
        
        guard let index = memories.index(of: memory) else { return }
        
        memories.remove(at: index)
     
        saveToPersistentStore()
    }
    
    private func saveToPersistentStore() {
        
        let plistEncoder = PropertyListEncoder()
        
        do {
            let memoriesData = try plistEncoder.encode(memories)
            
            guard let memoriesFileURL = memoriesFileURL else { return }
            
            try memoriesData.write(to: memoriesFileURL)
            
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        
        do {
    
            guard let memoriesFileURL = memoriesFileURL,
                FileManager.default.fileExists(atPath: memoriesFileURL.path) else { return }
            
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            
            let plistDecoder = PropertyListDecoder()
            
            self.memories = try plistDecoder.decode([Memory].self, from: memoriesData)
            
        } catch {
            NSLog("Error decoding memories: \(error)")
        }
    }
    
    private var memoriesFileURL: URL? {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "memories.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    private(set) var memories: [Memory] = []
}










