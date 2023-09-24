//
//  VisualEffectView.swift
//
//  Created by Yevhen Biiak on 22.09.2023.
//

import UIKit

final class VisualEffectView: UIVisualEffectView {
    
    private let theEffect: UIVisualEffect
    private let customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
    
    /// Create visual effect view with given effect and its intensity
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    init(style: UIBlurEffect.Style, intensity: CGFloat) {
        theEffect = UIBlurEffect(style: style)
        customIntensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    deinit {
        animator?.stopAnimation(true)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
            self?.effect = self?.theEffect
        }
        animator?.fractionComplete = customIntensity
    }
}
