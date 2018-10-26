import Foundation

class MemoryController {
    
    init() {
        loadToPersistence()
    }
    func createMemory(title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistence()
        
    }
          
            func updateMemory(memory: Memory, withTitle title: String, bodyText: String, imageData: Data) {
            memory.title = title
            memory.bodyText = bodyText
            memory.imageData = imageData
                saveToPersistence()
                
            }
            
            func deleteMemoryAt(index: Int) {
                memories.remove(at: index)
                saveToPersistence()
            }
            
            private func loadToPersistence() {
                do {
                    let memoriesData = try Data(contentsOf: memoriesFileURL)
                    let decoder = JSONDecoder()
                    let decodedMemories = try decoder.decode([Memory].self, from: memoriesData)
                    
                    memories = decodedMemories
                } catch {
                    NSLog("Error decoding memories: \(error)")
                }
            }
            
            private func saveToPersistence() {
                let encoder = JSONEncoder()
                do {
                    let memoriesData = try encoder.encode(memories)
                    try memoriesData.write(to: memoriesFileURL)
            
                } catch {
                    NSLog("Error encoding memories: \(error)")
                }
            }

            var memoriesFileURL = URL(fileURLWithPath: NSHomeDirectory())
                .appendingPathComponent("Documents")
                .appendingPathComponent("memories.json")
            
            var memories: [Memory] = []
        }


