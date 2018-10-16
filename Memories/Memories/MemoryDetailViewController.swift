import UIKit

class MemoryDetailViewController: UIViewController {

    
   
    @IBOutlet weak var memoryPhoto: UIImageView!
    @IBOutlet weak var memoryTitleField: UITextField!
    @IBOutlet weak var memoryText: UITextView!
    
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func saveMemory(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
