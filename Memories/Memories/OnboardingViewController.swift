//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Nikita Thomas on 10/16/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    let localNotificationHelper = LocalNotificationHelper()

    @IBAction func getStartedButton(_ sender: Any) {
        localNotificationHelper.requestAuthorization { success in
            if success {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { status in
            if status == .authorized {
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
            }
        }
    }
    

    
    
}
