//
//  MemoriesDetailViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 8/8/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MemoriesDetailViewController: UIViewController {
    var memory: Memory?
    var memoryController: MemoryController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        guard isViewLoaded else {return}
        if let memory = memory{
            navigationController?.title = "Edit Memory"
            titleTextFIeld.text = memory.title
            textView.text = memory.bodyText
            guard let image: UIImage = UIImage(data: memory.imageData) else {return}
            imageView.image = image
        }else{
            navigationController?.title = "Add Memory"
        }
    }
    
    
    @IBAction func SaveMemory(_ sender: Any) {
        guard let title = titleTextFIeld.text,
        let bodyText = textView.text,
            let imageData: Data = imageView.image as? Data else {return}
        
        if let memory = memory{
            memoryController.updateMemory(memory: memory, title: title, bodyText: bodyText, imageData: Data(imageData))
        }
        
        
        
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func addPhotoButton(_ sender: Any) {
    }
    
    @IBOutlet weak var titleTextFIeld: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
}
