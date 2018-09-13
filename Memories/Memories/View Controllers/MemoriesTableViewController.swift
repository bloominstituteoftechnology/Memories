//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Scott Bennett on 9/12/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    var memoryController = MemoryController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            memoryController.deleteMemory(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMemory" {
            guard let vc = segue.destination as? MemoryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let memory = memoryController.memories[indexPath.row]
            vc.memoryController = memoryController
            vc.memory = memory
   
        } else if segue.identifier == "AddMemory" {
            guard let vc = segue.destination as? MemoryDetailViewController else { return }
            vc.memoryController = memoryController
        }
    }


}
