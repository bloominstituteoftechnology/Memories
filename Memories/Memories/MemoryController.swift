//
//  MemoryController.swift
//  Memories
//
//  Created by Daniela Parra on 9/5/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class MemoryController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func create(title: String, bodyText: String, imageData: Data) {
        
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        
        saveToPersistentStore()
    }
    
    func update(memory: Memory, title: String, bodyText: String, imageData: Data){
        
        guard let index = memories.index(of: memory) else { return }
        
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        
        saveToPersistentStore()
    }
    
    func delete(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        
        memories.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func loadFromPersistentStore() {
        
        do {
            guard let persistentFileURL = persistentFileURL,
                FileManager.default.fileExists(atPath: persistentFileURL.path) else { return }
            
            let memoriesData = try Data(contentsOf: persistentFileURL)
            
            let plistDecoder = PropertyListDecoder()
            
            self.memories = try plistDecoder.decode([Memory].self, from: memoriesData)
        } catch {
            NSLog("Error decoding memories:\(error)")
        }
        
    }
    
    func saveToPersistentStore() {
        let plistEncoder = PropertyListEncoder()
        
        do {
            let memoriesData = try plistEncoder.encode(memories)
            
            guard let persistentFileURL = persistentFileURL else { return }
            
            try memoriesData.write(to: persistentFileURL)
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    
    var persistentFileURL: URL? {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "memories.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    private(set) var memories: [Memory] = []
}
