//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Scott Bennett on 9/12/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory: Memory?
    var memoryController: MemoryController?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    
    func updateViews() {
        guard let memory = memory else {
            self.navigationItem.title = "Add Memory"
            return
        }
        self.navigationItem.title = "Edit Memory"
        titleTextField.text = memory.title
        descriptionTextView.text = memory.bodyText
        imageView.image = UIImage(data: memory.imageData)
    }
    

    @IBAction func addPhotoButton(_ sender: Any) {
        let authorizaionStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizaionStatus {
        case .authorized:
            presentImagePickerController()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.presentImagePickerController()
                default:
                    break
                }
            }
        default:
            break
            
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let title = titleTextField.text,
            let bodyText = descriptionTextView.text,
            let image = imageView.image,
            let imageData = UIImagePNGRepresentation(image) else { return }
        
        if let memory = memory {
            memoryController?.updateMemory(with: memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
            memoryController?.createMemory(withName: title, bodyText: bodyText, imageData: imageData)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    // Get image
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
    }
        
    
    
}











