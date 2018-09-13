//
//  Persistence.swift
//  Memories
//
//  Created by Iyin Raphael on 9/12/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

extension MemoryController{
    
    var memoriesURL: URL?{
        let fm = FileManager.default
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentsDir.appendingPathComponent("memories.plist")
    }
    
    func saveToPersistence(){
        guard let url = memoriesURL else {return}
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(memories)
            try data.write(to: url)
        }catch{
            NSLog("Error saving data: \(error)")
        }
    }
    
    func loadToPersistence(){
        let fm = FileManager.default
        guard let url = memoriesURL, fm.fileExists(atPath: url.path) else {return}
        do{
           let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedMemories = try decoder.decode([Memory].self, from: data)
            memories = decodedMemories
        }catch{
            
        }
    }
    
}
