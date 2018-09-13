//
//  MemoryDetailViewController.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var memoryTextField: UITextField!
    @IBOutlet weak var memoryTextView: UITextView!
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Button actions
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        if authorizationStatus == .authorized {
            self.presentImagePickerController()
            
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                guard status == .authorized else {
                    NSLog("Please go to the settings and allow Memories access to your Photo Library")
                    return
                }
            }
        }
    }
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        
        // IF the user clicked Save Bar Button
        // Then get values of texField, texView and imageData, check if title isn't empty
        // And IF there is a memory previously created then update it's value
        // ELSE if there isn't any memory yet then create a new one with that values
        
        guard let title = memoryTextField.text,
              let body = memoryTextView.text,
              let image = memoryImageView.image,
              let data = UIImagePNGRepresentation(image),
              title != "" else { return }
        
        if let memory = memory {
            memoryController?.updateMemory(memory: memory, title: title, bodyText: body, imageData: data)
        } else {
            memoryController?.createMemory(title: title, bodyText: body, imageData: data)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Update views
    
    private func updateViews() {
        
        // If the user clicked the cell and come to this view.
        // And IF there is a memory then make view's title "Edit Memory". Change textField, textView and imageView values to the memories related values
        // ELSE If there isn't any memory then change the title "Add memory" and let the user create a new one
        
        if let memory = memory {
            self.title = "Edit Memory"
            memoryTextField.text = memory.title
            memoryTextView.text = memory.bodyText
            memoryImageView.image = UIImage(data: memory.imageData)
        } else {
            self.title = "Add Memory"
        }
    }
    
    // MARK: - Image picker
    
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        memoryImageView.image = image
    }
    
}
