import Foundation


class MemoryController {
    var memories: [Memory] = []
    init() { loadFromPersistentStore() }
    
    // add a persistentFileURL
    let url = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")
    
    // save
    func saveToPersistentStore(){
        let encoder = JSONEncoder()
        do {
            let encodedMemories = try encoder.encode(memories)
            try encodedMemories.write(to: url)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // create load
    func loadFromPersistentStore() {
        do {
            let decoder = JSONDecoder()
            let memoriesData = try Data(contentsOf: url)
            let decodedMemories = try decoder.decode([Memory].self, from: memoriesData)
            memories = decodedMemories
        } catch {
            print("Error: \(error)")
        }
    }
    
    // create and init memory object
    // memories.append = memories.saveToPersistentStore()
    func createMemory(with title: String, bodyText: String, imageData: Data){
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    // Updates the memory
    func update(memory: Memory, title: String, bodyText: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        let tempMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.remove(at: index)
        memories.insert(tempMemory, at: index)
        saveToPersistentStore()
    }
    
    // func delete Memory object
    func deleteMemory(memory: Memory){
        guard let index = memories.index(of: memory) else
        { return }
        memories.remove(at: index)
        saveToPersistentStore()
    }
}
