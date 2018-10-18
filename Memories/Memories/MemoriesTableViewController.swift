import UIKit

class MemoriesTableViewController: UITableViewController {
    
    let memoryController = MemoryController()
    
    override func viewWillAppear(_ animated: Bool) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let memory = memoryController.memories[indexPath.row]
        let memoryImage = UIImage(data: memory.imageData)
        
        cell.textLabel?.text = memory.title
        cell.imageView?.image = memoryImage
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let memory = memoryController.memories[indexPath.row]
            memoryController.deleteMemory(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for: UIStoryboardSegue, sender: Any?) {
            
    }
    
}
