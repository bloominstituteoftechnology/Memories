//
//  MemoryController.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation
import UIKit

class MemoryController
{
    private(set) var memories: [Memory] = []
    
    private var persistentFileURL: URL?
    {
        let fileManager = FileManager.default
        guard let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return docDir.appendingPathComponent("memories.plist")
    }
    
    func saveToPersistentStore()
    {
        guard let url = persistentFileURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(memories)
            try data.write(to: url)
            print("save to persistent store: \(url)")
        } catch {
            NSLog("Error saving memories data: \(error)")
        }
    }
    
    func loadFromPersistentStore()
    {
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else {return}
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            memories = try decoder.decode([Memory].self, from: data)
            print("loaded from peristent store: \(memories)")
        } catch {
            NSLog("Error loading memories data: \(error)")
        }
    }
    
    func createMemory(title: String, bodyText: String, imageData: Data)
    {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        print(memory)
        saveToPersistentStore()
    }
    
    func updateMemory(memory: Memory, title: String, bodyText: String, imageData: Data)
    {
        if let index = memories.index(of: memory)
        {
            var tempMemory = memory
            tempMemory.title = title
            tempMemory.bodyText = bodyText
            tempMemory.imageData = imageData
            
            memories.remove(at: index)
            memories.insert(tempMemory, at: index)
            print(tempMemory)
            saveToPersistentStore()
        }
        
        
    }
    
    func deleteMemory(memory: Memory)
    {
        guard let index = memories.index(of: memory) else {return}
        memories.remove(at: index)
        print(memory)
        saveToPersistentStore()
    
        
    }
    
    
    
    
    
    
}
