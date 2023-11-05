//
//  Helper structs.swift
//
//  Created by Yevhen Biiak on 27.08.2023.
//

import UIKit

public struct ConstantTuple<T> {
    let anchor: T
    let constant: CGFloat
}

public struct MultiplierTuple<T> {
    let anchor: T
    let multiplier: CGFloat
}
