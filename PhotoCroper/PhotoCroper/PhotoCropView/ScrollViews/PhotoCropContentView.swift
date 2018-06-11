//
//  IGRPhotoContentView.swift
//  PhotoCroper
//
//  Created by Vitalii Parovishnyk on 2/6/17.
//  Copyright © 2017 IGR Software. All rights reserved.
//

import UIKit

extension PhotoCroperView {
    
    
    public func replaceImageViewWithView(view: UIView) {
        view.frame = photoContentView.imageView.frame
        photoContentView.imageView.removeFromSuperview()
        photoContentView.addSubview(view)
        photoContentView.imageView = view
    }
    
}

public class PhotoCroperContentView: UIView {
    
    lazy fileprivate var imageView: UIView! = {
        let imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
    }()
    
    public var image: UIImage! {
        didSet {
            self.imageView.frame = self.bounds
            self.imageView.isUserInteractionEnabled = true
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.bounds
    }
}
