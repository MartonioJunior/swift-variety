//
//  HeterogeneousDictionary.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 17/12/2025.
//

public typealias HDictionary<Key: Hashable> = HeterogeneousDictionary<Key>

@dynamicMemberLookup
public struct HeterogeneousDictionary<Key: Hashable> {
    // MARK: Variables
    var collection: [Key: Any]

    // MARK: Initializers
    public init(_ collection: [Key: Any]) {
        self.collection = collection
    }

    // MARK: Methods
    func forEach(_ closure: (Key, Any) -> Void) {
        for (key, value) in collection {
            closure(key, value)
        }
    }

    public mutating func register<Value>(
        _ newElement: Value,
        on key: HeterogeneousKey<Key, Value>,
        merge: (Value, Value) -> Value = { _, new in new }
    ) {
        let key = key.data

        if let value = collection[key] {
            guard let oldElement = value as? Value else { return }

            collection[key] = merge(oldElement, newElement)
        } else {
            collection[key] = newElement
        }
    }

    public mutating func remove<Value>(_ key: HeterogeneousKey<Key, Value>) {
        collection.removeValue(forKey: key.data)
    }

    public mutating func removeAll() {
        collection.removeAll()
    }
}

// MARK: Self: ExpressibleByDictionaryLiteral
extension HeterogeneousDictionary: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Any)...) {
        collection = .init(uniqueKeysWithValues: elements)
    }
}

// MARK: Self: MutableHeterogeneousCollection
extension HeterogeneousDictionary: MutableHeterogeneousCollection {
    public func fetch<Value>(_ key: HeterogeneousKey<Key, Value>) throws(HeterogeneousKeyError) -> Value {
        guard let value = collection[key.data] else { throw .invalidKey }

        guard let typedValue = value as? Value else { throw .typeMismatch }

        return typedValue
    }

    public mutating func registerOrUpdate<Value>(
        _ element: Value,
        for key: HeterogeneousKey<Key, Value>
    ) {
        collection[key.data] = element
    }
}

// MARK: Key == ObjectIdentifier
public extension HeterogeneousDictionary where Key == ObjectIdentifier {
    init<each Value>(_ values: repeat each Value) {
        self.init([:])
        for element in repeat each values {
            self.registerOrUpdate(element, for: .typed(type(of: element)))
        }
    }

    func fetch<Value>(_ type: Value.Type) throws(HeterogeneousKeyError) -> Value {
        try fetch(.typed(type))
    }

    mutating func registerOrUpdate<Value>(_ value: Value) {
        registerOrUpdate(value, for: .typed(Value.self))
    }
}

// MARK: Key == String
public typealias Blackboard = HeterogeneousDictionary<String>
