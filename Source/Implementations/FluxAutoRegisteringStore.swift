//
//  FluxAutoRegisteringStore.swift
//  SwityFlux
//
//  Created by Alexander Ney on 19/11/2015.
//  Copyright © 2015 Alexander Ney. All rights reserved.
//

import Foundation


public class FluxAutoRegisteringStore : Store {
    
    let dispatcher: ActionDispatcher
    private var observer = [StoreObserver]()
    public var latestUpdate: NSDate?
    
    // MARK: Store
    
    required public init(dispatcher: ActionDispatcher) {
        self.dispatcher = dispatcher
        self.dispatcher.registerStore(self)
    }
    
    deinit {
        self.dispatcher.unregisterStore(self)
    }
    
    public   func addObserver(observer: StoreObserver) {
        if !self.observer.contains({ $0 === observer }) {
            self.observer.append(observer)
            observer.storeDidChange(self)
        }
    }
    
    public func removeObserver(observer: StoreObserver) {
        self.observer = self.observer.filter { $0 !== observer }
    }
    
    
    // MARK: ActionSubscriber
    
    public func digestAction(action: Action) -> Bool {
        return false
    }
    
    
    // MARK: Notify Observer
    
    public func storeChangeNotifyObserver() {
        self.latestUpdate = NSDate()
        dispatch_async(dispatch_get_main_queue()) {
            for observer in self.observer {
                observer.storeDidChange(self)
            }
        }
    }
    
}
