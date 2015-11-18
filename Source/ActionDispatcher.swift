//
//  ActionDispatcher.swift
//  Bizzby
//
//  Created by Alexander Ney on 21/07/2015.
//  Copyright (c) 2015 Bizzby. All rights reserved.
//

import Foundation


public protocol ActionDispatcher {
    func registerSubscriber(subscriber: ActionSubscriber)
    func unregisterSubscriber(subscriber: ActionSubscriber)
    //func waitForSubscriber(subscriber: ActionSubscriber) -> Future<Void>
    func dispatchAction(action: Action)
}


public class Dispatcher : ActionDispatcher {
    
    enum State {
        case Pending, Dispatching
    }
    
    let dispatchQueue = dispatch_queue_create("com.flux-dispatcher.queue", nil)
    var state = State.Pending
    
    struct SubscriberEntity {
        var promiseGuarantor: Int //PromiseGuarantor<Void>
        var subscriber: ActionSubscriber
    }
    
    var subscribers = [SubscriberEntity]()
    
    private subscript (subscriber: ActionSubscriber) -> SubscriberEntity? {
        for entity in self.subscribers {
            if entity.subscriber === subscriber {
                return entity
            }
        }
        return nil
    }
    
    public func registerSubscriber(subscriber: ActionSubscriber) {
        if self[subscriber] == nil {
            let entity = SubscriberEntity(promiseGuarantor: 0, subscriber: subscriber)
            //self.subscriberEntities.append(entity)
            self.subscribers.insert(entity, atIndex: 0) // FIXME: this if for testing
        }
    }
    
    public func unregisterSubscriber(subscriber: ActionSubscriber) {
        self.subscribers = self.subscribers.filter { return $0.subscriber !== subscriber }
    }
    
    public func waitForSubscriber(subscriber: ActionSubscriber, completion: Void -> Void) {
        if let entity = self[subscriber] {
            entity.promiseGuarantor.promise.onCompletion { _ in
                completion()
            }
        } else {
            fatalError("\(subscriber) not regsitered")
        }
    }
    
    public func dispatchAction(action: Action) {
        self.state = .Dispatching
        onQueue(self.dispatchQueue) {
            self.subscribers.forEach { entity in
                entity.subscriber.digestAction(action)
                //subscriber.promiseGuarantor.resolve()
            }
            self.resetSubscribers()
            onMainThread { self.state = .Pending }
        }
    }
    
    private func resetSubscribers() {
        self.subscriberEntities = self.subscriberEntities.map {
            SubscriberEntity(promiseGuarantor: PromiseGuarantor<Void>(), subscriber: $0.subscriber)
        }
    }
}