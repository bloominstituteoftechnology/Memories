//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Daniela Parra on 9/5/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus { (status) in
            
            //If has authorization status, manual segue to other view controller
            switch status {
            case .authorized:
                self.performSegue(withIdentifier: "EnterMemories", sender: nil)
            
            case .denied:
                //set alert/action sheet to remind them to make change
                break
            case .notDetermined:
                break
            }
            
        }
    }

    // MARK: - Navigation
 
    @IBAction func getStarted(_ sender: Any) {
        
        localNotificationHelper.requestAuthorization { (granted) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
        }
        
        performSegue(withIdentifier: "EnterMemories", sender: nil)
    }
    
    let localNotificationHelper = LocalNotificationHelper()
    
    
}
