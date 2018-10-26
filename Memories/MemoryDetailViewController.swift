import UIKit

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memoryController: MemoryController?
    var memory: Memory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    
    
}
