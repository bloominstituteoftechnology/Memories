import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()

       tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        if segue.identifier == "createSegue" {
            guard let
                memoryDetailVC = segue.destination as?
                MemoriesDetailViewController else { return }
            memoryDetailVC.memoryController = memoryController
        } else if segue.identifier == "updateSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let memoryDetailVC = segue.destination as?
                MemoriesDetailViewController else { return }
            let memory = memoryController.memories[indexPath.row]
            memoryDetailVC.memoryController = memoryController
            memoryDetailVC.memory = memory
        }
    }
    
    let memoryController = MemoryController()
    
    }

    

