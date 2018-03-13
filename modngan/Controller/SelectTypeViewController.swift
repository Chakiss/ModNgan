//
//  SelectTypeViewController.swift
//  modngan
//
//  Created by CHAKRIT PANIAM on 11/19/17.
//  Copyright © 2017 Chakrit. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftyJSON

class SelectTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func employeeButtonTapped(_ sender: Any) {
        
        
        FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id, email, first_name, last_name,gender, locale, timezone, picture, updated_time, verified"]).start(completionHandler: { (connection, result, error) in
            if error == nil {
                print("User Info : \(String(describing: result))")
                let json = JSON(result!)
                let db = Firestore.firestore()
                
                let user = Auth.auth().currentUser
                if let user = user {
                
                    let uid = user.uid
                    db.collection(employee).document(uid).setData([
                        "first_name"    : json["first_name"].stringValue,
                        "last_name"     : json["last_name"].stringValue,
                        "gender"        : json["gender"].stringValue,
                        "profile_image" : json["picture"]["data"]["url"].stringValue,
                        "id"            : uid
                        ])
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let entrepreneurListVC = storyboard.instantiateViewController(withIdentifier: "EntrepreneurListViewController") as! EntrepreneurListViewController
                    self.present(entrepreneurListVC, animated: true, completion: nil)
                    
                }
                
                
            } else {
                print("Error Getting Info \(String(describing: error))");
            }
        })
        
        
        
    }
    
    @IBAction func entrepreneurButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let entrepreneurSignUpVC = storyboard.instantiateViewController(withIdentifier: "EntrepreneurSignupViewController") as! EntrepreneurSignupViewController
        self.present(entrepreneurSignUpVC, animated: true, completion: nil)
    }
    
}
