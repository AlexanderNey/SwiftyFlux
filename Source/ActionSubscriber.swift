//
//  ActionSubscriber.swift
//  SwityFlux
//
//  Created by Alexander Ney on 17/11/2015.
//  Copyright © 2015 Alexander Ney. All rights reserved.
//

import Foundation

public protocol ActionSubscriber {
    func digestAction(action: Action)
}