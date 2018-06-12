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
    
        let imageView = UIImageView(image: #imageLiteral(resourceName: "girl"))
        
        cropPreview.imageView = imageView
        cropPreview.clipsToBounds = true
    }
    
    
    @IBAction func resetButtonDidClick(_ sender: Any) {
        
        rotationAngleSlider.value = Float(0)
        cropPreview.resetView()
    }
    @IBAction func rotationSliderValueDidChange(_ sender: UISlider) {
        
        let angle = CGFloat(sender.value) / 180.0 * CGFloat.pi
        cropPreview.changedAngle(value: angle)
    }
}
