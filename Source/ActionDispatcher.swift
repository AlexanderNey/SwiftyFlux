//
//  ActionDispatcher.swift
//  Bizzby
//
//  Created by Alexander Ney on 21/07/2015.
//  Copyright (c) 2015 Bizzby. All rights reserved.
//

import Foundation
import Futuristics

public protocol ActionDispatcher: class {
    func registerStore(store: Store)
    func unregisterStore(store: Store)
    func afterStoreDigests(store: Store, completion: Void -> Void)
    func dispatchAction(action: Action) -> Future<Void>
}


