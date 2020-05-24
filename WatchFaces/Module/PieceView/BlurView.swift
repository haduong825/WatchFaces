//
//  BlurView.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/23/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

protocol BlurViewDelegate {
    func closeAction()
    func doneAction()
    func blurChange(value: Float)
}

class BlurView: UIView {
    
    var delegate: BlurViewDelegate?
    @IBOutlet weak var blurSlider: UISlider!
    
    open class func createView() -> BlurView{
        let views = Bundle.main.loadNibNamed("BlurView", owner: self, options: nil)
        let view = views?.first as! BlurView
        return view
    }
    
    @IBAction func closeAction(_ sender: Any) {
        delegate?.closeAction()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        delegate?.doneAction()
    }
    
    @IBAction func blurChanged(_ sender: Any) {
        delegate?.blurChange(value: blurSlider.value)
    }
}
