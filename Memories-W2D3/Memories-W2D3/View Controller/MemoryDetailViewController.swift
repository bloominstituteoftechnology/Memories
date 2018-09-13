//
//  MemoryDetailViewController.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var memoryTextField: UITextField!
    @IBOutlet weak var memoryTextView: UITextView!
    
    var memory: Memory?
    let memoryController = MemoryController()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Button actions
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let title = memoryTextField.text,
              let body = memoryTextView.text,
              let image = memoryImageView.image,
              let data = UIImagePNGRepresentation(image) else { return }
        
        if let memory = memory {
            memoryController.updateMemory(memory: memory, title: title, bodyText: body, imageData: data)
        } else {
            memoryController.createMemory(title: title, bodyText: body, imageData: data)
        }
    }
    
    // MARK: - Update views
    
    private func updateViews() {
        
        // If there is a memory then execute IF statement otherwise execute ELSE statement
        
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
