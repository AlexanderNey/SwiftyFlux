//
//  GCD+Extensions.swift
//  Bizzby
//
//  Created by Alexander Ney on 02/02/2015.
//  Copyright (c) 2015 Bizzby. All rights reserved.
//

import Foundation



func onMainThread(closure: Void -> Void) {
    if (NSThread.isMainThread()) {
        closure()
    } else {
        dispatch_async(dispatch_get_main_queue()) {
            closure()
        }
    }
}

func onMainThread(withDelay delay: Double, closure: Void -> Void) {
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            closure()
    }
}

func onBackgroundThread(closure: Void -> Void) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
        closure()
    }
}

func onQueue(queue: dispatch_queue_t, closure: Void -> Void) {
    dispatch_async(queue) {
        closure()
    }
}

func onQueueSync(queue: dispatch_queue_t, closure: Void -> Void) {
    dispatch_sync(queue) {
        closure()
    }
}