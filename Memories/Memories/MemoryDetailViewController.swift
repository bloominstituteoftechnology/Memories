//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Daniela Parra on 9/5/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        guard let memory = memory else {
            title = "Add Memory"
            return
        }
        
        title = "Edit Memory"
        
        titleTextField.text = memory.title
        bodyTextView.text = memory.bodyText
        imageView.image = UIImage(data: memory.imageData)
    }
    
    func presentImagePickerController() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.sourceType = .photoLibrary
            
            imagePicker.delegate = self
            
            present(imagePicker,animated: true, completion: nil)
            
        } else {
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        imageView.image = image
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text,
            let image = imageView.image,
            let imageData = UIImagePNGRepresentation(image) else { return }
        
        if let memory = memory {
            memoryController?.update(memory: memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
            memoryController?.create(title: title, bodyText: bodyText, imageData: imageData)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .authorized {
            presentImagePickerController()
        } else if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                if authorizationStatus == .authorized {
                    self.presentImagePickerController()
                } else if authorizationStatus == .denied {
                    self.setDeniedAlert()
                    
                }
            }
        }
    }
    
    private func setDeniedAlert(){
        let deniedAlert = UIAlertController(title: "Oh no! You denied notifications.", message: "To allow for notifications, please go your settings and manually change notification settings to 'Allow'", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default , handler: nil)
        
        deniedAlert.addAction(dismissAction)
        
        let goToSettings = UIAlertAction(title: "Go to settings", style: .cancel) { (_) in
            if let url = URL(string: "app-settings:") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        deniedAlert.addAction(goToSettings)
        
        self.present(deniedAlert, animated:  true, completion: nil)
    }
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
