//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 8/8/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    let memoryController = MemoryController()

    override func viewDidLoad() {
        super.viewDidLoad()
        memoryController.loadToPersistence()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

  
    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memoryController.memories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let memory = memoryController.memories[indexPath.row]
        guard let image: UIImage = UIImage(data: memory.imageData) else {return cell}
        cell.imageView?.image = image
        return cell
    }


/*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
*/




    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMemory" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? MemoriesDetailViewController else {return}
            let memory = memoryController.memories[indexPath.row]
            detailVC.memoryController = memoryController
            detailVC.memory = memory
        }
        if segue.identifier == "addMemory" {
            guard let detailVC = segue.destination as? MemoriesDetailViewController else {return}
            detailVC.memoryController = memoryController
        }
    }
   

}
