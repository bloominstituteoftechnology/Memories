//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit
import UserNotifications

class OnboardingViewController: UIViewController
{
    let localNotificationHelper = LocalNotificationHelper()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized
            {
                NSLog("notifications authorized")
                self.performSegue(withIdentifier: "ToMainView", sender: nil)
            }
            
        }
    }
    
    @IBAction func getStarted(_ sender: Any)
    {
        localNotificationHelper.requestAuthorization { (success) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
        }
        performSegue(withIdentifier: "ToMainView", sender: nil)
    }


}
