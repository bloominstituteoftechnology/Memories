//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Spencer Curtis on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import Photos
import UserNotifications

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text,
            let photo = photoImageView.image,
            let photoData = UIImageJPEGRepresentation(photo, 1.0) else { return }
        
        if let memory = memory {
            // Update the existing Memory
            memoryController?.update(memory: memory, with: title, bodyText: bodyText, imageData: photoData)
        } else {
            // Create a new Memory
            memoryController?.createMemory(with: title, bodyText: bodyText, imageData: photoData)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let authStatus = PHPhotoLibrary.authorizationStatus()

        if authStatus == .authorized{
            let imagePicker = UIImagePickerController()
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
            }
        } else {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    let imagePicker = UIImagePickerController()
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        imagePicker.sourceType = .photoLibrary
                        imagePicker.delegate = self
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
            }
        }
        // TODO
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        photoImageView.image = image
    }
    
    private func updateViews() {
        
        guard let memory = memory else {
            title = "New Memory"
            return
        }
        
        title = memory.title
        
        titleTextField.text = memory.title
        bodyTextView.text = memory.bodyText
        photoImageView.image = UIImage(data: memory.imageData)
    }
    
    var memoryController: MemoryController?
    var memory: Memory?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    

}
