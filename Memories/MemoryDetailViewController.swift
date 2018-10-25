import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory: Memory?
    var memoryController : MemoryController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var photoTitle: UITextField!
    
    @IBOutlet weak var photoText: UITextView!
    
    @IBAction func addButton(_ sender: Any) {
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
        guard let titleText = photoTitle.text,
            let bodyText = photoText.text,
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
    
    //unwrapping the memory object
    func updateViews() {
        guard let memory = memory else { return }
        title = memory.title
        photoTitle.text = memory.title
        photoText.text = memory.bodyText
        guard let memoryImage = UIImage(data: memory.imageData) else { return }
        imageView.image = memoryImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
