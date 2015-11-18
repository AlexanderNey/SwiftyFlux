//
//  Store.swift
//  Bizzby
//
//  Created by Alexander Ney on 21/07/2015.
//  Copyright (c) 2015 Bizzby. All rights reserved.
//

import Foundation

protocol Store: class, ActionSubscriber {
    var latestUpdate: NSDate? { get }
    init(dispatcher: ActionDispatcher)
    func addObserver(observer: StoreObserver)
    func removeObserver(observer: StoreObserver)
    func storeChangeNotifyObserver()
}

protocol StoreObserver: class {
    func storeDidChange(store: Store)
}

class BaseStore : Store {
    
    let dispatcher: ActionDispatcher
    private var observer = [StoreObserver]()
    var latestUpdate: NSDate?
    
    // MARK: Store
    
    required init(dispatcher: ActionDispatcher) {
        self.dispatcher = dispatcher
        self.dispatcher.registerSubscriber(self)
    }
    
    deinit {
        self.dispatcher.unregisterSubscriber(self)
    }
    
    func addObserver(observer: StoreObserver) {
        if !self.observer.contains({ $0 === observer }) {
            self.observer.append(observer)
            observer.storeDidChange(self)
        }
    }
    
    func removeObserver(observer: StoreObserver) {
        self.observer = self.observer.filter { $0 !== observer }
    }
    
    
    // MARK: ActionSubscriber
    
    func digestAction(action: Action) -> Bool {
        return false
    }
    
    
    // MARK: Notify Observer
    
    func storeChangeNotifyObserver() {
        self.latestUpdate = NSDate()
        onMainThread {
            for observer in self.observer {
                observer.storeDidChange(self)
            }
        }
    }
    
}