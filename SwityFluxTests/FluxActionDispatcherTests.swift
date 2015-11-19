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

    var dispatcher: FluxActionDispatcher! = nil
    
    override func setUp() {
        super.setUp()
        self.dispatcher = FluxActionDispatcher()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
