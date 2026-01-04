//
//  HeterogeneousKey.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 20/09/2025.
//

public typealias HKey<Key, Value> = HeterogeneousKey<Key, Value>

@dynamicMemberLookup
public struct HeterogeneousKey<Key, Value> {
    // MARK: Variables
    public let data: Key

    var valueType: Value.Type { Value.self }

    // MARK: Initializers
    public init(_ data: Key, _: Value.Type = Value.self) {
        self.data = data
    }
}

// MARK: Self: Comparable
extension HeterogeneousKey: Comparable where Key: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.data < rhs.data
    }
}

// MARK: Self: CustomStringConvertible
extension HeterogeneousKey: CustomStringConvertible {
    public var description: String { "\(Value.self)#\(data)" }
}

// MARK: Self: Equatable
extension HeterogeneousKey: Equatable where Key: Equatable {}

// MARK: Self: ExpressibleByFloatLiteral
extension HeterogeneousKey: ExpressibleByFloatLiteral where Key: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Key.FloatLiteralType) {
        self.data = .init(floatLiteral: value)
    }
}

// MARK: Self: ExpressibleByIntegerLiteral
extension HeterogeneousKey: ExpressibleByIntegerLiteral where Key: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Key.IntegerLiteralType) {
        self.data = .init(integerLiteral: value)
    }
}

// MARK: Self: ExpressibleByStringLiteral
extension HeterogeneousKey: ExpressibleByUnicodeScalarLiteral where Key: ExpressibleByStringLiteral {}
extension HeterogeneousKey: ExpressibleByExtendedGraphemeClusterLiteral where Key: ExpressibleByStringLiteral {}
extension HeterogeneousKey: ExpressibleByStringLiteral where Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: Key.StringLiteralType) {
        self.data = .init(stringLiteral: value)
    }
}

// MARK: Self: Hashable
extension HeterogeneousKey: Hashable where Key: Hashable {}

// MARK: Self: Identifiable
@available(macOS 10.15, *)
public typealias IDKey<Value: Identifiable> = HeterogeneousKey<Value.ID, Value>

extension HeterogeneousKey: Identifiable where Key: Hashable {
    public var id: Key { data }
}

// MARK: Self: Sendable
extension HeterogeneousKey: Sendable where Key: Sendable {}

// MARK: Key == ObjectIdentifier
public typealias TypeKey<T> = HeterogeneousKey<ObjectIdentifier, T>

public extension HeterogeneousKey where Key == ObjectIdentifier {
    static func typed(_ type: Value.Type) -> Self {
        .init(ObjectIdentifier(type), type)
    }
}

// MARK: Key == String
public extension HeterogeneousKey where Key == String {
    static subscript(dynamicMember member: Key) -> Self {
        .init(member)
    }
}

// MARK: Value: Identifiable
@available(macOS 10.15, *)
public extension HeterogeneousKey where Value: Identifiable, Key == Value.ID {
    static func id(of value: Value) -> Self { .init(value.id) }
}

// MARK: Collection (EX)
public extension Collection {
    func fetch(_ key: HeterogeneousKey<Index, Element>) -> Element { self[key.data] }
}

public extension Collection where Element == Any {
    subscript<T>(_ key: HeterogeneousKey<Index, T>) -> T? { self[key.data] as? T }
}
