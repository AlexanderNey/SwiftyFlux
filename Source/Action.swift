//
//  Action.swift
//  Bizzby
//
//  Created by Alexander Ney on 29/07/2015.
//  Copyright (c) 2015 Bizzby. All rights reserved.
//

import Foundation

public protocol Action { }

public protocol ActionTransportsError : Action {
    var error: ErrorType { get }
}

public protocol ActionTransportsResult : Action {
    typealias ResultType
    var result: ResultType { get }
}

