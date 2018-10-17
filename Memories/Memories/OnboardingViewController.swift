import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { isAuthorized in
            if isAuthorized == .authorized {
                self.performSegue(withIdentifier: "onboardingSegue", sender: nil)
            }
        }
    }
    
    // when this button is pressed, it will request for permission
    @IBAction func getStartedButton(_ sender: Any) {
        
        //if this is succesfully done, segue
        localNotificationHelper.requestAuthorization { successful in
            if successful {
                
                // this is calling the function from location helper, that starts reminder
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "onboardingSegue", sender: nil)
            }
        }
    }
}
