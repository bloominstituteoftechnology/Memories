//
//  MemoriesTableViewController.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController?.memories.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryTableCell", for: indexPath)
        guard let memory = memoryController?.memories[indexPath.row] else { return cell}
        
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        
        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let index = tableView.indexPathForSelectedRow,
                  let theMemory = memoryController?.memories[index.row] else { return }
            
            memoryController?.deleteMemory(memory: theMemory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemoryTableCellSegue" {
            guard let destinationVC = segue.destination as? MemoryDetailViewController else { return }
            destinationVC.memory = memory
        } else if segue.identifier == "AddBarButtonSegue" {
            guard let destinationVC = segue.destination as? MemoryDetailViewController else { return }
            destinationVC.memory = memory
        }
    }
}
