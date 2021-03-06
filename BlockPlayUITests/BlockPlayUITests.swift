//
//  BlockPlayUITests.swift
//  BlockPlayUITests
//
//  Created by Steve Baker on 9/21/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest

class BlockPlayUITests: XCTestCase {
        
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

        let app = XCUIApplication()

        // navigate back and forth many times, manually watch memory usage.
        for _ in 0..<100 {
            // navigate to BSViewController
            app.buttons["Navigate To Next"].tap()

            // tap gizmos button to run block that captures self
            app.buttons["gizmos"].tap()

            // navigate to BSOtherVC
            app.navigationBars["BSView"].buttons["Back"].tap()

            // TODO: Consider programmatically simulate low memory warning to free image if it isn't in a retain cycle
            // Compile error use of unresolved identifier
            // https://stackoverflow.com/questions/4717138/ios-development-how-can-i-induce-low-memory-warnings-on-device
            // UIApplication.shared.perform(#selector(_performMemoryWarnin‌​g))
        }
    }
    
}
