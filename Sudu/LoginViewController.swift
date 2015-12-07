//
//  LoginViewController.swift
//  Sudu
//
//  Created by xiwei feng on 12/5/15.
//  Copyright © 2015 xiwei feng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // Mark: Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        let loginURL = NSURL(string: "https://superuserdue.herokuapp.com/sudu6770/login/")
        let request = NSMutableURLRequest(URL: loginURL!)
        request.HTTPMethod = "POST"
        
        let postString = "email_addr=" + emailTextField.text! + "&password=" + passwordTextField.text!
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print(NSString(data: data!, encoding:NSUTF8StringEncoding))
                    dispatch_async(dispatch_get_main_queue(), {
                        //Code that presents or dismisses a view controller here
                        self.performSegueWithIdentifier("conditionalSegue", sender: nil)
                    })
                }
                else if httpResponse.statusCode == 400 {
                    print("Wrong password or email")
                }
                else {
                    print("Network failed!")
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let projectViewController = segue.destinationViewController as! UINavigationController
        let viewController = projectViewController.topViewController as! ProjectTableViewController
        
        viewController.email = emailTextField.text
    }

}
