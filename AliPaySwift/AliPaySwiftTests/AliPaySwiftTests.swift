//
//  AliPaySwiftTests.swift
//  AliPaySwiftTests
//
//  Created by mac on 16/1/7.
//  Copyright © 2016年 planning. All rights reserved.
//

import XCTest
@testable import AliPaySwift

var key:String = "9Kl6VelhQgYGqB1fD3lD6J97Gv58g5ZsPmpccByiwC4g2f3j8SgohjGoJwJAXIIicqMkzNaEKScgn7pFMeWqMCiVJQ17wPDO64qigjlH66yfCdh0gKus1IpklkhSdd6y3osmhfWZZqCxEpKEeQJAb2eQQyHnNUfXGN+HHQM/ocuH096KDYwnpJzD5KKf9UvXz1rabKR478XvDEdzpsJm0wt/i5EMCAIyguAiO/WulQJAI9IuYeXBaxTVR5wSGUjO0hH1LoBJfds2uo4xPQcAes+4lQmjwwKXYXyHGvkpKFky53n92WaWKsIagys9MfCHKA"

class AliPaySwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(key)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
