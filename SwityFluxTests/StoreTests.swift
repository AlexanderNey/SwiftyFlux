//
//  StoreTests.swift
//  SwityFlux
//
//  Created by Alexander Ney on 20/11/2015.
//  Copyright © 2015 Alexander Ney. All rights reserved.
//

import XCTest
import SwityFlux
import Futuristics


class StoreTests: XCTestCase {
    
    func test_store_digests_action() {
        
        let dispatcher = FluxActionDispatcher()
        let store = StoreWithHistory(dispatcher: dispatcher)
        
        let dispatchExpectation = self.expectationWithDescription("should digest frist action")
        
        dispatcher.dispatchAction(SimpleAction()).onSuccess { dispatchExpectation.fulfill() }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
        XCTAssertEqual(store.actionHistory.count, 1, "should have digested one action")
        XCTAssertNotNil(store.actionHistory.first as? SimpleAction, "first action should be of Type SimpleAction")
        
        let secondDispatchExpectation = self.expectationWithDescription("should digest second action")
        
        dispatcher.dispatchAction(PayloadAction()).onSuccess { secondDispatchExpectation.fulfill() }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
        XCTAssertEqual(store.actionHistory.count, 2, "should have digested two actions")
         XCTAssertNotNil(store.actionHistory.last as? PayloadAction, "first action should be of Type PayloadAction")
    }
}