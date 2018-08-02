//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit
import PhotosUI

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func updateViews() {
        guard let memory = memory else {
            self.title = "Add Photo"
            return
        }

        self.title = "Edit Photo"
        imageView?.image = UIImage(data: memory.imageData)
        descriptionTextView?.text = memory.bodyText
        titleTextField?.text = memory.title
    }

    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func addPhoto(_ sender: Any) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        if authStatus == .authorized {
            self.presentImagePickerController()
        } else if authStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                guard status == .authorized else {
                    self.presentImagePickerController()
                    return
                }
            }
        }
    }

    @IBAction func saveMemory(_ sender: Any) {
        if let memory = memory {
            guard let image = imageView.image else { return }
            memoryController.updateMemory(memory: memory, title: titleTextField.text!, bodyText: descriptionTextView.text!, imageData: image.pngData()!)
        } else {
            guard let titleText = titleTextField.text,
                let descriptionText = descriptionTextView.text,
                let image = imageView.image else { return }
            memoryController.createMemory(title: titleText, bodyText: descriptionText, imageData: image.pngData()!)
        }
    }

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    var memoryController = MemoryController()
    var memory: Memory? {
        didSet {
            updateViews()
        }
    }
}
