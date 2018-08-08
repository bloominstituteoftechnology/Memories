//
//  ViewController.swift
//  Memories
//
//  Created by Iyin Raphael on 8/8/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    let localNotificationHelper = LocalNotificationHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (status) in
            guard status == .authorized else {return}
            
            self.performSegue(withIdentifier: "getStarted", sender: nil)
             
        }
    }
        
    @IBAction func getStartedButton(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (success) in
            
        guard success else {return}
            
        self.localNotificationHelper.scheduleDailyReminderNotification()
        self.performSegue(withIdentifier: "getStarted", sender: nil)
        }
    }
    
 
}

