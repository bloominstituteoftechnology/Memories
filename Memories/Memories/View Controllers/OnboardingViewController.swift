//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized {
                self.performSegue(withIdentifier: "JoinMemories", sender: nil)
            }
        }
    }
    
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (success) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
            self.performSegue(withIdentifier: "JoinMemories", sender: nil)
        }
        
    }
    
    let localNotificationHelper = LocalNotificationHelper()
}
