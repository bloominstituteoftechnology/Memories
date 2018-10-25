import Foundation

class Memory: Codable, Equatable {
    
    //listing variables I want my memory
    var title: String
    var bodyText: String
    var imageData: Data
    
    //since it is a class I need to init
    init(title: String, bodyText: String, imageData: Data){
        self.title = title
        self.bodyText = bodyText
        self.imageData = imageData
    }
    
    //need this func since we are using Equatable
    static func == (lhs: Memory, rhs: Memory) -> Bool {
        return lhs.title == rhs.title &&
        lhs.bodyText == rhs.bodyText &&
        lhs.imageData == rhs.imageData
    }
}
