//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Welinkton on 9/13/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var memoryController = MemoryController()
    var memory: Memory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func updateViews() {
        guard let memory = memory else {
            title = "Add Memory"
            return
        }
        
        title = "Edit Memory"
        memoryImageView.image = UIImage(data: memory.imageData)
        memoryTextView.text = memory.bodyText
        memoryTextField.text = memory.title
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func presentImagePickerController() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.sourceType = .photoLibrary
            
            imagePicker.delegate = self
            
            present(imagePicker,animated: true, completion: nil)
            
        } else {return}
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        
        memoryImageView.image = image
    }
    
    
    
    @IBAction func saveBarButton(_ sender: Any) {
        
        guard let title = memoryTextField.text,
        let bodyText = memoryTextView.text,
        let image = memoryImageView.image,
            let imageData = UIImagePNGRepresentation(image) else {return}
        if let memory = memory {
            memoryController.updateMemory(memory: memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
            memoryController.createMemory(withName: title, bodyText: bodyText, imageData: imageData)
        }
            navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
                self.presentImagePickerController()
        case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (changeStatus) in
                    if changeStatus == .authorized {
                        self.presentImagePickerController()
                    } else {return}
                    })
                    default : return
                }
        }


    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var memoryTextField: UITextField!
    @IBOutlet weak var memoryTextView: UITextView!
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
