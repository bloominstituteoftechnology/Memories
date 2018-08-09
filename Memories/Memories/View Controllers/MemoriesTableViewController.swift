//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        memoryController.loadFromPersistence()

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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            memoryController.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMemorySegue" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.memoryController = memoryController
        } else if segue.identifier == "TapCellSegue" {
            guard let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.memoryController = memoryController
            detailVC.memory = memoryController.memories[indexPath.row]
        }
    }
    
    var memoryController: MemoryController = MemoryController()
    var memory: Memory?
    
}
