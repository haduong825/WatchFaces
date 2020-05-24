//
//  SuccessView.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/24/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import UIKit

public class SuccessView{
    
    var successView = UIView()
    
    class var shared: SuccessView {
        struct Static {
            static let instance: SuccessView = SuccessView()
        }
        return Static.instance
    }
    
    public func showView(vc: UIViewController) {
        successView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        successView.center = vc.view.center
        
        
    }
    
    
}
