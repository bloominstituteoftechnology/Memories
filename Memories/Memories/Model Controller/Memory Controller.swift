//
//  Memory Controller.swift
//  Memories
//
//  Created by Iyin Raphael on 8/8/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation


class MemoryController{
    
    var memories: [Memory] = []
    
    //Add a persistenceFileURl computed property that uses fileManager class
    var memoryURL: URL?{
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
            let fileName = "ReadingList(Persistence).plist"
            return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func saveToPersistence(){
        let plistEnconder = PropertyListEncoder()
        
        do{
            guard let memory = memoryURL else {return}
            let memoryData = try plistEnconder.encode(memories)
            try memoryData.write(to: memory)
        }catch let error{
            print("error trying to save data! \(error.localizedDescription)")
            
        }
    }
    
    func loadToPersistence(){
        do{
            guard let memory = memoryURL else {return}
            let memoryData = try Data(contentsOf: memory)
            let plistDecoder = PropertyListDecoder()
            let decodedMemory = try plistDecoder.decode([Memory].self, from: memoryData)
            self.memories = decodedMemory
        }catch let error{
            print("error trying to save data! \(error.localizedDescription)")
            
        }
    }
    
    func createMemory(title: String, bodyText: String, imageData: Data){
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistence()
    }
    
    func updateMemory(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else {return}
        var scratch = memory
        scratch.title = title
        scratch.bodyText = bodyText
        scratch.imageData = imageData
        memories.remove(at: index)
        memories.insert(scratch, at: index)
        saveToPersistence()
    }
}
