//
//  CustomTabbar.swift
//  Ringtunes
//
//  Created by Hà Dương on 4/17/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map(UIColor.init) }
        set { layer.borderColor = newValue?.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // Proof of concept, not tested
    @IBInspectable var backgroundImage: UIImage! {
        get { return nil }  // maybe use associated objects, you can't add properties in extensions
        set {
            let imageView = UIImageView(image: newValue)
            imageView.frame = bounds
            addSubview(imageView)
        }
    }
    
    @IBInspectable var isCircle: Bool{
        get {return false}
        set {
            if newValue {
                layer.cornerRadius = frame.width / 2
            }
        }
    }
    
    // Shadow color
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    // Shadow offsets
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    // Shadow opacity
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    // Shadow radius
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    // Create bezier path of shadow for rasterize
    @IBInspectable var enableBezierPath: Bool {
        get {
            return self.layer.shadowPath != nil
        }
        set {
            if newValue {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            } else {
                self.layer.shadowPath = nil
            }
        }
    }
    
    // Rasterize option
    @IBInspectable var rasterize: Bool {
        get {
            return self.layer.shouldRasterize
        }
        set {
            self.layer.shouldRasterize = newValue
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
}


extension UIApplication {
var statusBarUIView: UIView? {

    if #available(iOS 13.0, *) {
        let tag = 3848245

        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first

        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }

    } else {

        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}
