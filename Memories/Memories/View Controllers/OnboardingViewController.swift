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
        
        performSegue(withIdentifier: "ShowMemoryModal", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localNotificationHelper.getAuthorizationStatus() { (success) in
            if success == .authorized {
                self.performSegue(withIdentifier: "ShowMemoryModal", sender: nil)
            }
        }
    }
    
}
