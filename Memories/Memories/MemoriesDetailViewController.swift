import UIKit

class MemoriesDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
      //  super.viewDidLoad()
            updateViews()
    }

    var memoryController: MemoryController?
    var memory: Memory?

    @IBOutlet weak var memoryImage: UIImageView!
    @IBOutlet weak var memoryField: UITextField!
    @IBOutlet weak var memoryView: UITextView!
    
 @IBAction func saveWasTapped(_ sender: Any) {
    guard let title = memoryField.text,
            let bodyText = memoryView.text,
            let image = memoryImage.image,
            let imageData = image.pngData() else { return }
       
        if let memory = memory {
            memoryController?.updateMemory(memory: memory, withTitle: title, bodyText: bodyText, imageData: imageData)
        } else {
            memoryController?.createMemory(title: title, bodyText: bodyText, imageData: imageData)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhotoWasTapped(_ sender: Any) {
    let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        memoryImage.image = image
    }
    
    private func updateViews() {
        guard let memory = memory else {
            title = "Add Memory"
            return
        }
        
        title = "Edit Memory"
        
        let photoImage = UIImage(data: memory.imageData)
        memoryImage.image = photoImage
        memoryField.text = memory.title
        memoryView.text = memory.bodyText
        
    }
    
}
