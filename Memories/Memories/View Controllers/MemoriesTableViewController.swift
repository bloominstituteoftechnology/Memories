//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        memoryController.loadFromPersistentStore()
        tableView.reloadData()
    }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMemory" {
            if let vc = segue.destination as? MemoryDetailViewController {
                vc.memoryController = memoryController
            }
        } else if segue.identifier == "EditMemory" {
            if let vc = segue.destination as? MemoryDetailViewController {
                vc.memoryController = memoryController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    vc.memory = memoryController.memories[indexPath.row]
                }
            }
        }
    }

    var memoryController: MemoryController = MemoryController()
}
