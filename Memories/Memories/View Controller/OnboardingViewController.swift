//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 9/12/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized{
                self.performSegue(withIdentifier: "getStarted", sender: nil)
            }
        }
    }
    
    let localNotificationHelper = LocalNotificationHelper()
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (success) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
        }
        performSegue(withIdentifier: "getStarted", sender: nil)
    }
    
    

  

}
