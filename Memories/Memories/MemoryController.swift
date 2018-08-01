//
//  MemoryController.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class MemoryController {
    func saveToPersistentStore() {
        do {
            guard let url = persistentFileURL else { return }
            let encoder = PropertyListEncoder()
            let memoriesData = try encoder.encode(memories)
            try memoriesData.write(to: url)
        } catch {
            NSLog("\(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = persistentFileURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            memories = try decoder.decode([Memory].self, from: data)
        } catch {
            NSLog("\(error)")
        }
    }
    
    var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else  { return nil }
        return docDir.appendingPathComponent("Memories.plist")
    }
    
    var memories: [Memory] = []
}
