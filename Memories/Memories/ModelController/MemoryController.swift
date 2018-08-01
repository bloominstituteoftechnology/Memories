//
//  MemoryController.swift
//  Memories
//
//  Created by Simon Elhoej Steinmejer on 01/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation


class MemoryController
{
    //MARK: - Properties
    
    private(set) var memories = [Memory]()
    private var persistentFileURL: URL?
    {
        let fm = FileManager.default
        guard let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent("memories.plist")
    }
    
    //MARK: - Persistence
    
    init()
    {
        loadFromPersistence()
    }
    
    
    func saveToPersistence()
    {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(memories)
            try data.write(to: url)
        } catch {
            NSLog("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistence()
    {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            memories = try decoder.decode([Memory].self, from: data)
        } catch {
            NSLog("Error loading memories: \(error)")
        }
        
    }
    
    //MARK: - Model helper functions
    
    func createMemory(with title: String, bodyText: String, imageData: Data)
    {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistence()
    }
    
    func updateMemory(on memory: Memory, title: String, bodyText: String, imageData: Data)
    {
        if let index = memories.index(of: memory)
        {
            memories[index].title = title
            memories[index].bodyText = bodyText
            memories[index].imageData = imageData
            saveToPersistence()
        }
    }
    
    func deleteMemory(at index: Int)
    {
        memories.remove(at: index)
        saveToPersistence()
    }
    
    
    
}

















