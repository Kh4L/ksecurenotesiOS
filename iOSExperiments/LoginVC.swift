//
//  LoginVC.swift
//  iOSExperiments
//
//  Created by Serge Panev on 08/03/16.
//  Copyright © 2016 Serge Panev. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Variables
    
    var context: LAContext = LAContext()
    
    
    // MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if !(context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil)) {
            let alert : UIAlertController = UIAlertController(title: "No TouchID", message: "Uh oh, your device doesn't TouchID", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {
                (action: UIAlertAction) in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TouchID
    
    @IBAction func touchLoginButton(sender: AnyObject) {
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Logginng in with Touch ID",
                                   reply: { (success: Bool, error: NSError?) in
                                    if success {
                                        debugPrint("Success")
                                        self.performSegueWithIdentifier("loggedInSegue", sender: nil)
                                    }
                                    if error != nil {
                                        var message : NSString
                                        var showAlert : Bool

                                        switch(error!.code) {
                                            case LAError.AuthenticationFailed.rawValue:
                                                message = "There was a problem verifying your identity."
                                                showAlert = true
                                                break;
                                            case LAError.UserCancel.rawValue:
                                                message = "You pressed cancel."
                                                showAlert = true
                                                break;
                                            case LAError.UserFallback.rawValue:
                                                message = "You pressed password."
                                                showAlert = true
                                                break;
                                            default:
                                                showAlert = true
                                                message = "Touch ID may not be configured"
                                                break;
                                        }
                                        
                                        let alertView = UIAlertController(title: "Error",
                                            message: message as String, preferredStyle:.Alert)
                                        let okAction = UIAlertAction(title: "Darn!", style: .Default, handler: nil)
                                        alertView.addAction(okAction)
                                        if showAlert {
                                            self.presentViewController(alertView, animated: true, completion: nil)
                                        }

                                    }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
