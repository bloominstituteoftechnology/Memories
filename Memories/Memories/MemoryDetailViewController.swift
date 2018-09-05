//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Moin Uddin on 9/5/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    func updateViews() {
        if let memory = memory {
            photoImageView.image = UIImage(data: memory.imageData)
            title = memory.title
            bodyTextView.text = memory.bodyText
            titleTextField.text = memory.title
        } else {
            title = "New Memory"
            return
        }
    }
    

    @IBAction func addPhoto(_ sender: Any) {
            let preservedStatus = PHPhotoLibrary.authorizationStatus()
            switch preservedStatus {
            case .authorized:
                self.presentImagePickerController()
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if newStatus == .authorized {
                        self.presentImagePickerController()
                    } else {
                        return
                    }
                })
            default:
                return
            }
        
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text,
            let photo = photoImageView.image,
            let photoData = UIImageJPEGRepresentation(photo, 1.0)
            else { return }
        if let memory = memory {
            memoryController?.update(memory: memory, with: title, bodyText: bodyText, imageData: photoData)
        } else {
            memoryController?.createMemory(with: title, bodyText: bodyText, imageData: photoData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        photoImageView.image = image
        
    }
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    
    
    
    
    var memoryController: MemoryController?
    var memory: Memory?
}
