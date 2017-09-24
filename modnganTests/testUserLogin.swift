//
//  testUserLogin.swift
//  modngan
//
//  Created by Chakrit on 7/11/2560 BE.
//  Copyright © 2560 Chakrit. All rights reserved.
//

import XCTest

//class user : RLMObject{
    
//}

class testUserLogin: XCTestCase {
    
    override func setUp() {
        super.setUp()
        self.buildMockUserTestData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func buildMockUserTestData(){
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
