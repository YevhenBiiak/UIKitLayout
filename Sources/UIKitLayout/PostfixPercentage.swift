//
//  PostfixPercentage.swift
//
//
//  Created by Yevhen Biiak on 09.10.2023.
//

import Foundation

public struct PostfixPercentage {
    let value: Double
    init(value: Double) {
        if value < 0.0 {
            self.value = 0.0
        } else if value > 1.0 {
            self.value = 1.0
        } else {
            self.value = value
        }
    }
}

postfix operator %
public postfix func % (v: Double) -> PostfixPercentage {
    PostfixPercentage(value: v / 100)
}

public postfix func % (v: CGFloat) -> PostfixPercentage {
    Double(v)%
}

public postfix func % (v: Int) -> PostfixPercentage {
    Double(v)%
}
