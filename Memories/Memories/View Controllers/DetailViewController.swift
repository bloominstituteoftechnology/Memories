//
//  DetailViewController.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateViews() {
        if let memory = memory {
            navigationController?.title = "Edit Memory"
            imageView.image = UIImage(data: memory.imageData)
            textField.text = memory.title
            textView.text = memory.bodyText
        } else {
            navigationController?.title = "Add Memory"
        }
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.presentImagePickerController()
                }
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = textField.text,
            let bodyText = textView.text,
            let imageData = imageView.image,
            let data = UIImagePNGRepresentation(imageData) else { return }
        
        if let memory = memory {
            memoryController?.update(memory: memory, title: title, bodyText: bodyText, imageData: data)
        } else {
            memoryController?.create(title: title, bodyText: bodyText, imageData: data)
        }
    }
    
    func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var memoryController: MemoryController?
    var memory: Memory?
}
