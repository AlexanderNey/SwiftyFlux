//
//  TestStores.swift
//  SwityFlux
//
//  Created by Alexander Ney on 20/11/2015.
//  Copyright © 2015 Alexander Ney. All rights reserved.
//

import Foundation
import SwityFlux


class StoreWithHistory : FluxAutoRegisteringStore {
    var actionHistory = [Action]()
    override func digestAction(action: Action) {
        self.actionHistory.append(action)
    }
}