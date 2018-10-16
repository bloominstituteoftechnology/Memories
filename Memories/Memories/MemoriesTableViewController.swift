import UIKit

class MemoriesTableViewController: UITableViewController {
    
    let memoryController = MemoryController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let memory = memoryController.memories[indexPath.row]
            memoryController.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //memoryController.memories
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destingation = segue.destination as? MemoryDetailViewController else { return }
        destingation.memoryController = memoryController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destingation.memory = memoryController.memories[indexPath.row]
    }
}
