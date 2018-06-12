//
//  PhotoCroperView+Mask.swift
//  Pods
//
//  Created by Vitalii Parovishnyk on 4/26/17.
//
//

import UIKit

extension PhotoCroperView {

    internal func setupMasks()
    {
        self.topMask = PhotoCropMaskView()
        self.addSubview(self.topMask)
        
        self.leftMask = PhotoCropMaskView()
        self.addSubview(self.leftMask)
        
        self.rightMask = PhotoCropMaskView()
        self.addSubview(self.rightMask)
        
        self.bottomMask = PhotoCropMaskView()
        self.addSubview(self.bottomMask)
        
        self.setupMaskLayoutConstraints()
    }
    
    internal func updateMasks() {
        self.layoutIfNeeded()
    }
    
    internal func highlightMask(_ highlight:Bool, animate: Bool) {
        if (self.isHighlightMask()) {
            let newAlphaValue: CGFloat = highlight ? self.highlightMaskAlphaValue() : 1.0
            
            let animationBlock: (() -> Void)? = {
                self.topMask.alpha = newAlphaValue
                self.leftMask.alpha = newAlphaValue
                self.bottomMask.alpha = newAlphaValue
                self.rightMask.alpha = newAlphaValue
            }
            
            if animate {
                UIView.animate(withDuration: kAnimationDuration, animations: animationBlock!)
            }
            else {
                animationBlock!()
            }
        }
    }
}
