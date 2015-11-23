//
//  TestActions.swift
//  SwityFlux
//
//  Created by Alexander Ney on 20/11/2015.
//  Copyright © 2015 Alexander Ney. All rights reserved.
//

import Foundation
import SwityFlux


struct SimpleAction: Action { }

struct PayloadAction: Action {
    var payload: String?
}