//
//  PhotoCroperViewController+Angle.swift
//  Pods
//
//  Created by Vitalii Parovishnyk on 4/26/17.
//
//

import UIKit

extension PhotoCroperViewController {
    public func changedAngle(value: CGFloat) {
        self.photoView.changedAngle(value: value)
    }
    
    public func stopChangeAngle() {
        self.photoView.stopChangeAngle()
    }
}
