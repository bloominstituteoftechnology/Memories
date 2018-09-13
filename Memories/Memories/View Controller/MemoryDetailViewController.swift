//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 9/12/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
}
