//
//  FluxActionDispatcherTests.swift
//  FluxActionDispatcherTests
//
//  Created by Alexander Ney on 03/08/2015.
//  Copyright (c) 2015 Alexander Ney. All rights reserved.
//

import UIKit
import XCTest
import SwityFlux


class FluxActionDispatcherTests: XCTestCase {

    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func new_dispatcher_should_not_have_any_stores() {
        let dispatcher = FluxActionDispatcher()
        XCTAssertEqual(dispatcher.stores.count, 0, "should not have any stores")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
