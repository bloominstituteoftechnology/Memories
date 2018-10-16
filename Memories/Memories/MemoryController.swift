import UIKit

class MemoryController {
    
    //C.R.U.D.
    
    // READ
    var memories: [Memory] = []
    
    // this is a directory on my device for information/data to be saved in
    let url = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")
    
    
    // this is taking the data from memories and saving it into our device/specific folder
    func saveToPersistentStore() {
        do {
            let memoriesEncoded = try JSONEncoder().encode(memories)
            if let string = String(data: memoriesEncoded, encoding: .utf8) {
                print(string)
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    //this takes the information from the device and sets it to memories
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: url)
            let memoriesDecoded = try JSONDecoder().decode([Memory].self, from: data)
            memories = memoriesDecoded
            print(memories)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // creating a memory instances
    
    func createMemory(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    // updates memory
    func updateMemory(m: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: m) else {return}
        
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        
        saveToPersistentStore()
    }
    
    // deletes memory
    func deleteMemory(m: Memory) {
        guard let index = memories.index(of: m) else {return}
        memories.remove(at: index)
    }
}
