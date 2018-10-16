import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    private func updateViews() {
        guard let memory = memory else { return }
        title = memory.title
        titleTextField.text = memory.title
        bodyTextField.text = memory.bodyText
        guard let memoryImage = UIImage(data: memory.imageData) else { return }
        imageView.image = memoryImage
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
    
    @IBAction func addPhoto(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
//        case .denied:
//            navigationController?.popViewController(animated: T##Bool)
        default:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.presentImagePickerController()
                }
            }
        }
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        guard let memoryController = memoryController else { return }
        guard let titleText = titleTextField.text,
            let bodyText = bodyTextField.text,
            let image = imageView.image,
            let imgData = image.pngData() else { return }
        
        guard let memory = memory else {
            memoryController.createMemory(with: titleText, bodyText: bodyText, imageData: imgData)
            navigationController?.popViewController(animated: true)
            return
        }
        memoryController.update(memory: memory, title: titleText, bodyText: bodyText, imageData: imgData)
        navigationController?.popViewController(animated: true)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }
}
