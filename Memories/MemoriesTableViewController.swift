import UIKit

class MemoriesTableViewController: UITableViewController {
    var memory: Memory?
    var memoryController = MemoryController()
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController.memories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let memoryDestination = segue.destination as? MemoryDetailViewController else { return }
        memoryDestination.memoryController = memoryController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        memoryDestination.memory = memoryController.memories[indexPath.row]
        
        
    }
}
