//
//  OptionsVC.swift
//  ClarifaiApiDemo
//
//  Created by Kalia Akkad on 2015-11-15.
//  Copyright © 2015 Clarifai, Inc. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    @IBAction func easyTapped(sender: AnyObject) {
        let gamePage =
        self.storyboard?.instantiateViewControllerWithIdentifier("SwiftRecognitionViewController") as! SwiftRecognitionViewController
        
        let gamePageNav = UINavigationController(rootViewController: gamePage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = gamePageNav
    }
    @IBAction func mediumTapped(sender: AnyObject) {
        let gamePage =
        self.storyboard?.instantiateViewControllerWithIdentifier("SwiftRecognitionViewController") as! SwiftRecognitionViewController
        
        let gamePageNav = UINavigationController(rootViewController: gamePage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = gamePageNav
    }
    
    @IBAction func hardTapped(sender: AnyObject) {
        let gamePage =
        self.storyboard?.instantiateViewControllerWithIdentifier("SwiftRecognitionViewController") as! SwiftRecognitionViewController
        
        let gamePageNav = UINavigationController(rootViewController: gamePage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = gamePageNav
    }
    
    @IBAction func leaderboardTapped(sender: AnyObject) {
        let gamePage = self.storyboard?.instantiateViewControllerWithIdentifier("LeaderboardVC") as! LeaderboardVC
        
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

}
