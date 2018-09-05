//
//  MemoryController.swift
//  Memories
//
//  Created by Dillon McElhinney on 9/5/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class MemoryController {
    // MARK: - Properties
    private(set) var memories: [Memory] = []
    
    // MARK: - Initializers
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD Methods
    //Create new memory
    func createMemory(withTitle title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        
        memories.append(memory)
        saveToPersistentStore()
    }
    
    //Update existing memory
    func update(_ memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        saveToPersistentStore()
    }
    
    //Delete memory
    func delete(_ memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        
        memories.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    //Computed property to hold the URL for the memories file.
    var persistentFileURL: URL? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let memoriesFile = "memories.plist"
        
        return documentsURL.appendingPathComponent(memoriesFile)
    }
    
    //Method to encode memories and write them to disk
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else {
            NSLog("Couldn't unwrap persistentFileURL for some reason")
            return
        }
        let plistEncoder = PropertyListEncoder()
        
        do {
            let memoriesData = try plistEncoder.encode(memories)
            try memoriesData.write(to: url)
        } catch {
            NSLog("There was an error encoding memories: \(error)")
        }
    }
    
    //Method to load memories data from disk and decode it into memories array
    private func loadFromPersistentStore() {
        guard let url = persistentFileURL,
            FileManager.default.fileExists(atPath: url.path) else {
                NSLog("Either there is no file at the path (if it is first time launching app), or the persistentFileURL couldn't be unwrapped for some reason.")
                return
        }
        let plistDecoder = PropertyListDecoder()
        
        do {
            let memoriesData = try Data(contentsOf: url)
            memories = try plistDecoder.decode([Memory].self, from: memoriesData)
        } catch {
            NSLog("There was an error decoding memories: \(error)")
        }
    }
}
