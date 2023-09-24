//
//  CGSize + aspectRatio.swift
//
//  Created by Yevhen Biiak on 22.09.2023.
//

import Foundation

extension CGSize {
    public init(width: CGFloat, aspectRatio: CGFloat) {
        self.init(width: width, height: width / aspectRatio)
    }
    public init(height: CGFloat, aspectRatio: CGFloat) {
        self.init(width: height * aspectRatio, height: height)
    }
}
