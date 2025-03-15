//
//  UKLPostfixPercentage.swift
//
//
//  Created by Yevhen Biiak on 09.10.2023.
//

import Foundation

public struct UKLPostfixPercentage {
    let value: Double
    init(value: Double) {
        self.value = value
    }
}

postfix operator %
public postfix func % (v: Double) -> UKLPostfixPercentage {
    UKLPostfixPercentage(value: v / 100)
}

public postfix func % (v: CGFloat) -> UKLPostfixPercentage {
    Double(v)%
}

public postfix func % (v: Int) -> UKLPostfixPercentage {
    Double(v)%
}
