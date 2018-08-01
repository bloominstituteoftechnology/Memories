//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by De MicheliStefano on 01.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func saveMemory(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Properties
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
