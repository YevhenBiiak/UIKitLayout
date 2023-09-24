//
//  ImageView.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

extension UIImageView {
    
    private static var imageTaskIDKey = "imageTaskID"
    
    internal var imageTaskID: TimeInterval? {
        get { getAssociatedObject(key: &Self.imageTaskIDKey) }
        set { setAssociatedObject(key: &Self.imageTaskIDKey, value: newValue) }
    }
    
    public convenience init(named: String) {
        self.init(frame: .zero)
        self.image = UIImage(named: named)
    }
    
    public convenience init(system: String) {
        self.init(frame: .zero)
        self.image = UIImage(systemName: system)
    }
}
