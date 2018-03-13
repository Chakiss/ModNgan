//
//  User.swift
//  modngan
//
//  Created by CHAKRIT PANIAM on 9/17/17.
//  Copyright © 2017 Chakrit. All rights reserved.
//


import RealmSwift

class User: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var isLogin = false
    @objc dynamic var type = false
    
}
