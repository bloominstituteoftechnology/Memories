//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 9/12/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memoryController.memories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let memory = memoryController.memories[indexPath.row]
        cell.imageView?.image = UIImage(data: memory.imageData)
        cell.textLabel?.text = memory.title
        return cell
    }

   


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            memoryController.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMemory" {
            guard let detailVC = segue.destination as? MemoryDetailViewController else {return}
            detailVC.memoryController = memoryController
        }else if segue.identifier == "showMemory"{
            guard let detailVC = segue.destination as? MemoryDetailViewController,
            let index = tableView.indexPathForSelectedRow  else {return}
            let memory = memoryController.memories[index.row]
            detailVC.memoryController = memoryController
            detailVC.memory = memory

        }
    }

    let memoryController = MemoryController()

}
