import Foundation

class MemoryController {
    
    // Array of memories with type Memory
    var memories: [Memory] = []

    init() { loadFromPersistentStore() }
    
    // URL set to filename memories.plist
//    var persistentFileURL: URL? {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        let fileName = "memories.plist"
//        return documentDirectory?.appendingPathComponent(fileName)
//    }
    
    var persistentFileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")
    
    // Creates the memory
    func createMemory(with title: String, bodyText: String, imageData: Data) {
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
    
    // Deletes memory
    func delete(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        saveToPersistentStore()
    }
    
    // Persistence so when app closes the data is persistent
//    private func saveToPersistentStore() {
//        let plistEncoder = PropertyListEncoder()
//        do {
//            let memoriesData = try plistEncoder.encode(memories)
//            guard let memoriesFileURL = persistentFileURL else { return }
//            try memoriesData.write(to: memoriesFileURL)
//        } catch {
//            NSLog("Error encoding memories: \(error)")
//        }
//    }
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let encodedMemories = try encoder.encode(memories)
            try encodedMemories.write(to: persistentFileURL)
        } catch {
            print("Error: \(error)")
        }
    }
    
    // Loads persistence...
//    private func loadFromPersistentStore() {
//        do {
//            guard let memoriesFileURL = persistentFileURL,
//                FileManager.default.fileExists(atPath: memoriesFileURL.path) else { return }
//            let memoriesData = try Data(contentsOf: memoriesFileURL)
//            let plistDecoder = PropertyListDecoder()
//            self.memories = try plistDecoder.decode([Memory].self, from: memoriesData)
//        } catch {
//            NSLog("Error decoding memories: \(error)")
//        }
//    }
    func loadFromPersistentStore() {
        do {
            let decoder = JSONDecoder()
            let memoriesData = try Data(contentsOf: persistentFileURL)
            let decodedMemories = try decoder.decode([Memory].self, from: memoriesData)
            memories = decodedMemories
        } catch {
            print("Error: \(error)")
        }
    }
}
