//
//  UIScrollView + helpers.swift
//
//  Created by Yevhen Biiak on 27.08.2023.
//

import UIKit

extension UIScrollView {
    
    public var isScrolledToTop: Bool {
        contentOffset.y <= -contentInset.top
    }
    public var isScrolledToBottom: Bool {
        contentOffset.y >= contentSize.height - bounds.height + contentInset.bottom
    }
    public var isScrolledToLeft: Bool {
        contentOffset.x <= -contentInset.left
    }
    public var isScrolledToRight: Bool {
        contentOffset.x >= contentSize.width - bounds.width + contentInset.right
    }
    
    public func scrollToTop(animated: Bool) {
        var offset = contentOffset
        offset.y = -contentInset.top
        setContentOffset(offset, animated: animated)
    }
    public func scrollToLeft(animated: Bool) {
        var offset = contentOffset
        offset.x = -contentInset.left
        setContentOffset(offset, animated: animated)
    }
    public func scrollToRight(animated: Bool) {
        var offset = contentOffset
        offset.x = contentSize.width - bounds.width + contentInset.right
        setContentOffset(offset, animated: animated)
    }
    public func scrollToBottom(animated: Bool) {
        var offset = contentOffset
        offset.y = contentSize.height - bounds.height + contentInset.bottom
        setContentOffset(offset, animated: animated)
    }
}
