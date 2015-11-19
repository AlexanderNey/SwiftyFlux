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
import Futuristics


class FluxActionDispatcherTests: XCTestCase {

    struct SimpleAction: Action { }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_new_dispatcher() {
        let dispatcher = FluxActionDispatcher()
        XCTAssertEqual(dispatcher.stores.count, 0, "should not have any stores")
        XCTAssertEqual(dispatcher.state, FluxActionDispatcher.State.Idle, "should be idle")
        
        let dispatchExpectation = self.expectationWithDescription("should disgest action")

        dispatcher.dispatchAction(SimpleAction()).onSuccess(onMainQueue()) {
            dispatchExpectation.fulfill()
        }.onFailure { _ in
            XCTFail("dispatch action failed")
        }
        
        self.waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func test_dispatcher_registers_store() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}