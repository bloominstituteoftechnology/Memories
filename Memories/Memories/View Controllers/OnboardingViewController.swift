//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Linh Bouniol on 8/1/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    let localNotificationHelper = LocalNotificationHelper()
    
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization() { (success) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
        }
        
        performSegue(withIdentifier: "ShowMemoriesModal", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isHidden = true
        
        localNotificationHelper.getAuthorizationStatus() { (success) in
            
            if success == .authorized {
                self.performSegue(withIdentifier: "ShowMemoriesInstant", sender: nil)
            } else {
                self.view.isHidden = false
            }
        }
    }
    
}
