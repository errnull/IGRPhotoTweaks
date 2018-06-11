//
//  PhotoCroperView+Touch.swift
//  Pods
//
//  Created by Vitalii Parovishnyk on 4/26/17.
//
//

import UIKit

extension PhotoCroperView {
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if frame.contains(point) {
            if self.cropView.frame.insetBy(dx: -kCropViewHotArea,
                                           dy: -kCropViewHotArea).contains(point) &&
                !self.cropView.frame.insetBy(dx: kCropViewHotArea,
                                             dy: kCropViewHotArea).contains(point) {
                return self.cropView
            }
            return self.scrollView
            
        } else {
            return super.hitTest(point, with: event)
        }
    }
}
