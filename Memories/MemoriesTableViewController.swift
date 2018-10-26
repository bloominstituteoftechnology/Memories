import UIKit

class MemoriesTableViewController: UITableViewController {
    
    let memoryController = MemoryController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController.memories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath)
        
        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memoryController.deleteMemoryAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "addSegue" {
                guard let memoryDetailViewController = segue.destination as? MemoryDetailViewController else { return }
                memoryDetailViewController.memoryController = memoryController
            } else if segue.identifier == "memoryCellSegue" {
                guard let indexPath = tableView.indexPathForSelectedRow,
                    let memoryDetailViewController = segue.destination as?
                    MemoryDetailViewController else { return }
                
                let memory = memoryController.memories[indexPath.row]
                memoryDetailViewController.memoryController = memoryController
                memoryDetailViewController.memory = memory
            }
        }
    }
