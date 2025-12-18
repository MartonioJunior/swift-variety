//
//  HeterogeneousKeyError.swift
//  SwiftVariety
//
//  Created by Martônio Júnior on 18/12/2025.
//

public enum HeterogeneousKeyError {
    case invalidKey
    case typeMismatch
}

// MARK: Self: Error
extension HeterogeneousKeyError: Error {}
