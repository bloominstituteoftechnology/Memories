import Foundation

class MemoryController{
    var memories: [Memory] = []
    
    //add persistentFileURL
    let url = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")

//create saveToPersistentStore()
    func saveToPersistentStore(){
        let encoder = JSONEncoder()
        do {
            let encodedMemories = try encoder.encode(memories) //encode the memories array
            try encodedMemories.write(to: url) //write data to device storage
        } catch {
            print("Error: \(error)")
    }
}

//create loadFromPersistentStore()
    func loadFromPersistentStore() {
        do {
            let decoder = JSONDecoder()
            let memoriesData = try Data(contentsOf: url) // get plist data from persistentFileURL
            let decodedMemories = try decoder.decode([Memory].self, from: memoriesData) //decode memories plist data back to array of Memory object
            memories = decodedMemories // set memories variable to newly decoded Memory object
        } catch {
            print("Error: \(error)")
    }
}

//create method to initialize Memory object
    func createMemory(with title: String, bodyText: String, imageData: Data){
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData) //takes necessary parameter to initialize Memory object
        memories.append(memory) //apends it to memories variable
        saveToPersistentStore()
    }

//update method updates Memory object
    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        let newMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.insert(newMemory, at: index)
        saveToPersistentStore()
    }

//delete method deletes Memory object
    func deleteMemory(memory: Memory){
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        saveToPersistentStore()
    }
}
