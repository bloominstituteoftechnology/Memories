import UIKit
import Photos

class MemoryDetailViewController: UIViewController {
    
    var memory: Memory?
    var memoryController = MemoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func addPhotoButton(_ sender: Any) {
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
    }
    
}
