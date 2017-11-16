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
        
        self.loginButton.style = .Green
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
            return
        } else {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    // ...
                    print(error)
                    return
                }
                else {
                    
                    if let user = Auth.auth().currentUser {
                    
                        if let email = user.email {
                            print(email)
                        }
                        if let photoURL = user.photoURL{
                            print(photoURL)
                        }
                        
                    }
                }
        
            }
        
            
        }
        
    }

    
}

extension UIViewController {
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = .black
        let someAction = UIAlertAction(title: "Some", style: .default, handler: nil)
        alertController.addAction(someAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showMessagePrompt(_ message : NSString) -> Void{
        
    }
}
