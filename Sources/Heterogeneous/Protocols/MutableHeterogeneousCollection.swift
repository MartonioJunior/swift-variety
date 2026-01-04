//
//  MutableHeterogeneousCollection.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 18/12/2025.
//

public protocol MutableHeterogeneousCollection: HeterogeneousCollection {
    mutating func registerOrUpdate<Value>(
        _ element: Value,
        for key: HeterogeneousKey<Key, Value>
    )
}

// MARK: Default Implementation
public extension MutableHeterogeneousCollection {
    mutating func merge<Value>(
        _ value: Value,
        for key: HeterogeneousKey<Key, Value>,
        _ merge: (Value, Value) -> Value
    ) throws(HeterogeneousKeyError) {
        do {
            let oldValue = try fetch(key)
            registerOrUpdate(merge(oldValue, value), for: key)
        } catch let error {
            switch error {
                case .invalidKey:
                    registerOrUpdate(value, for: key)
                case .typeMismatch:
                    return
            }
        }
    }
}

// MARK: Self.Key == String
public extension MutableHeterogeneousCollection where Key == String {
    subscript<T>(dynamicMember member: String) -> T? {
        get { self[T.self, member] }
        set {
            guard let newValue else { return }

            registerOrUpdate(newValue, for: .init(member, T.self))
        }
    }
}
