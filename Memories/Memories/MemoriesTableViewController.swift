//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Yvette Zhukovsky on 10/16/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    
    var memory: Memory?
    var memoryController: MemoryController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return memoryController.memories.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        
        
    }
    
    let reuseIdentifier = "cell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     cell.imageView?.image = memoryController.memories[indexPath.row]
        return cell
        
        
        return cell
    }

    
    
    
    
    
    
}
