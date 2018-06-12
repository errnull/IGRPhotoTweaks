//
//  PhotoCropEditorViewController.swift
//  PhotoCroper
//
//  Created by Loong on 2018/6/9.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class PhotoCropEditorViewController: UIViewController {

    @IBOutlet weak var cropPreview: PhotoCroperView!
    @IBOutlet weak var rotationAngleSlider: UISlider!
    
    open var image: UIImage? {
        didSet {
//            photoCropView.image = #imageLiteral(resourceName: "girl")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "girl"))
        
        cropPreview.setCropAspectRect(aspect: "1:1")
        cropPreview.imageView = imageView
        cropPreview.clipsToBounds = true
    }
    
    
    @IBAction func resetButtonDidClick(_ sender: Any?) {
        
        rotationAngleSlider.value = Float(0)
        cropPreview.resetView()
    }
    @IBAction func rotationSliderValueDidChange(_ sender: UISlider) {
        
        let angle = CGFloat(sender.value) / 180.0 * CGFloat.pi
        cropPreview.changedAngle(value: angle)
    }
    
    @IBAction func nineToSixteenButtonDidClick(_ sender: UIButton) {
        resetButtonDidClick(nil)
        cropPreview.setCropAspectRect(aspect: "9:16")
    }
    
    @IBAction func threeToFourButtonDidClick(_ sender: UIButton) {
        resetButtonDidClick(nil)
        cropPreview.setCropAspectRect(aspect: "3:4")
    }
    
    @IBAction func oneToOneButtonDidClick(_ sender: UIButton) {
        resetButtonDidClick(nil)
        cropPreview.setCropAspectRect(aspect: "1:1")
    }

    func setupTheme() {
        PhotoCroperView.appearance().backgroundColor = UIColor.photoCroperCanvasBackground()
        PhotoCroperContentView.appearance().backgroundColor = UIColor.clear
        PhotoCropView.appearance().backgroundColor = UIColor.clear
        PhotoCropGridLine.appearance().backgroundColor = UIColor.gridLine()
        PhotoCropLine.appearance().backgroundColor = UIColor.cropLine()
        PhotoCropCornerView.appearance().backgroundColor = UIColor.clear
        PhotoCropCornerLine.appearance().backgroundColor = UIColor.cropLine()
        PhotoCropMaskView.appearance().backgroundColor = UIColor.mask()
    }
}
