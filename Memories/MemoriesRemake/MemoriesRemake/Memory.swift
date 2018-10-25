import Foundation

struct Memory: Codable, Equatable {
    var title: String
    var bodyText: String
    var imageData: Data
    
    init(title: String, bodyText: String, imageData: Data) {
        self.title = title
        self.bodyText = bodyText
        self.imageData = imageData
    }
}
