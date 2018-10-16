//
//  DetailViewController.swift
//  Memories
//
//  Created by Nikita Thomas on 10/16/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory: Memory?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
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

        guard let title = textField.text else {return}
        guard let text = textView.text else {return}
        guard let image = imageView.image?.pngData() else {return}
        if memory == nil {
            MemoryController.shared.create(title: title, bodyText: text, imageData: image)
        } else {
            if let memory = memory {
                MemoryController.shared.update(memory: memory, title: title, bodyText: text, imageData: image)
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

    
    func updateViews() {
        if memory == nil {
            self.title = "Add Memory"
        } else {
            guard let hasMemory = memory else {return}
            self.title = "Edit Memory"
            imageView.image = UIImage(data: hasMemory.imageData)
            textField.text = hasMemory.title
            textView.text = hasMemory.bodyText
        }
    }
    
    
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
    }
    
}
