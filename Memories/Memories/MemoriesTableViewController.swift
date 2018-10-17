import UIKit


class MemoriesTableViewController: UITableViewController {
    
    var memory: Memory?
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
        // #warning Incomplete implementation, return the number of rows
        return memoryController.memories.count
    }
    
    let reuseIdentifier = "cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let memory = memoryController.memories[indexPath.row]
        let memoryPhoto = UIImage(data: memory.imageData)
        cell.textLabel?.text = memory.title
        cell.imageView?.image = memoryPhoto
        
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let memory = memoryController.memories[indexPath.row]
            memoryController.deleteMemory(m: memory)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            
            guard let destinationView = segue.destination as? MemoryDetailViewController else { return }
                
            destinationView.memoryController = memoryController
            
        } else if segue.identifier == "cellSegue" {
            
            guard let destinationView = segue.destination as? MemoryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
        
            destinationView.memoryController = memoryController
            destinationView.memory = memoryController.memories[indexPath.row]
            
        }
    }
}
