//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Linh Bouniol on 8/1/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory: Memory? {
        didSet {
            updateViews()
        }
    }
    
    var memoryController: MemoryController?

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBAction func addPhoto(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                if authorizationStatus == .authorized {
                    self.presentImagePickerController()
                }
            }
        case .denied:
            let alert = UIAlertController(title: "Denied", message: "Memories does not have access to your photo library. Please go to Settings and grant Memories access.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .restricted:
            let alert = UIAlertController(title: "Restricted", message: "Memories was restricted from accessing your photo library.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
//        if authorizationStatus == .authorized {
//            presentImagePickerController()
//        } else if authorizationStatus == .notDetermined {
//            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
//                if authorizationStatus == .authorized {
//                    self.presentImagePickerController()
//                }
//            }
//        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        // Make sure all properties exist
        guard let title = textField.text, let bodyText = textView.text, let imageData = UIImagePNGRepresentation(imageView.image!)  else { return }
        
        if let memory = memory {
            memoryController?.update(memory: memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
            memoryController?.createMemory(withTitle: title, bodyText: bodyText, imageData: imageData)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        // Take memory and unwrap it
        if memory == nil {
            navigationItem.title = "Add Memory"
        } else {
            guard let memory = memory else { return }
            navigationItem.title = "Edit Memory"
            textField?.text = memory.title
            textView?.text = memory.bodyText
            imageView?.image = UIImage(data: memory.imageData)
        }
    }

    // MARK: - UIImagePickerControllerDelegate
    
    func presentImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        // Get image user picked
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imageView.image = image
    }
}









