//
//  PhotoCropEditorViewController.swift
//  PhotoCroper
//
//  Created by Loong on 2018/6/9.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class PhotoCropEditorViewController: PhotoCroperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func rotationSliderValueDidChange(_ sender: UISlider) {
        
        let angle = CGFloat(sender.value) / 180.0 * CGFloat.pi
        self.changedAngle(value: angle)
        
    }
}
