//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Moin Uddin on 9/5/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit
import UserNotifications

class MemoryDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func saveMemory(_ sender: Any) {
    }
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    
    
    
    
    var memoryController: MemoryController?
    var memory: Memory?
}
