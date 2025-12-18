//
//  HeterogeneousDictionary+Tests.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 18/12/2025.
//

@testable import Heterogeneous
import Testing

struct HeterogeneousDictionaryTests {
    @Test("Declares ways the type can access values")
    func syntaxEvaluate() {
        var hDict = HeterogeneousDictionary<String>([:])
        let testTicket: HeterogeneousKey<String, Int> = "goals"
        let dynamicAccess: Int? = hDict.goals
        let fetchAccess = try? hDict.fetch(testTicket)
    }
}
