//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Farhan on 9/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let localNotificationHelper = LocalNotificationHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus { (status) in
            switch status{
            case .authorized:
                self.performSegue(withIdentifier: "ManualSegue", sender: nil)
            
            default:
                return
            }
                
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getStarted(_ sender: Any) {
        
        localNotificationHelper.requestAuthorization { (flag) in
            
            if flag == true{
                self.localNotificationHelper.scheduleDailyReminderNotification()
            }
            else {
                return
            }
        }
        
        performSegue(withIdentifier: "ManualSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
