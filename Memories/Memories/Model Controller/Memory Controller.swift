//
//  Memory Controller.swift
//  Memories
//
//  Created by Iyin Raphael on 8/8/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation


class MemoryController{
    
    //MARK:- CRUD
    
    func createMemory(title: String, bodyText: String, imageData: Data){
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistence()
    }
    
    func updateMemory(memory: Memory, title: String, bodyText: String, imageData: Data){
        guard let index = memories.index(of: memory) else {return}
        var scratch = memory
        scratch.title = title
        scratch.bodyText = bodyText
        scratch.imageData = imageData
        memories.remove(at: index)
        memories.insert(scratch, at: index)
        saveToPersistence()
    }
    
    func delete(memory: Memory){
        guard let index = memories.index(of: memory) else {return}
        memories.remove(at: index)
        saveToPersistence()
    }
    
    
    var memories = [Memory]()
    
}

