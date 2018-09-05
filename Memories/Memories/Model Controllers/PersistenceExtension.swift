//
//  PersistenceExtension.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

extension MemoryController {
    
    var memoryURL: URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "Memories.plist"
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    func saveToPersistence() {
        let plistEncoder = PropertyListEncoder()
        do {
            guard let memory = memoryURL else { return }
            let memoriesArray = try plistEncoder.encode(memories)
            try memoriesArray.write(to: memory)
            
        } catch let error {
        print("Error trying to save data! \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistence() {
        do {
            guard let memory = memoryURL else { return }
            let memoriesArray = try Data(contentsOf: memory)
            let plistDecoder = PropertyListDecoder()
            let decodedMemories = try plistDecoder.decode([Memory].self, from: memoriesArray)
            self.memories = decodedMemories
            
        } catch let error {
            print("Error trying to save data! \(error.localizedDescription)")
        }
    }
}
