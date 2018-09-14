//
//  OnBoardingViewController.swift
//  Memories
//
//  Created by Welinkton on 9/13/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

    let localNotificationHelper = LocalNotificationHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus { (status) in
            switch status {
            case .authorized:
                self.performSegue(withIdentifier: "OnBoard", sender: nil)
            default:
                return
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func getStartedButton(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (proceed) in
            if proceed {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "Onboard", sender: nil)
            } else {
                return
            }
        }
    }
}
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Onboard" {
//            guard let destinationVC = segue.destination as? UINavigationController else { return }
//            destinationVC.show(destinationVC, sender: nil)
//        }
//    }
//}



