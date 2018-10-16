import UIKit
import UserNotifications

class OnboardingViewController: UIViewController {

    let localNotificationHelper = LocalNotificationHelper()
    
    @IBAction func getStartedButton(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (wasSucessful) in
            if wasSucessful {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "PassOnboarding", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (authorizationStatus) in
            if authorizationStatus == .authorized {
                self.performSegue(withIdentifier: "PassOnboarding", sender: nil)
            }
        }

        // Do any additional setup after loading the view.
    }
}
