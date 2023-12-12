//
//  UIImageView + helpers.swift
//
//  Created by Yevhen Biiak on 03.09.2023.
//

import UIKit

extension UIImageView {
    
    public func setImage(_ image: UIImage?) {
        DispatchQueue.global().async {
            let preparedImage = image?.preparingForDisplay()
            DispatchQueue.main.async {
                self.image = preparedImage ?? image
            }
        }
    }
    
    public func setImage(data: Data?) {
        DispatchQueue.global().async {
            if let data, let image = UIImage(data: data) {
                self.setImage(image)
            }
        }
    }
    
    public func setImageTask(placeholder: UIImage? = nil, task: (_ completeWithData: @escaping (Data?) -> Void) -> Void) {
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
    }
    
    public func setImageTask(placeholder: UIImage? = nil, task: (_ completeWithImage: @escaping (UIImage?) -> Void) -> Void) {
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
    }
}
