//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Jason Modisett on 9/7/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (authorizationStatus) in
            if authorizationStatus == .authorized {
                self.performSegue(withIdentifier: "PassOnboarding", sender: nil)
            }
        }
    }

    @IBAction func getStartedButtonPressed(_ sender: Any) {
        
        localNotificationHelper.requestAuthorization { (wasSuccessful) in
            if wasSuccessful {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "PassOnboarding", sender: nil)
            }
        }
        
    }
    
    let localNotificationHelper = LocalNotificationHelper()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
