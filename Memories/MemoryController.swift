import UIKit

class MemoryController {
    var memories: [Memory] = []
    
    var persistentFileURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "memories.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    func saveToPersistenStore() {
        let plistEncoder = PropertyListEncoder()
        
        do {
            let memoriesData = try plistEncoder.encode(memories)
            guard let memoriesFileURL = persistentFileURL else { return }
            try memoriesData.write(to: memoriesFileURL)
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let memoriesFileURL = persistentFileURL,
                FileManager.default.fileExists(atPath: memoriesFileURL.path) else { return }
            
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            let plistDecoder = PropertyListDecoder()
            self.memories = try plistDecoder.decode([Memory].self, from: memoriesData)
        } catch {
            NSLog("Error decoding memories: \(error)")
        }
    }
}
