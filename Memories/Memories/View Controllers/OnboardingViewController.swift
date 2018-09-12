//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Scott Bennett on 9/12/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        localNotificationHelper.getAuthorizationStatus { (status) in
            switch status {
            case .authorized:
                self.performSegue(withIdentifier: "GetStarted", sender: nil)
            case .denied:
                break
            default:
                break
            }
        }
    }

    
    @IBAction func getStartedButton(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (true) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
        }
        performSegue(withIdentifier: "GetStarted", sender: nil)
        
    }
    
    
}
