//
//  Store.swift
//  Bizzby
//
//  Created by Alexander Ney on 21/07/2015.
//  Copyright (c) 2015 Bizzby. All rights reserved.
//

import Foundation

public protocol Store: class, ActionSubscriber {
    var latestUpdate: NSDate? { get }
    func addObserver(observer: StoreObserver)
    func removeObserver(observer: StoreObserver)
    func storeChangeNotifyObserver()
}

public protocol StoreObserver: class {
    func storeDidChange<S: Store>(store: S)
}