//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by De MicheliStefano on 01.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        memoryController.loadFromPersistentStore()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController.memories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath)
        
        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title

        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            memoryController.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMemoryDetail" {
            guard let vc = segue.destination as? MemoryDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            vc.memoryController = memoryController
            vc.memory = memoryController.memories[indexPath.row]
        } else if segue.identifier == "ShowAddMemoryDetail" {
            guard let vc = segue.destination as? MemoryDetailViewController else { return }
            vc.memoryController = memoryController
        }
    }
    
    var memory: Memory?
    var memoryController = MemoryController()

}
