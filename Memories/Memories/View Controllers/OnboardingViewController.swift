//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit
import UserNotifications

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus { (status) in
            guard status == .authorized else { return }
            //segue
            
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (success) in
            if success {
            //run the segue
                //run the function for notification
            }else {
                //dont do anything, we hate this user
            }
        }
    }
    
    let localNotificationHelper = LocalNotificationHelper()

}
