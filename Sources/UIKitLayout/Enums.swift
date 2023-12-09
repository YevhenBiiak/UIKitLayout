//
//  Enums.swift
//
//  Created by Yevhen Biiak on 08.09.2023.
//

import UIKit

public enum UIVisibility {
    case hidden
    case visible
}

public enum UILayout {
    case horizontal(rows: Int)
    case vertical(columns: Int)
}

public enum ViewAlignment {
    case fill
    case fillTop
    case fillBottom
    case fillLeading
    case fillTrailing
    case fillHorizontaly
    case fillVerticaly
    case topLeading
    case top
    case topTrailing
    case leading
    case center
    case trailing
    case bottomLeading
    case bottom
    case bottomTrailing
    case inSafeArea
    case inSafeAreaIgnoringTop
    case inSafeAreaIgnoringBottom
    case aboveSafeArea
    case belowSafeArea
    /// Use this alignment only for the subview of UIViewController.view
    case topBar
    /// Use this alignment only for the subview of UIViewController.view
    case bottomBar
}
