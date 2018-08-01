//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Linh Bouniol on 8/1/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {
    
    var memory: Memory?
    
    var memoryController: MemoryController?

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
