//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Dillon McElhinney on 9/5/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    var memory: Memory?
    var memoryController: MemoryController?
    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var addImageButton: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - UI Methods
    @IBAction func addPhoto(_ sender: Any) {
        // Get the authorization status
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        if authorizationStatus == .authorized {
            // If the status is authorized, present the image picker controller
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            // If the status is not determined, request authorization
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    // If it comes back as successful, present the image picker controller
                    self.presentImagePickerController()
                } else {
                    self.presentAlertController()
                }
            }
        } else {
            presentAlertController()
        }
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        // Make sure we have all the data we need.
        guard let title = titleTextField.text, !title.isEmpty,
            let bodyText = bodyTextView.text,
            let image = memoryImageView.image,
            let imageData = UIImagePNGRepresentation(image) else { return }
        
        if let memory = memory {
            // If there is already a memory, update it.
            memoryController?.update(memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
            // Otherwise, make a new one.
            memoryController?.createMemory(withTitle: title, bodyText: bodyText, imageData: imageData)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - UI Image Picker Controller Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addImageButton.setTitle("Change Photo", for: .normal)
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        memoryImageView.image = image
    }
    
    // MARK: - Private Utility Method
    // Method to update the views
    private func updateViews() {
        addImageButton.setTitle("Add Photo", for: .normal)
        guard let memory = memory else {
            title = "Add Memory"
            return
        }
        
        title = "Edit Memory"
        titleTextField.text = memory.title
        bodyTextView.text = memory.bodyText
        memoryImageView.image = UIImage(data: memory.imageData)
        addImageButton.setTitle("Change Photo", for: .normal)
    }
    
    // Method to present the image picker controller
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Method to present an alert if we don't have permission to access photos.
    private func presentAlertController() {
        //Instantiate an alert controller
        let alert = UIAlertController(title: "Permission Denied", message: "At some point you denied permission for Memories to use your photos. You must change that to continue.", preferredStyle: .alert)
        
        //Make and add a dismiss action
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        
        //Make and add a settings action
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) in
            let url = URL(string: "app-settings:")
            if let url = url { UIApplication.shared.open(url, options: [:], completionHandler: nil) }
        }
        alert.addAction(settingsAction)
        
        present(alert, animated: true, completion: nil)
    }
}
