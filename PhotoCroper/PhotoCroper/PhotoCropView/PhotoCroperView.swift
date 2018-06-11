//
//  PhotoCroperView.swift
//  PhotoCroper
//
//  Created by Vitalii Parovishnyk on 2/6/17.
//  Copyright © 2017 IGR Software. All rights reserved.
//

import UIKit

public class PhotoCroperView: UIView {
    
    //MARK: - Public VARs
    
    public weak var customizationDelegate: PhotoCroperViewCustomizationDelegate?
    
    open var imageView: UIView? {
        didSet {
            if let view = imageView as? UIImageView {
                
                imageSize = view.frame.size
                replaceImageViewWithView(view: view)
            }
        }
    }
    
    private(set) lazy var cropView: PhotoCropView! = { [unowned self] by in
        
        let cropView = PhotoCropView(frame: self.scrollView.frame,
                                    cornerBorderWidth:self.cornerBorderWidth(),
                                    cornerBorderLength:self.cornerBorderLength())
        cropView.center = self.scrollView.center
        
        cropView.layer.borderColor = self.borderColor().cgColor
        cropView.layer.borderWidth = self.borderWidth()
        self.addSubview(cropView)
        
        return cropView
    }(())
    
    private(set) lazy var photoContentView: PhotoCroperContentView! = { [unowned self] by in
        
        let photoContentView = PhotoCroperContentView(frame: self.scrollView.bounds)
        photoContentView.isUserInteractionEnabled = true
        self.scrollView.addSubview(photoContentView)
        
        return photoContentView
    }(())
    
    public var photoTranslation: CGPoint {
        get {
            let rect: CGRect = self.photoContentView.convert(self.photoContentView.bounds,
                                                             to: self)
            let point = CGPoint(x: (rect.origin.x + rect.size.width.half),
                                y: (rect.origin.y + rect.size.height.half))
            let zeroPoint = CGPoint(x: self.frame.width.half, y: self.centerY)
            
            return CGPoint(x: (point.x - zeroPoint.x), y: (point.y - zeroPoint.y))
        }
    }
    
    //MARK: - Private VARs
    
    internal var angle: CGFloat         = CGFloat.zero
    fileprivate var photoContentOffset  = CGPoint.zero
    
    internal lazy var scrollView: PhotoCroperScrollView! = { [unowned self] by in
        
        let maxBounds = self.maxBounds()
        self.originalSize = maxBounds.size
        
        let scrollView = PhotoCroperScrollView(frame: maxBounds)
        scrollView.center = CGPoint(x: self.frame.width.half, y: self.centerY)
        scrollView.delegate = self
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(scrollView)
        
        return scrollView
    }(())
    
    internal var imageSize: CGSize = CGSize.zero
    
    internal var originalSize = CGSize.zero
    
    internal var manualZoomed = false
    internal var manualMove   = false
    
    // masks
    internal var topMask:    IGRCropMaskView!
    internal var leftMask:   IGRCropMaskView!
    internal var bottomMask: IGRCropMaskView!
    internal var rightMask:  IGRCropMaskView!
    
    // constants
    fileprivate var maximumCanvasSize: CGSize!
    fileprivate var originalPoint: CGPoint!
    internal var centerY: CGFloat!
    
    // MARK: - Life Cicle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    init(frame: CGRect, image: UIImage, customizationDelegate: PhotoCroperViewCustomizationDelegate!) {
        super.init(frame: frame)
        
        self.customizationDelegate = customizationDelegate
        
        setupScrollView()
        setupCropView()
        setupMasks()
        
        self.originalPoint = self.convert(self.scrollView.center, to: self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.originalSize = self.maxBounds().size
    }
    
    //MARK: - Public FUNCs

    public func resetView() {
        UIView.animate(withDuration: kAnimationDuration, animations: {() -> Void in
            self.angle = 0
            self.scrollView.transform = CGAffineTransform.identity
            self.scrollView.center = CGPoint(x: self.frame.width.half, y: self.centerY)
            self.scrollView.bounds = CGRect(x: CGFloat.zero,
                                            y: CGFloat.zero,
                                            width: self.originalSize.width,
                                            height: self.originalSize.height)
            self.scrollView.minimumZoomScale = 1
            self.scrollView.setZoomScale(1, animated: false)
            
            self.cropView.frame = self.scrollView.frame
            self.cropView.center = self.scrollView.center
        })
    }
    
    public func applyDeviceRotation() {
        self.scrollView.center = CGPoint(x: self.frame.width.half, y: self.centerY)
        self.scrollView.bounds = CGRect(x: CGFloat.zero,
                                        y: CGFloat.zero,
                                        width: self.originalSize.width,
                                        height: self.originalSize.height)
        
        self.cropView.frame = self.scrollView.frame
        self.cropView.center = self.scrollView.center
        
        updatePosition()
    }
    
    //MARK: - Private FUNCs
    
    fileprivate func initialize() {
        
        imageSize = CGSize(width: 300, height: 400)
        
        setupScrollView()
        setupCropView()
        setupMasks()
        
        self.originalPoint = self.convert(self.scrollView.center, to: self)
    }
    
    fileprivate func maxBounds() -> CGRect {
        // scale the image
        self.maximumCanvasSize = CGSize(width: (kMaximumCanvasWidthRatio * self.frame.size.width),
                                        height: (kMaximumCanvasHeightRatio * self.frame.size.height - self.canvasHeaderHeigth()))
        
        self.centerY = self.maximumCanvasSize.height.half + self.canvasHeaderHeigth()
        
        let scaleX: CGFloat = self.imageSize.width / self.maximumCanvasSize.width
        let scaleY: CGFloat = self.imageSize.height / self.maximumCanvasSize.height
        let scale: CGFloat = max(scaleX, scaleY)
        
        let bounds = CGRect(x: CGFloat.zero,
                            y: CGFloat.zero,
                            width: (self.imageSize.width / scale),
                            height: (self.imageSize.height / scale))
        
        return bounds
    }
    
    internal func updatePosition() {
        // position scroll view
        let width: CGFloat = fabs(cos(self.angle)) * self.cropView.frame.size.width + fabs(sin(self.angle)) * self.cropView.frame.size.height
        let height: CGFloat = fabs(sin(self.angle)) * self.cropView.frame.size.width + fabs(cos(self.angle)) * self.cropView.frame.size.height
        let center: CGPoint = self.scrollView.center
        let contentOffset: CGPoint = self.scrollView.contentOffset
        let contentOffsetCenter = CGPoint(x: (contentOffset.x + self.scrollView.bounds.size.width.half),
                                          y: (contentOffset.y + self.scrollView.bounds.size.height.half))
        self.scrollView.bounds = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: width, height: height)
        let newContentOffset = CGPoint(x: (contentOffsetCenter.x - self.scrollView.bounds.size.width.half),
                                       y: (contentOffsetCenter.y - self.scrollView.bounds.size.height.half))
        self.scrollView.contentOffset = newContentOffset
        self.scrollView.center = center
        
        // scale scroll view
        let shouldScale: Bool = self.scrollView.contentSize.width / self.scrollView.bounds.size.width <= 1.0 ||
            self.scrollView.contentSize.height / self.scrollView.bounds.size.height <= 1.0
        if !self.manualZoomed || shouldScale {
            let zoom = self.scrollView.zoomScaleToBound()
            self.scrollView.setZoomScale(zoom, animated: false)
            self.scrollView.minimumZoomScale = zoom
            self.manualZoomed = false
        }
        
        self.scrollView.checkContentOffset()
    }
}
