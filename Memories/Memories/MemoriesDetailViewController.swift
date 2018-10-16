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
        if authorizationStatus == .authorized {
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                if authorizationStatus == .authorized {
                    self.presentImagePickerController()
                } else if authorizationStatus == .denied {
                    let alert = UIAlertController(title: "🚨 Memories can't access your photo library", message: "Please allow photo library access to be able to add photos to each of your memories.", preferredStyle: .alert)
                    let goToAction = UIAlertAction(title: "Show Settings", style: .default) { (action) in
                        if let url = URL(string: "app-settings:") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
                    
                    alert.addAction(goToAction)
                    alert.addAction(cancel)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else if authorizationStatus == .denied {
            let alert = UIAlertController(title: "🚨 Memories can't access your photo library", message: "Please allow photo library access to be able to add photos to each of your memories.", preferredStyle: .alert)
            
            let goToAction = UIAlertAction(title: "Show Settings", style: .default) { (action) in
                if let url = URL(string: "app-settings:") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            
            alert.addAction(goToAction)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
