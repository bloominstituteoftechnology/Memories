//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Welinkton on 9/13/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    var memoryController = MemoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController.memories.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath)

        let memory = memoryController.memories[indexPath.row]

        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        
        return cell
    }
  

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let memory = memoryController.memories[indexPath.row]
            
            memoryController.deleteMemory(memory: memory)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddDetailVC" {
            guard let destinationVC = segue.destination as? MemoryDetailViewController else { return }
            
            destinationVC.memoryController = memoryController
            
        } else if segue.identifier == "CellDetailVC" {
            guard let destinationVC = segue.destination as? MemoryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let memory = memoryController.memories[indexPath.row]
            
            destinationVC.memoryController = memoryController
            destinationVC.memory = memory
            
        }
    }
}

    

