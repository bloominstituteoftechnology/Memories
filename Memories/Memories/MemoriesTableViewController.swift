//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController
{
    let memoryController = MemoryController()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        memoryController.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memoryController.memories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryListCell", for: indexPath)

        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let memory = memoryController.memories[indexPath.row]
            memoryController.deleteMemory(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowAddView"
        {
            guard let addView = segue.destination as? MemoryDetailViewController else {return}
            addView.memoryController = memoryController
        }
        else if segue.identifier == "ShowDetailView"
        {
            guard let showView = segue.destination as? MemoryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            showView.memoryController = memoryController
            showView.memory = memoryController.memories[indexPath.row]
        }
    }
    

}
