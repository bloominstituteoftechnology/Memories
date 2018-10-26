import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()
    
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (wasSuccessful) in
            if wasSuccessful {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "onboardingSegue", sender: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (authorizationStatus) in
            
            if authorizationStatus == .authorized {
                self.performSegue(withIdentifier: "onboardingSegue", sender: nil)
            }
        }
    }
}
