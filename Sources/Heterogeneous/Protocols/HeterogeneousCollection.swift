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

    func fetch<T>(on keyPath: KeyPath<T.Type, Key>, as type: T.Type) throws(HeterogeneousKeyError) -> T? {
        try fetch(.init(type[keyPath: keyPath], type))
    }

    func scope<H: HeterogeneousCollection>(for key: HeterogeneousKey<Key, H>) throws(HeterogeneousKeyError) -> H {
        try fetch(key)
    }
}

// MARK: Self.Key == String
public extension HeterogeneousCollection where Key == String {
    subscript<T>(dynamicMember member: Key) -> T? {
        self[T.self, member]
    }
}
