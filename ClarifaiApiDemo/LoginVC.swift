//
//  LoginVC.swift
//  ClarifaiApiDemo
//
//  Created by Kalia Akkad on 2015-11-14.
//  Copyright © 2015 Clarifai, Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signButtonTapped(sender: AnyObject) {
        let signupPage =
        self.storyboard?.instantiateViewControllerWithIdentifier("SignupVC") as! SignupVC
        
        let signupPageNav = UINavigationController(rootViewController: signupPage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = signupPageNav
        
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let loginPage =
        self.storyboard?.instantiateViewControllerWithIdentifier("SignInVC") as! SignInVC
        
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginPageNav
        
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
