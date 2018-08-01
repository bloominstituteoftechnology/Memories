//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Simon Elhoej Steinmejer on 01/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate
{
    //MARK: - Properties
    
    var memoryController: MemoryController?
    
    var memory: Memory?
    {
        didSet
        {
            guard let memory = memory else { return }
            updateViews(memory)
        }
    }
    
    //MARK: - UI Objects
    
    let imageView: UIImageView =
    {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let selectPhotoButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        return button
    }()
    
    let titleTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.layer.cornerRadius = 6
        tf.addTarget(self, action: #selector(handleMemoryValueChanged), for: .valueChanged)
        tf.backgroundColor = .white
        
        return tf
    }()
    
    lazy var bodyTextView: UITextView =
    {
        let tv = UITextView()
        tv.isEditable = true
        tv.layer.cornerRadius = 6
        tv.delegate = self
        
        return tv
    }()
    
    //MARK: - Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupNavBar()
        setupUI()
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        handleMemoryValueChanged()
    }
    
    private func setupNavBar()
    {
        title = "Add Memory"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveMemory))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .lightGray
//        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray], for: .normal)
    }
    
    @objc func handleSaveMemory()
    {
        guard let title = titleTextField.text, let bodyText = bodyTextView.text, let image = imageView.image, let data = UIImagePNGRepresentation(image) else { return }
        
        if memory == nil
        {
            memoryController?.createMemory(with: title, bodyText: bodyText, imageData: data)
            navigationController?.popViewController(animated: true)
        }
        else
        {
            memoryController?.updateMemory(on: memory!, title: title, bodyText: bodyText, imageData: data)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleSelectPhoto()
    {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized
            {
                DispatchQueue.main.async {
                    self.handleImageController()
                }
            }
            else
            {
                let alert = UIAlertController(title: "Warning", message: "We need permission to your photo library before you can add a memory.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func handleImageController()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let editedPhoto = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            imageView.image = editedPhoto
        }
        else if let photo = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            imageView.image = photo
        }
        
        handleMemoryValueChanged()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleMemoryValueChanged()
    {
        guard let title = titleTextField.text, let bodyText = bodyTextView.text, let _ = imageView.image else { return }
        
        let isValid = title.count > 0 && bodyText.count > 0
        
        navigationItem.rightBarButtonItem?.isEnabled = isValid ? true : false
        navigationItem.rightBarButtonItem?.tintColor = isValid ? .blue : .lightGray
    }
    
    private func updateViews(_ memory: Memory)
    {
        imageView.image = UIImage(data: memory.imageData)
        titleTextField.text = memory.title
        bodyTextView.text = memory.bodyText
    }
    
    private func setupUI()
    {
        view.addSubview(selectPhotoButton)
        view.addSubview(imageView)
        view.addSubview(titleTextField)
        view.addSubview(bodyTextView)
        
        selectPhotoButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 40)
        selectPhotoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: selectPhotoButton.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, paddingBottom: -8, width: 0, height: 0)
        
        titleTextField.anchor(top: selectPhotoButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, paddingBottom: 0, width: 0, height: 40)
        
        bodyTextView.anchor(top: titleTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, paddingBottom: -8, width: 0, height: 0)
    }
    
}






















