//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by De MicheliStefano on 01.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Methods
    
    func updateViews() {
        // If there is an existing memory then populate all outlets
        guard let memory = memory else {
            self.title = "Add Memory"
            return
        }
        self.title = "Edit Memory"
        memoryImageView?.image = UIImage(data: memory.imageData)
        titleTextField?.text = memory.title
        bodyTextView?.text = memory.bodyText
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        // Gain access to the current authorization status of the photo library
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        // Check if user has previously authorized access to photo library
        // else request authorization to access photo library
        if authorizationStatus == .authorized {
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization() { (handler) in
                if handler == .authorized {
                    self.presentImagePickerController()
                }
            }
        }
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        guard let memoryController = memoryController,
            let title = titleTextField.text,
            let body = bodyTextView.text,
            let imageData = memoryImageView?.image?.pngData() else { return }
        
        // If there is an existing memory then update, else create a new memory
        if let memory = memory {
            memoryController.update(memory: memory, title: title, bodyText: body, imageData: imageData)
        } else {
            memoryController.create(title: title, bodyText: body, imageData: imageData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func presentImagePickerController() {
        // Check if the photo library is available on the current device
        // If yes, then instantiate and present an imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            return
        }
    }
    
    // Gives us ability to get access to the photo and to dismiss image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Dismisses picker from screen and shows detail view controller again
        picker.dismiss(animated: true, completion: nil)
        
        // Access the image and set it as the memoryImageView
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        memoryImageView.image = image
    }
    
    // MARK: - Properties
    
    var memory: Memory? {
        didSet {
            updateViews()
        }
    }
    var memoryController: MemoryController?
    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
