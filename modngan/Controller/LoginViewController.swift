//
//  LoginViewController.swift
//  modngan
//
//  Created by CHAKRIT PANIAM on 8/27/17.
//  Copyright © 2017 Chakrit. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController , FBSDKLoginButtonDelegate {
   
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: RadiusButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.style = .Blue
        self.loginButton.title = "Login"
        
        
        facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        facebookLoginButton.delegate = self
        
        for const in facebookLoginButton.constraints{
            if const.firstAttribute == NSLayoutAttribute.height && const.constant == 28{
                facebookLoginButton.removeConstraint(const)
            }
        }
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    /**
     Sent to the delegate when the button was used to login.
     - Parameter loginButton: the sender
     - Parameter result: The results of the login
     - Parameter error: The error (if any) from the login
     */
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        if let error = error {
            print("error == \(error.localizedDescription)")
            return
        } else if (result.isCancelled) {
            print("cancel")
        } else {
            let result : FBSDKLoginManagerLoginResult = result
            print("result == \(result)")
            /*
            if ([result.grantedPermissions containsObject:@"email"])
            {
                NSLog(@"result is:%@",result);
                [self fetchUserInfo];
            }
             */
            if (result.grantedPermissions.contains("email")){
                print("result == \(result)")
                self.fetchUserInfo()
            }
            
            
            if Auth.auth().currentUser != nil {
                // User is signed in.
                // ...
                print("User is signed in.")
            } else {
                // No user is signed in.
                // ...
                print("No user is signed in.")
            }
            
        }
        
    }
    
    func fetchUserInfo() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            else
            {
                print("the access token is \(FBSDKAccessToken.current().tokenString)")
                
//                var accessToken = FBSDKAccessToken.current().tokenString
                let rere = result as! NSDictionary!
                let userID = rere?.value(forKey: "id") as! NSString
                _ = "http://graph.facebook.com/\(userID)/picture?type=large"
                
                
                
                print("fetched user: \(String(describing: result))")

            }
        })
    }

}
