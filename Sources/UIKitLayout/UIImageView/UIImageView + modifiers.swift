//
//  UIImageView + modifiers.swift
//  Playground
//
//  Created by Yevhen Biiak on 21.08.2023.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    public func setImage(_ image: UIImage?) -> Self {
        DispatchQueue.global().async {
            let preparedImage = image?.preparingForDisplay()
            DispatchQueue.main.async {
                self.image = preparedImage ?? image
            }
        }
        return self
    }
    
    @discardableResult
    public func setImage(data: Data?) -> Self {
        DispatchQueue.global().async {
            if let data, let image = UIImage(data: data) {
                self.setImage(image)
            }
        }
        return self
    }
    
    @discardableResult
    public func setImageTask(placeholder: UIImage? = nil, task: (_ completeWithData: @escaping (Data?) -> Void) -> Void) -> Self {
        if let placeholder {
            image = placeholder
        }
        let taskID = Date.now.timeIntervalSince1970
        imageTaskID = taskID
        
        task { data in
            if self.imageTaskID == taskID {
                self.setImage(data: data)
            }
        }
        return self
    }
    
    @discardableResult
    public func setImageTask(placeholder: UIImage? = nil, task: (_ completeWithImage: @escaping (UIImage?) -> Void) -> Void) -> Self {
        if let placeholder {
            image = placeholder
        }
        let taskID = Date.now.timeIntervalSince1970
        imageTaskID = taskID
        
        task { image in
            if self.imageTaskID == taskID {
                self.setImage(image)
            }
        }
        return self
    }
}
