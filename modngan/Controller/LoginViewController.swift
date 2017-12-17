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
import SVProgressHUD

class LoginViewController: UIViewController , FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: RadiusButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                print("User is signed in.")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let selectTypeVC = storyboard.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                self.present(selectTypeVC, animated: true, completion: nil)
            }
        }
        
        
        
        
      
        
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
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        
        if let error = error {
            print("error == \(error.localizedDescription)")
            SVProgressHUD.dismiss()
            return
        } else if (result.isCancelled) {
            SVProgressHUD.dismiss()
            print("cancel")
            return
        } else {
            SVProgressHUD.dismiss()
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    // ...
                    print(error)
                    return
                }
                else {
                    
                    let db = Firestore.firestore()
                    var ref: DocumentReference? = nil
                    ref = db.collection("employee").document((user?.uid)!).setData(data: [
                        "firstName": Auth.auth().currentUser!.uid,
                        "lastName": "Lovelace",
                        "id": user?.uid as Any
                        ])
                    
                    ref = db.collection("employee").addDocument(data: [
                        "firstName": Auth.auth().currentUser!.uid,
                        "lastName": "Lovelace",
                        "id": user?.uid as Any
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
 
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let selectTypeVC = storyboard.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                    self.present(selectTypeVC, animated: true, completion: nil)
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
