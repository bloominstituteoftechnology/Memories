//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var memory: Memory?
    var memoryController = MemoryController()
    var dataOfImage: Data?
    
    @IBOutlet weak var memoryImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        updateViews()
    }
    
    //MARK: - ImagePicker
    func checkPhotoPermission()
    {
        PHPhotoLibrary.requestAuthorization { (status) in
            
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                print("authorized")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization() { status in
                    if status == .authorized {
                        DispatchQueue.main.async {
                            self.presentImagePickerController()
                        }
                    }
                }
            case .restricted:
                // do nothing
                break
            case .denied:
                // do nothing, or beg the user to authorize us in Settings
                break
            }
        }
    }
    
    @IBAction func addPhoto(_ sender: Any)
    {
        checkPhotoPermission()
        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else {
                NSLog("go to settings to allow acces")
                return
            }
            print("photo acces authorized")
        DispatchQueue.main.async {
            self.presentImagePickerController()
        }
        }
    }
    
    private func presentImagePickerController()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            print("photo library not available")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        memoryImageView.contentMode = .scaleAspectFit
        memoryImageView.image = chosenImage
        
        if let data = UIImagePNGRepresentation(chosenImage)
        {
            dataOfImage = data
        }
        
        //memoryController.saveToPersistentStore()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Button Actions
    
    @IBAction func save(_ sender: Any)
    {
        if memory == nil
        {
            guard let title = titleTextField.text,
                let bodyText = descriptionTextView.text,
                let imageData = dataOfImage else {return}
            
            memoryController.createMemory(title: title, bodyText: bodyText, imageData: imageData)
            
        }
        else
        {
            guard let title = titleTextField.text,
                let bodyText = descriptionTextView.text,
                let imageData = dataOfImage else {return}
            
            memoryController.updateMemory(memory: memory!, title: title, bodyText: bodyText, imageData: imageData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Update
    
    private func updateViews()
    {
        guard let memory = memory else {
            title = "Add Memory"
            return
        }
        
        title = "Edit Memory"
        
        titleTextField.text = memory.title
        descriptionTextView.text = memory.bodyText
        memoryImageView.image = UIImage(data: memory.imageData)
    }
    
    
    
    


}
