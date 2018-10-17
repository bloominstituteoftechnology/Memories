import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    func updateViews() {
        guard let memory = memory else { return }
        title = memory.title
        textField.text = memory.title
        textView.text = memory.bodyText
        guard let memoryPhoto = UIImage(data: memory.imageData) else { return }
        imageView.image = memoryPhoto
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
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
        guard let image = info[.originalImage] as? UIImage else {return}
        imageView.image = image
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
        default:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.presentImagePickerController()
                }
            }
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let memoryController = memoryController else { return }
        guard let titleText = textField.text,
            let bodyText = textView.text,
            let image = imageView.image,
            let imageData = image.pngData() else { return }
        
        guard let memory = memory else {
            memoryController.createMemory(title: titleText, bodyText: bodyText, imageData: imageData)
            navigationController?.popViewController(animated: true)
            return
        }
        memoryController.updateMemory(m: memory, title: titleText, bodyText: bodyText, imageData: imageData)
        navigationController?.popViewController(animated: true)
    }
}

