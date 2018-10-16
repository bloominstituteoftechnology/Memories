import Foundation

class MemoryController {
    var memories: [Memory] = []
    
    init() { loadFromPersistentStore() }
    
    // This creates the memory.
    func createMemory(with title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        
        saveToPersistentStore()
    }
    
    // This updates the memory
    func update(memory: Memory, title: String, bodyType: String, imageData: Data) {
        guard let index = memories.index(of: memory) else { return }
        
        let tempMemory = Memory(title: title, bodyText: bodyType, imageData: imageData)
        
        memories.remove(at: index)
        memories.insert(tempMemory, at: index)
        
        saveToPersistentStore()
    }
    
    // Deletes the memory
    func delete(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        
        saveToPersistentStore()
    }
    
    // Keeps data when app is closed
    private func saveToPersistentStore() {
        let plistEncoder = PropertyListEncoder()
        do {
            guard let memoriesFileURL = persistentFileURL,
                FileManager.default.fileExists(atPath: memoriesFileURL.path) else { return }
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            let plistDecoder = PropertyListDecoder()
            self.memories = try plistDecoder()
        } catch {
            NSLog("Error Decoding Memories: \(error)")
        }
    }
}

