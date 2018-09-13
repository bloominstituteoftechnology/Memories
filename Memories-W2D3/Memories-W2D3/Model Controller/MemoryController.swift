//
//  MemoryController.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MemoryController {
    
    // MARK: - Properties
    
    var memories = [Memory]()
    
    //MARK: - Computed properties
    
    var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let documentDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDir.appendingPathComponent("memories.plist")
    }
    
    // MARK: - Persistence functions
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let plistEncoder = PropertyListEncoder()
            let data = try plistEncoder.encode(memories)
            try data.write(to: url)
        } catch {
            NSLog("Error saving data to persistent store: \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let plistDecoder = PropertyListDecoder()
            memories = try plistDecoder.decode([Memory].self, from: data)
            
        } catch {
            NSLog("Error loading data from persistent store: \(error)")
        }
    }
    
    // MARK: - Initializer
    
    init(){
        loadFromPersistentStore()
    }
    
    
    // MARK: - CRUD methods
    
    func createMemory(title: String, bodyText: String, imageData: Data) {
        let newMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(newMemory)
        
        saveToPersistentStore()
    }
    
    func updateMemory(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        
        saveToPersistentStore()
    }
    
    func deleteMemory(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        
        saveToPersistentStore()
    }
    
}
