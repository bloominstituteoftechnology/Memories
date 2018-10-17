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
        
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return memoryController.memories.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        // Update model then refresh view
        tableView.deleteRows(at: [indexPath], with: .fade)
      
       tableView.reloadData()
        
        
    }
    
    let reuseIdentifier = "cell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        
    
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    
    
}
