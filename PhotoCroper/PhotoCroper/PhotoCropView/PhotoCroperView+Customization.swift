//
//  PhotoCroperView+Customization.swift
//  Pods
//
//  Created by Vitalii Parovishnyk on 4/25/17.
//
//

import UIKit

public protocol PhotoCroperViewCustomizationDelegate : class {
    /*
     Lines between mask and crop area
     */
    func borderColor() -> UIColor
    
    func borderWidth() -> CGFloat
    
    /*
     Corner of 2 border lines
     */
    func cornerBorderWidth() -> CGFloat
    
    func cornerBorderLength() -> CGFloat
    
    /*
     Mask customization
     */
    func isHighlightMask() -> Bool
    
    func highlightMaskAlphaValue() -> CGFloat
    
    /*
     Top offset for crop view
     */
    func canvasHeaderHeigth() -> CGFloat
}

extension PhotoCroperView {
    
    func borderColor() -> UIColor {
        return self.customizationDelegate?.borderColor() ?? UIColor.cropLine()
    }
    
    func borderWidth() -> CGFloat {
        return self.customizationDelegate?.borderWidth() ?? 1.0
    }
    
    func cornerBorderWidth() -> CGFloat {
        return self.customizationDelegate?.cornerBorderWidth() ?? kCropViewCornerWidth
    }
    
    func cornerBorderLength() -> CGFloat {
        return self.customizationDelegate?.cornerBorderLength() ?? kCropViewCornerLength
    }
    
    func isHighlightMask() -> Bool {
        return self.customizationDelegate?.isHighlightMask() ?? true
    }
    
    func highlightMaskAlphaValue() -> CGFloat {
        return self.customizationDelegate?.highlightMaskAlphaValue() ?? 0.3
    }
    
    func canvasHeaderHeigth() -> CGFloat {
        return self.customizationDelegate?.canvasHeaderHeigth() ?? kCanvasHeaderHeigth
    }
}
