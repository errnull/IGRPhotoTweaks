//
//  PhotoCroperView+UIScrollView.swift
//  Pods
//
//  Created by Vitalii Parovishnyk on 4/26/17.
//
//

import UIKit

extension PhotoCroperView {
    
    internal func setupScrollView() {
        self.scrollView.updateDelegate = self
        self.scrollView.photoContentView = self.photoContentView
    }
}

extension PhotoCroperView : UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoContentView
    }
    
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.cropView.updateCropLines(animate: true)
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.manualZoomed = true
        self.cropView.dismissCropLines()
    }
}

extension PhotoCroperView : PhotoCroperScrollViewDelegate {
    public func scrollViewDidStartUpdateScrollContentOffset(_ scrollView: PhotoCroperScrollView) {
        self.highlightMask(true, animate: true)
    }
    
    public func scrollViewDidStopScrollUpdateContentOffset(_ scrollView: PhotoCroperScrollView) {
        self.updateMasks()
        self.highlightMask(false, animate: true)
    }
}
