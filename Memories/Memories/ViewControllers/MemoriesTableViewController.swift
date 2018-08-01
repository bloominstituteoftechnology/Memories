//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Simon Elhoej Steinmejer on 01/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController
{
    let localNotificationHelper = LocalNotificationHelper()
    let memoryController = MemoryController()
    let memoryCell = "memoryCell"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        checkForAuthorization()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: memoryCell)
        
        setupNavBar()
    }
    
    private func setupNavBar()
    {
        title = "Memories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNewMemory))
    }
    
    private func checkForAuthorization()
    {
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status != .authorized
            {
                let onBoardingViewController = OnBoardingViewController()
                onBoardingViewController.notificationHelper = self.localNotificationHelper
                self.present(onBoardingViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleNewMemory()
    {
        let memoryDetailViewController = MemoryDetailViewController()
        memoryDetailViewController.memoryController = self.memoryController
        navigationController?.pushViewController(memoryDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memoryController.memories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: memoryCell, for: indexPath)
        
        let memory = memoryController.memories[indexPath.row]
        
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let memory = memoryController.memories[indexPath.row]
        let memoryDetailViewController = MemoryDetailViewController()
        memoryDetailViewController.memoryController = self.memoryController
        memoryDetailViewController.memory = memory
        navigationController?.pushViewController(memoryDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandlerFunction)
        
        return [deleteAction]
    }
    
    private func deleteHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath)
    {
        memoryController.deleteMemory(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}






















