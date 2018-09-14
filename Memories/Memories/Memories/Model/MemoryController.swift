//
//  MemoryController.swift
//  Memories
//
//  Created by Welinkton on 9/13/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class MemoryController{
    
    // MARK: - CRUD

    
    init(){
        loadFromPersistentStore()
    }
    
    // Reading
    var memories:[Memory] = []
    
    
    // Create
    func createMemory(withName title:String, bodyText:String, imageData:Data) {
        let newMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(newMemory)
        saveToPersistentStore()
    }
    
    // Update
    
    func updateMemory(memory: Memory, title: String, bodyText: String, imageData:Data){
        guard let index = memories.index(of: memory) else {return}
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        saveToPersistentStore()
    }
    
    // Delete
    
    func deleteMemory(memory: Memory){
        guard let index = memories.index(of: memory) else {return}
        memories.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence Functions
    
    
    // we are trying to save the document
    // have to use a specific protocol - encoder
    func saveToPersistentStore() {
        guard let url = persistentFileURL else {return}
        
        do {
            //Create the encoder
            let encoder = PropertyListEncoder()
            
            //Encoded the data
            let data = try encoder.encode(memories)
            
            //write the data to disk (specific file)
            try data.write(to: url)
            
        } catch  {
            
            // this stores in the users' log for errors
            NSLog("Error saving memories data: \(error)")
            
        }
    }
    
    // we are now going to do the opposite
    // decoder
    func loadFromPersistentStore() {
        
        // create the filemanager
        let fm = FileManager.default
        
        // created the url
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else {return}
        
        do {
            // create the Decoder
            let decoder = PropertyListDecoder ()
            
            // reference the data that was stored above
            let data = try Data(contentsOf: url)
            
            // end of the decoder
            memories = try decoder.decode([Memory].self, from: data)
            
        } catch  {
            
            // this stores in the users' log for errors
            NSLog("Error loading memories data: \(error)")
            
        }
    }
    
    // MARK: - Computed Properties
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory , in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("memories.plist")
    }
    
}
