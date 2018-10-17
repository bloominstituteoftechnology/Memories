import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (authorizationStatus) in
            if authorizationStatus == .authorized {
                self.performSegue(withIdentifier: "PassOnboarding", sender: nil)
            }
        }
    }
    
    @IBAction func getStartedButtonPressed(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (wasSuccessful) in
            if wasSuccessful {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "PassOnboarding", sender: nil)
            }
        }
    }    
}
