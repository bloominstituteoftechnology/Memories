//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func saveMemory(_ sender: Any) {
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    var memoryController: MemoryController
    var memory: Memory?
}
