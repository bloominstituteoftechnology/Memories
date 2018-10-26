import Foundation

class Memory: Codable, Equatable {
    var title: String
    var bodyText: String
    var imageData: Data
    
    init(title: String, bodyText: String, imageData: Data) {
        self.title = title
        self.bodyText = bodyText
        self.imageData = imageData
    }
    static func ==(lhs: Memory, rhs: Memory) -> Bool {
        return lhs.title == rhs.title &&
            lhs.bodyText == rhs.bodyText &&
            lhs.imageData == rhs.imageData
    }
}
