//
//  EntrepreneurListViewController.swift
//  modngan
//
//  Created by CHAKRIT PANIAM on 17/12/17.
//  Copyright © 2017 Chakrit. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class EntrepreneurListViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
          determineMyCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       
    }

    
    func determineMyCurrentLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        updateUserLocation(userLocation)
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    func updateUserLocation(_ userLocation: CLLocation) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let uid = user?.uid
        let userRef = db.collection(employee).document(uid!)
        
        userRef.updateData([ "location" : GeoPoint(latitude: userLocation.coordinate.latitude,
                                                   longitude: userLocation.coordinate.longitude)]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        /*
         washingtonRef.updateData([
         "capital": true
         ]) { err in
         if let err = err {
         print("Error updating document: \(err)")
         } else {
         print("Document successfully updated")
         }
         }
 */
        /*
        db.collection(employee).document(uid!).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            print("Current data: \(document.data())")
        }
        */
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
