//
//  HeterogeneousKey+Tests.swift
//  Variety
//
//  Created by Martônio Júnior on 04/01/2026.
//

@testable import Heterogeneous
import Testing

struct HeterogeneousKeyTests {
    typealias Mock = HeterogeneousKey<String, Int>

    @Test("Creates a new instance for type", arguments: [
        ("Mesa")
    ])
    func initializer(_ key: String) {
        let result = HeterogeneousKey<String, Int>(key)
        #expect(result.data == key)
    }

    // MARK: Self: CustomStringConvertible
    @Test("Returns the identifier for a key", arguments: [
        (Mock("isj", Int.self), "Mock#isj")
    ])
    func description(_ sut: HKey<String, Int>, expected: String) {
        let result = sut.description
        #expect(result == expected)
    }

    // MARK: Self: ExpressibleByStringLiteral
    struct ConformsToExpressibleByStringLiteral {
        @Test("Creates key from string ID", arguments: [
            ("falcon", Mock("falcon"))
        ])
        func initializer(stringLiteral value: String, expected: Mock) {
            let result = Mock(stringLiteral: value)
            #expect(result == expected)
        }
    }

    struct ConformsToIdentifiable {
        @Test("Returns information about the key", arguments: [
            (Mock("sportila"), "sportila")
        ])
        func id(_ sut: Mock, expected: String) {
            let result = sut.id
            #expect(result == expected)
        }
    }
}
