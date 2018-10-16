import UIKit

class MemoryController: NSObject {
    var memories: [Memory] = []

// add a persistentFileURL
let url = URL(fileURLWithPath: NSHomeDirectory())
    .appendingPathComponent("Documents")
    .appendingPathComponent("memories.plist")

// save
func saveToPersistentStore(){
    do{
        let memoriesEncoded = try JSONEncoder().encode(memories)
        if let string = String(data: memoriesEncoded, encoding: .utf8){
            print(string)
        }
    } catch {
        print ("Error: \(error)")
    }
}

// create load
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

// create and init memory object
// memories.append = memories.saveToPersistentStore()
func createMemory(with title: String, bodyText: String, imageData: Data){
    let memory = Memory.init(title: title, bodyText: bodyText, imageData: imageData)
    memories.append(memory)
    print("decoded")
}


// func delete Memory object
func deleteMemory(memory: Memory){
    guard let index = memories.index(of: memory) else
    { return }
    memories.remove(at: index)
    //saveToPersistentStore()
    }
}
