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
                    
                    let user = Auth.auth().currentUser
                    if let user = user {
                       
                        let uid = user.uid
                        let email = user.email
                        let photoURL = user.photoURL
                        let user = User()
//                        user.id = Int(uid)!
//                        user.name = user.name
//                        
//                        try! realm.write {
//                            realm.add(user)
//                        }
                        
            
                        print(email as! String)
                        print(photoURL as! URL)
                    }
                }
                // User is signed in
                // ...
            }
        
            /*
            let result : FBSDKLoginManagerLoginResult = result
            print("result == \(result)")
            self.fetchUserInfo()
            if (result.grantedPermissions.contains("email")){
                print("result == \(result)")
                
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
             */
            
        }
        
    }


    func fetchUserInfo() {
        let graphRequest : FBSDKGraphRequest =  FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name,birthday,first_name,last_name,gender"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
        
        
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
                
                
                
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                // [END headless_facebook_auth]
                self.firebaseLogin(credential)
                
                /*
                 
                 let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc : UINavigationController = storyboard.instantiateViewController(withIdentifier: "SignUpNavigationController") as! UINavigationController
                 
                 self.present(vc, animated: true, completion: nil)
                 
                 */
                
            }
        })
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        if let user = Auth.auth().currentUser {
            // [START link_credential]
            user.link(with: credential) { (user, error) in
                // [START_EXCLUDE]
                //self.hideSpinner {
                    if let error = error {
                        self.showMessagePrompt(error.localizedDescription as NSString)
                        return
                    }
                    //self.tableView.reloadData()
                //}
                // [END_EXCLUDE]
            }
            // [END link_credential]
        } else {
            // [START signin_credential]
            Auth.auth().signIn(with: credential) { (user, error) in
                // [START_EXCLUDE silent]
                //self.hideSpinner {
                    // [END_EXCLUDE]
                    if let error = error {
                        // [START_EXCLUDE]
                        self.showMessagePrompt(error.localizedDescription as NSString)
                        // [END_EXCLUDE]
                        return
                    }
                    // User is signed in
                    // [START_EXCLUDE]
                    // Merge prevUser and currentUser accounts and data
                    // ...
                    // [END_EXCLUDE]
               // }
            }
            // [END signin_credential]
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
