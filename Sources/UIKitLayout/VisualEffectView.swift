//
//  VisualEffectView.swift
//
//  Created by Yevhen Biiak on 22.09.2023.
//

import UIKit
import Combine

public final class UKLVisualEffectView: UIVisualEffectView {
    
    private var cancellables: Set<AnyCancellable> = []
    
    public init(radius: CGFloat) {
        super.init(effect: UIBlurEffect(style: .systemThickMaterial))
        
        publisher(for: \.layer.sublayers).sink { [weak self] sublayers in
            var filters: [Any] = []
            
            (sublayers ?? []).forEach { layer in
                self?.removeNonGaissianFilters(from: layer)
                filters += layer.filters ?? []
            }
            
            for filter in filters {
                (filter as? NSObject)?.setValue(radius, forKey: "inputRadius")
            }
        }
        .store(in: &cancellables)
    }
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func removeNonGaissianFilters(from layer: CALayer) {
        layer.filters?.removeAll { filter in
            String(describing: filter) != "gaussianBlur"
        }
    }
}
