//
//  SignupVC.swift
//  ClarifaiApiDemo
//
//  Created by Kalia Akkad on 2015-11-14.
//  Copyright © 2015 Clarifai, Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignupVC: UIViewController, FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fbLoginButton.delegate = self
        
        fbLoginButton.readPermissions =
            ["public_profile", "email", "user_friends"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpTapped(sender: AnyObject) {
        let gamePage =
        self.storyboard?.instantiateViewControllerWithIdentifier("OptionsVC") as! OptionsVC
        
        let gamePageNav = UINavigationController(rootViewController: gamePage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = gamePageNav
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error != nil)
        {
            print(error.localizedDescription)
            return
        }
        
        if let userToken = result.token
        {
            let token: FBSDKAccessToken = result.token
            
            print("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            
            print("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
        }
        
        let optionPage1 = self.storyboard?.instantiateViewControllerWithIdentifier("OptionsVC") as! OptionsVC
        
        let optionPageNav1 = UINavigationController(rootViewController: optionPage1)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = optionPageNav1
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out...")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

}
