//
//  AddressPickerViewTests.swift
//  DiamondClient
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import XCTest


//class ViewController: UIViewController,AddressPickerDelegate {
//    
//    let picker = AddressPickerView()
//    
//    func OnUpdate(sender: AddressPickerView) {
//        print(sender.getResult())
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        picker.addressDelegate = self
//        self.view.addSubview(picker)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//}


class AddressPickerViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
