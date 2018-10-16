import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var memory: Memory?
    var memoryController: MemoryController?
    
    private func updateViews() {
        guard let memory = memory else { return }
        title = memory.title
        memoryTitleField.text = memory.title
        memoryText.text = memory.bodyText
        
        guard let memoryImage = UIImage(data: memory.imageData) else { return }
        memoryPhoto.image = memoryImage
    }
    
    private func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else { return }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        memoryPhoto.image = image
    }
   
    @IBOutlet weak var memoryPhoto: UIImageView!
    @IBOutlet weak var memoryTitleField: UITextField!
    @IBOutlet weak var memoryText: UITextView!
    
    @IBAction func addPhoto(_ sender: Any) {
        
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
