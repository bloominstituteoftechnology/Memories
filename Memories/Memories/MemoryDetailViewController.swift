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
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        if authorizationStatus == .authorized {
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized { self.presentImagePickerController() }
            }
        }
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
            let bodyText = bodyTextView.text,
            let image = memoryImageView.image,
            let imageData = UIImagePNGRepresentation(image) else { return }
        
        if let memory = memory {
            memoryController?.update(memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private Utility Functions
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
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }

}
