//
//  PhotoCroperConstants.swift
//  PhotoCroper
//
//  Created by Vitalii Parovishnyk on 2/6/17.
//  Copyright © 2017 IGR Software. All rights reserved.
//

import UIKit

enum CropCornerType : Int {
    case upperLeft
    case upperRight
    case lowerRight
    case lowerLeft
}

let kCropLines: Int = 2
let kGridLines: Int = 8

let kCropViewHotArea: CGFloat = 26.0

let kMaximumCanvasWidthRatio: CGFloat  = 0.8
let kMaximumCanvasHeightRatio: CGFloat = 0.8
let kCanvasHeaderHeigth: CGFloat       = 0.0

let kCropViewLineWidth: CGFloat  = 2.0

let kCropViewCornerWidth: CGFloat  = 3.0
let kCropViewCornerLength: CGFloat = 13.0

let kAnimationDuration: TimeInterval = 0.3
