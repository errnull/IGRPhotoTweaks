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
    
    open var image: UIImage? {
        didSet {
//            photoCropView.image = #imageLiteral(resourceName: "girl")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cropPreview.clipsToBounds = true
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "girl"))
        cropPreview.imageView = imageView
    }
    
    @IBAction func rotationSliderValueDidChange(_ sender: UISlider) {
        
        let angle = CGFloat(sender.value) / 180.0 * CGFloat.pi
        cropPreview.changedAngle(value: angle)
    }
}
