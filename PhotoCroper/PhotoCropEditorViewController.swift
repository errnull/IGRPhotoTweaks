//
//  PhotoCropEditorViewController.swift
//  PhotoCroper
//
//  Created by Loong on 2018/6/9.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class PhotoCropEditorViewController: UIViewController, PhotoCroperViewCustomizationDelegate {

    open var image: UIImage? {
        didSet {
//            photoCropView.image = #imageLiteral(resourceName: "girl")
        }
    }
    
    var photoCropView: PhotoCroperView!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let baseRect = CGRect(x: 0, y: 0, width: 375, height: 500)
        
        photoCropView = PhotoCroperView(frame: baseRect,
                                        image: #imageLiteral(resourceName: "girl"),
                                        customizationDelegate: self)
        view.addSubview(photoCropView)
    }
    
    @IBAction func rotationSliderValueDidChange(_ sender: UISlider) {
        
        let angle = CGFloat(sender.value) / 180.0 * CGFloat.pi
        self.photoCropView.changedAngle(value: angle)
    }
    
    // MARK: PhotoCroperViewCustomizationDelegate
    
    func borderColor() -> UIColor {
        return UIColor.cropLine()
    }
    
    func borderWidth() -> CGFloat {
        return 1.0
    }
    
    func cornerBorderWidth() -> CGFloat {
        return kCropViewCornerWidth
    }
    
    func cornerBorderLength() -> CGFloat {
        return kCropViewCornerLength
    }
    
    func isHighlightMask() -> Bool {
        return true
    }
    
    func highlightMaskAlphaValue() -> CGFloat {
        return 0.3
    }
    
    func canvasHeaderHeigth() -> CGFloat {
        return kCanvasHeaderHeigth
    }
}
