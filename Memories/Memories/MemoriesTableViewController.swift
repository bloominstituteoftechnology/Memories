//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Yvette Zhukovsky on 10/16/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    
    let mc = MemoryController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mc.memories.count
    }



override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
    
}

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        
        
        mc.Delete(m: mc.memories[indexPath.row])
        
        // Update model then refresh view
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        tableView.reloadData()
        
        
    }

let reuseIdentifier = "cell"
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    
    let memory = mc.memories[indexPath.row]
    cell.textLabel?.text = memory.title
    cell.imageView?.image = UIImage(data: memory.imageData)
    
    
    return cell
}


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard let MemoryDetailViewController = segue.destination as? MemoryDetailViewController
        else { fatalError("Segue destination failed") }
    
    if let cell = sender as? UITableViewCell {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        MemoryDetailViewController.memory = mc.memories[indexPath.row]
    } else {
        MemoryDetailViewController.memory = nil
    }
    
}





