//
//  MemoryController.swift
//  Memories
//
//  Created by Yvette Zhukovsky on 10/16/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation


class MemoryController {
    var memories: [Memory] = []
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let dd = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return dd.appendingPathComponent("memories.plist")
    }
    
    func saveToPersistentStore(){
        
        
        do {
            guard let url = readingListURL else {return}
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(memories)
            try data.write(to: url)
        }
        catch {
            NSLog("error saving data:\(error)")
        }
        
    }
    
    
    func loadFromPersistentStore() {
        
        let fm = FileManager.default
        
        do {
            guard let url = readingListURL else {return}
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            memories  = try decoder.decode([Memory].self, from: data)
            
        }
        catch{
            NSLog("error loading data:\(error)")
            
        }
        
    }
    
    func Create(title:String, bodyText: String, imageData: Data)
    {
        
        memories.append(Memory(title: title, bodyText: bodyText, imageData: imageData))
        saveToPersistentStore()
        
    }
    
    func Update(m:Memory, title:String, bodyText: String, imageData: Data) {
        for var i in memories {
            if i.title == m.title {
                i.title = title
                i.bodyText = bodyText
                i.imageData = imageData
                return
            }
            
        }
        
        saveToPersistentStore()
    }
    
    func Delete(m:Memory, title:String, bodyText: String, imageData: Data) {
        for index in 0..<memories.count {
            if memories[index].title == m.title {
                memories.remove(at: index)
                return
                    saveToPersistentStore()
                
            }
        }
    }
    
    
    
}

