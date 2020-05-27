//
//  LoadingOverlay.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/18/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//
//  Usage:
//
//  # Show Overlay
//  LoadingOverlay.shared.showOverlay(self.navigationController?.view)
//
//  # Hide Overlay
//  LoadingOverlay.shared.hideOverlayView()
import UIKit
import Foundation


public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
