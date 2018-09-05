//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Dillon McElhinney on 9/5/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    // MARK: - Properties
    let memoryController = MemoryController()
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table View Data Source
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            
            memoryController.delete(memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMemorySegue" {
            // If the segue is for adding a memory, make sure we can cast the destination and then set the memory controller
            guard let destinationVC = segue.destination as? MemoryDetailViewController else { return }
            
            destinationVC.memoryController = memoryController
        } else if segue.identifier == "ShowMemorySegue" {
            // If the segue is for showing a memory, make sure we can cast the destination and get a memory, then set the memory and memory controller
            guard let destinationVC = segue.destination as? MemoryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let memory = memoryController.memories[indexPath.row]
            
            destinationVC.memoryController = memoryController
            destinationVC.memory = memory
        }
    }
    
}
