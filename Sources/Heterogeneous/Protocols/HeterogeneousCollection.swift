//
//  HeterogeneousCollection.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 18/12/2025.
//

public protocol HeterogeneousCollection {
    associatedtype Key

    func fetch<Value>(_ key: HeterogeneousKey<Key, Value>) throws(HeterogeneousKeyError) -> Value
}

// MARK: Default Implementation
public extension HeterogeneousCollection {
    subscript<T>(_ valueType: T.Type = T.self, _ key: Key) -> T? {
        try? fetch(.init(key, valueType))
    }
}
