//
//  Tuple.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 16/08/2025.
//

public import Heterogeneous

@available(macOS 14, iOS 17, *)
public struct Tuple<each Element> {
    // MARK: Variables
    public private(set) var array: HeterogeneousArray

    // MARK: Initializers
    public init(_ elements: repeat each Element) {
        self.array = []

        for item in repeat each elements {
            array.append(item)
        }
    }
}

// MARK: Self.AllTypes
@available(macOS 14, iOS 17, *)
public extension Tuple {
    typealias AllTypes = Tuple<repeat (each Element).Type>

    static var allTypes: AllTypes { .init(repeat (each Element).self) }
    static func canStore<Value>(_ valueType: Value.Type, in index: Int) -> Bool {
        var counter = 0

        for t in repeat (each Element).self {
            if counter == index { return t == valueType}

            counter += 1
        }

        return false
    }
}

// MARK: Self: MutableHeterogeneousCollection
@available(macOS 14, iOS 17, *)
extension Tuple: MutableHeterogeneousCollection {
    public func fetch<Value>(_ key: HeterogeneousKey<Int, Value>) throws(HeterogeneousKeyError) -> Value {
        try array.fetch(key)
    }

    public mutating func registerOrUpdate<Value>(_ element: Value, on key: HeterogeneousKey<Int, Value>) {
        guard Self.canStore(Value.self, in: key.data) else { return }

        array.registerOrUpdate(element, on: key)
    }

    public subscript<Value>(_ type: Value.Type, key: Int) -> Value? {
        get { try? fetch(.init(key, type)) }
        set {
            guard let newValue else { return }

            registerOrUpdate(newValue, on: .init(key, type)) }
    }
}
