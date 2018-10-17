import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var memoryController : MemoryController?
    var memory: Memory?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
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
            let imgData = image.pngData() else { return }
        
        guard let memory = memory else {
            memoryController.createMemory(with: titleText, bodyText: bodyText, imageData: imgData)
            navigationController?.popViewController(animated: true)
            return
        }
        memoryController.update(memory: memory, title: titleText, bodyText: bodyText, imageData: imgData)
        navigationController?.popViewController(animated: true)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        guard let memory = memory else { return }
        title = memory.title
        textField.text = memory.title
        textView.text = memory.bodyText
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
    
}

