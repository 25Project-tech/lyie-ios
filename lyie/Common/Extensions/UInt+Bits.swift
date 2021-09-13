//
//  UInt+Bits.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

extension UInt {
    static let base: UInt = 0
    
    /// Sets specified bits to specified range. If there are more bits provided they will be clamped to specified range. IMPORTANT!!! There are no range checking with UInt size at the moment. Application will crash if UInt will be overflowed by range.
    ///
    /// - Parameters:
    ///   - bits: Bits to set
    ///   - range: Range where to set bits
    /// - Returns: Result with raplaced bits in specified range
    nonmutating func apply(bits: UInt, to range: CountableClosedRange<Int>) -> UInt {
        let cleanedSelf = self & (~(mask(range)))
        let clampedValue = bits & (mask(0...range.count))
        return cleanedSelf | (clampedValue << range.lowerBound)
    }
    
    nonmutating func bits(_ range: CountableClosedRange<Int>) -> UInt {
        return (self >> range.lowerBound) & mask(0...range.count - 1)
    }
    
    private nonmutating func mask(_ range: CountableClosedRange<Int>) -> UInt {
        return (((1 << range.count) - 1)) << range.lowerBound
    }
}
