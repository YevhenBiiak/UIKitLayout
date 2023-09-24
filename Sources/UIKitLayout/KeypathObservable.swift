//
//  KeypathObservable.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit

public protocol KeypathObservable {}
extension NSObject: KeypathObservable {}

extension KeypathObservable where Self: NSObject {
    
    @discardableResult
    public func onChange<Value>(_ keyPath: KeyPath<Self, Value>, _ handler: @escaping (Value) -> Void) -> Self {
        publisher(for: keyPath)
            .sink(receiveValue: handler)
            .store(in: self)
        return self
    }
}
