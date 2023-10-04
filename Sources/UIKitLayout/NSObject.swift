//
//  NSObject.swift
//
//  Created by Yevhen Biiak on 19.08.2023.
//

import Foundation
import Combine

extension NSObject {
    func getAssociatedObject<T>(key: inout String) -> T? {
        withUnsafePointer(to: &key) {
            objc_getAssociatedObject(self, $0) as? T
        }
    }
    func setAssociatedObject<T>(key: inout String, value: T) {
        withUnsafePointer(to: &key) {
            objc_setAssociatedObject(self, $0, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

internal final class NSCancellable: NSObject {
    let cancellable: AnyCancellable
    
    init(_ cancellable: AnyCancellable) {
        self.cancellable = cancellable
    }
    
    func cancel() {
        self.cancellable.cancel()
    }
}

extension NSObject {
    static var _ns_cancellables = "_ns_cancellables"
    
    internal var cancellables: Set<NSCancellable> {
        get { getAssociatedObject(key: &Self._ns_cancellables) ?? [] }
        set { setAssociatedObject(key: &Self._ns_cancellables, value: newValue) }
    }
}

extension AnyCancellable {
    internal func store(in nsObject: NSObject) {
        nsObject.cancellables.insert(NSCancellable(self))
    }
}
