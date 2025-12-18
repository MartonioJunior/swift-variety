//
//  MutableHeterogeneousCollection.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 18/12/2025.
//

public protocol MutableHeterogeneousCollection: HeterogeneousCollection {
    mutating func registerOrUpdate<Value>(
        _ element: Value,
        on key: HeterogeneousKey<Key, Value>
    )
}
