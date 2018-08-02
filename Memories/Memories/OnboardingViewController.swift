//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit
import UserNotifications

class OnboardingViewController: UIViewController, UNUserNotificationCenterDelegate
{
    let localNotificationHelper = LocalNotificationHelper()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized
            {
                NSLog("notifications authorized")
                self.performSegue(withIdentifier: "ToMainView", sender: nil)
            }
            else
            {
                NSLog("notifications not authorized")
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

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        print("The notification arrived!")
        
        completionHandler([.alert,.sound])
    }
    
    

}
