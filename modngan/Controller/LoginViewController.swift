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
import RealmSwift

class LoginViewController: UIViewController , FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: RadiusButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                print("User is signed in.")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let selectTypeVC = storyboard.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                self.present(selectTypeVC, animated: true, completion: nil)
            }
        }
        */
        
        
        
      
        
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
    
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
      
        return true
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        SVProgressHUD.show()
        
        
        if let error = error {
            print("error == \(error.localizedDescription)")
            SVProgressHUD.dismiss()
            return
        } else if (result.isCancelled) {
            SVProgressHUD.dismiss()
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
                    let realm = try! Realm()
                    
                    let user = User()
                    user.name = ""
                    user.isLogin = true
                    try! realm.write {
                        realm.add(user)
                    }
                    
                    SVProgressHUD.dismiss()
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
