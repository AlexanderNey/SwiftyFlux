//
//  DispatcherImplementation.swift
//  SwityFlux
//
//  Created by Alexander Ney on 18/11/2015.
//  Copyright © 2015 Alexander Ney. All rights reserved.
//

import Foundation
import Futuristics


public class FluxActionDispatcher : ActionDispatcher {
    
    public enum State { case Idle, Dispatching }
    
    let dispatchQueue = dispatch_queue_create("com.flux-dispatcher.queue", nil)
    public private (set) var state = State.Idle
    
    
    public private (set) var stores = [Store]()
    private var currentDispatchCycle = [(store: Store, actionDigestPromise:Promise<Void>)]()
    
    public init() { }
    
    // MARK: Operation Queue
    
    public func closureOnOperationQueue<T, U>(closure: T throws -> U) -> (T -> Future<U>) {
        return onQueue(self.dispatchQueue, after:  nil)(closure)
    }

    // MARK: ActionDispatcher
    
    public func registerStore(store: Store) {
        self.closureOnOperationQueue {
            if !self.stores.contains({ $0 === store }) {
                self.stores.append(store)
            }
        }()
    }
    
    public func unregisterStore(store: Store) {
         self.closureOnOperationQueue { _ in
            self.stores = self.stores.filter { return $0 !== store }
        }()
    }
    
    public func afterStoreDigests(store: Store, completion: Void -> Void) {
        if let promise = self.actionDigestPromiseForStore(store) {
            promise.future.finally( onQueue(self.dispatchQueue, after:  nil), handler: completion)
        } else {
            fatalError("Store '\(store)' not regsitered")
        }
    }
    
    public func dispatchAction(action: Action) {
        self.closureOnOperationQueue {
            self.beginDispatchCycle()
            self.stores.forEach { store in
                store.digestAction(action)
                self.storeDidDigest(store)
            }
            self.endDispatchCycle()
        }()
    }
    
    // MARK: Dispatch Cycle
    
    private func storeDidDigest(store: Store) {
        if let promise = self.actionDigestPromiseForStore(store) {
            promise.fulfill()
        }
    }

    private func actionDigestPromiseForStore(store: Store) -> Promise<Void>? {
        for pair in self.currentDispatchCycle {
            if pair.store === store {
                return pair.actionDigestPromise
            }
        }
        return nil
    }
    
    private func endDispatchCycle() {
        self.currentDispatchCycle = []
        self.state = .Idle
    }
    
    private func beginDispatchCycle() {
        self.state = .Dispatching
        self.currentDispatchCycle = self.stores.map { (store: $0, actionDigestPromise:Promise<Void>()) }
    }


}