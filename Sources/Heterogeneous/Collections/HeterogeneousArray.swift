//
//  HeterogeneousArray.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 18/12/2025.
//

public typealias HArray = HeterogeneousArray

public struct HeterogeneousArray {
    // MARK: Variables
    var collection: [Any]

    var count: Int { collection.count }

    // MARK: Methods
    @discardableResult
    public mutating func append<Value>(_ value: Value) -> HeterogeneousKey<Int, Value> {
        let key = HKey(collection.count, Value.self)
        collection.append(value)
        return key
    }
}

// MARK: Self: ExpressibleByArrayLiteral
extension HeterogeneousArray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Any...) {
        collection = elements
    }
}

// MARK: Self: MutableHeterogeneousArray
extension HeterogeneousArray: MutableHeterogeneousCollection {
    public mutating func registerOrUpdate<Value>(_ element: Value, for key: HeterogeneousKey<Int, Value>) {
        collection[key.data] = element
    }

    public func fetch<Value>(_ key: HeterogeneousKey<Int, Value>) throws(HeterogeneousKeyError) -> Value {
        guard collection.indices.contains(key.data) else { throw .invalidKey }

        guard let typedValue = collection[key.data] as? Value else { throw .typeMismatch }

        return typedValue
    }
}
