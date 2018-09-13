//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 9/12/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        updateView()
    }
    
    func updateView(){
        guard isViewLoaded else {return}
        if let memory = memory{
            textField.text = memory.title
            textView.text = memory.bodyText
            imageView.image = UIImage(data:memory.imageData)
        }else{
            navigationController?.title = "Add Memory"
        }
    
    }
    
    @IBAction func addPhoto(_ sender: Any) {
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
    
    @IBAction func save(_ sender: Any) {
        guard let title = textField.text,
            let bodyText = textView.text,
            let imageData = UIImagePNGRepresentation(imageView.image!) else {return}
        if let memory = memory {
            memoryController?.updateMemory(memory: memory, title: title, bodyText: bodyText, imageData: imageData)
        }else{
            memoryController?.createMemory(title: title, bodyText: bodyText, imageData: imageData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func presentImagePickerController(){
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {return}
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        imageView.image = image
    }
    
    var memory: Memory?{
        didSet{
            updateView()
        }
    }
    var memoryController: MemoryController?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
}
