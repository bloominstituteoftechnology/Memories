//
//  MemoryController.swift
//  Memories_userPermission_notifications
//
//  Created by Rick Wolter on 10/16/18.
//  Copyright © 2018 RNWolter. All rights reserved.
//

import Foundation

class MemoryController{
    
    var memories = [Memory]()
    
    var persistentFileURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "memories.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    
    
    
    
    
    func delete(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        
        saveToPersistentStore()
    }

    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else {return}
        let tempMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        
        memories[index] = tempMemory
        
        saveToPersistentStore()
        
    }

    func create(with title: String, bodyText: String, imageData: Data) {
        let memory = Memory( title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    
    
    
    
    
    private func saveToPersistentStore() {
        let plistEncoder = PropertyListEncoder()
        
        do {
            let memoriesData = try plistEncoder.encode(memories)
            guard let memoriesFileURL = persistentFileURL else { return }
            try memoriesData.write(to: memoriesFileURL)
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    private func loadFromPersistentStore() {
        do {
            guard let memoriesFileURL = persistentFileURL,
                FileManager.default.fileExists(atPath: memoriesFileURL.path) else { return }
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            let plistDecoder = PropertyListDecoder()
            self.memories = try plistDecoder.decode([Memory].self, from: memoriesData)
        } catch {
            NSLog("Error decoding memories: \(error)")
        }
    }
}
