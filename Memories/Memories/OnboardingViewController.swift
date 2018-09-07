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
            
            case .notDetermined:
                break
                
            case .authorized:
                self.performSegue(withIdentifier: "EnterMemories", sender: nil)
            
            case .denied:
                self.setDeniedAlert()
            }
        }
    }
    
    private func setDeniedAlert(){
        let deniedAlert = UIAlertController(title: "Oh no! You denied notifications.", message: "To allow for notifications, please go your settings and manually change notification settings to 'Allow'", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { (_) in
            self.performSegue(withIdentifier: "EnterMemories", sender: nil)
        }
        
        deniedAlert.addAction(dismissAction)
        
        let goToSettings = UIAlertAction(title: "Go to settings", style: .cancel) { (_) in
            if let url = URL(string: "app-settings:") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        deniedAlert.addAction(goToSettings)
        
        self.present(deniedAlert, animated:  true, completion: nil)
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
