import UIKit

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memoryController: MemoryController?
    var memory: Memory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    @IBOutlet weak var memoryPhoto: UIImageView!
    
    @IBOutlet weak var memoryName: UITextField!
    
    @IBOutlet weak var memoryDetail: UITextView!
    
    @IBAction func addPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = memoryName.text,
            let bodyText = memoryDetail.text,
            let image = memoryPhoto.image,
        let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        
        if let memory = memory {
            memoryController?.updateMemory(memory: memory, withTitle: title, bodyText: bodyText, imageData: imageData)
            
        } else {
            memoryController?.createMemory(title: title, bodyText: bodyText, imageData: imageData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        memoryPhoto.image = image
    }
    
    private func updateViews() {
        guard let memory = memory else {
            title = "Add Memory"
            return
        }
        
        title = "Edit Memory"
        let photoImage = UIImage(data: memory.imageData)
        
        memoryPhoto.image = photoImage
        memoryName.text = memory.title
        memoryDetail.text = memory.bodyText
    }
}
