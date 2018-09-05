//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Dillon McElhinney on 9/5/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()

    @IBOutlet weak var explanationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized {
                self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
            } else {
                self.explanationLabel.text = "It looks like you have previously denied access to notifications. Memories won't work if it doesn't have this access, so you'll be stuck at this screen unless you allow notifications in Settings. Click the button below to go there!"
            }
        }
    }
    
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (success) in
            if success {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
            } else {
                let url = URL(string: "app-settings:")
                if let url = url {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }

}
