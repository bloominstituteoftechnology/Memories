//
//  MemoryController.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class MemoryController {
    func createMemory(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
    }

    func updateMemory(memory: Memory) {
        if let index = memories.index(of: memory) {
            var scratch = memories[index]
            scratch.bodyText = memory.bodyText
            scratch.imageData = memory.imageData
            scratch.title = memory.title

            memories.remove(at: index)
            memories.insert(scratch, at: index)

            saveToPersistentStore()
        }
    }

    func deleteMemory(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
    }

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
        guard let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return docDir.appendingPathComponent("Memories.plist")
    }

    var memories: [Memory] = []
}
