//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Linh Bouniol on 8/1/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    var memoryController = MemoryController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            memoryController.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addDetailVC = segue.destination as? MemoryDetailViewController {
            addDetailVC.memoryController = memoryController
        }
        
        if let detailVC = segue.destination as? MemoryDetailViewController {
            detailVC.memoryController = memoryController
            
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let memory = memoryController.memories[index]
            detailVC.memory = memory
        }
        
        
    }
    

}
