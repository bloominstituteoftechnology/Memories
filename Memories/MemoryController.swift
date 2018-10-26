import Foundation

class MemoryController {
    var memories: [Memory] = []
    
    // initializer where each time the phone reloads it loads the persistence
    init() {
        loadFromPersistence()
    }
    
    // create memory func using variables from Memory
    func createMemory(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistence()
    }
    
    // update memory with what was put into title, bodyText, and imageData
    func updateMemory(memory: Memory, withTitle title: String, bodyText: String, imageData: Data){
        memory.title = title
        memory.bodyText = bodyText
        memory.imageData = imageData
        saveToPersistence()
    }
    
    // this swipes deletes func on cell you want to delete
    func deleteMemoryAt(index: Int) {
        memories.remove(at: index)
        saveToPersistence()
    }
    
    //load persisitence
    private func loadFromPersistence() {
        do {
            //letting the memoriesData come from the URL
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            //calling jsondecoder func as the decoder
            let decoder = JSONDecoder()
            let decodedMemories = try decoder.decode([Memory].self, from: memoriesData)
            
            //memories are the memories that have been decoded or pass through the do
            memories = decodedMemories
        } catch {
            //error is logged if it fails to decode
            NSLog("Error decoding memories: \(error)")
        }
    }
    
    //save persistence
    private func saveToPersistence() {
        let encoder = JSONEncoder()
        
        do {
            let memoriesData = try encoder.encode(memories)
            //saves memoryData back to URL
            try memoriesData.write(to: memoriesFileURL)
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    
    //these are the files used in saving and loading persistence
    var memoriesFileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")
    
}
