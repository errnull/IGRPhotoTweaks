//
//  ViewController.swift
//  PhotoCroper
//
//  Created by Loong on 2018/6/11.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func cropButtonDidClick(_ sender: UIButton) {
        
        if let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoCropEditorViewController") as? PhotoCropEditorViewController {
            nextViewController.image = imageView.image
            present(nextViewController, animated: true) {
                print("present success")
            }
        }
    }
}

