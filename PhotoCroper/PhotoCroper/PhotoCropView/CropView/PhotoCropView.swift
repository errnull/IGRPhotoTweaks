//
//  IGRCropView.swift
//  PhotoCroper
//
//  Created by Vitalii Parovishnyk on 2/6/17.
//  Copyright © 2017 IGR Software. All rights reserved.
//

import UIKit

public protocol PhotoCropViewDelegate : class {
    /*
     Calls ones, when user start interaction with view
     */
    func cropViewDidStartCrop(_ cropView: PhotoCropView)
    
    /*
     Calls always, when user move touch around view
     */
    func cropViewDidMove(_ cropView: PhotoCropView)
    
    /*
     Calls ones, when user stop interaction with view
     */
    func cropViewDidStopCrop(_ cropView: PhotoCropView)
    
    /*
     Calls ones, when change a Crop frame
     */
    func cropViewInsideValidFrame(for point: CGPoint, from cropView: PhotoCropView) -> Bool
}

public class PhotoCropView: UIView {
    
    //MARK: - Public VARs
    
    /*
     The optional View Delegate.
     */
    
    weak var delegate: PhotoCropViewDelegate?
    
    //MARK: - Private VARs
    
    internal lazy var horizontalCropLines: [PhotoCropLine] = { [unowned self] by in
        var lines = self.setupHorisontalLines(count: kCropLines,
                                              className: PhotoCropLine.self)
        return lines as! [PhotoCropLine]
    }(())
    
    internal lazy var verticalCropLines: [PhotoCropLine] = { [unowned self] by in
        var lines = self.setupVerticalLines(count: kCropLines,
                                            className: PhotoCropLine.self)
        return lines as! [PhotoCropLine]
    }(())
    
    internal lazy var horizontalGridLines: [PhotoCropGridLine] = { [unowned self] by in
        var lines = self.setupHorisontalLines(count: kGridLines,
                                              className: PhotoCropGridLine.self)
        return lines as! [PhotoCropGridLine]
    }(())
    internal lazy var verticalGridLines: [PhotoCropGridLine] = { [unowned self] by in
        var lines = self.setupVerticalLines(count: kGridLines,
                                            className: PhotoCropGridLine.self)
        return lines as! [PhotoCropGridLine]
    }(())
    
    internal var cornerBorderLength      = kCropViewCornerLength
    internal var cornerBorderWidth       = kCropViewCornerWidth
    
    internal var isCropLinesDismissed: Bool  = true
    internal var isGridLinesDismissed: Bool  = true
    
    internal var isAspectRatioLocked: Bool = false
    internal var aspectRatioWidth: CGFloat = 0.0
    internal var aspectRatioHeight: CGFloat = 0.0
    
    // MARK: - Life Cicle
    
    init(frame: CGRect, cornerBorderWidth: CGFloat, cornerBorderLength: CGFloat) {
        super.init(frame: frame)
        
        self.cornerBorderLength = cornerBorderLength
        self.cornerBorderWidth = cornerBorderWidth
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup() {
        
        self.setupLines()
        
        let upperLeft = PhotoCropCornerView(cornerType: .upperLeft,
                                          lineWidth: cornerBorderWidth,
                                          lineLenght: cornerBorderLength)
        upperLeft.center = CGPoint(x: cornerBorderLength.half,
                                   y: cornerBorderLength.half)
        self.addSubview(upperLeft)
        
        let upperRight = PhotoCropCornerView(cornerType: .upperRight,
                                           lineWidth: cornerBorderWidth,
                                           lineLenght:cornerBorderLength)
        upperRight.center = CGPoint(x: (self.frame.size.width - cornerBorderLength.half),
                                    y: cornerBorderLength.half)
        self.addSubview(upperRight)
        
        let lowerRight = PhotoCropCornerView(cornerType: .lowerRight,
                                           lineWidth: cornerBorderWidth,
                                           lineLenght:cornerBorderLength)
        lowerRight.center = CGPoint(x: (self.frame.size.width - cornerBorderLength.half),
                                    y: (self.frame.size.height - cornerBorderLength.half))
        self.addSubview(lowerRight)
        
        let lowerLeft = PhotoCropCornerView(cornerType: .lowerLeft,
                                          lineWidth: cornerBorderWidth,
                                          lineLenght:cornerBorderLength)
        lowerLeft.center = CGPoint(x: cornerBorderLength.half,
                                   y: (self.frame.size.height - cornerBorderLength.half))
        self.addSubview(lowerLeft)
        
        resetAspectRect()
    }
}
