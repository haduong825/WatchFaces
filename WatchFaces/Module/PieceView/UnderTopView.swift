//
//  UnderTopView.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/15/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

protocol UnderTopViewDelegate{
    func getPremiumAction()
    func gridAction()
    func previewAction()
}

class UnderTopView: UIView {
    
    var delegate: UnderTopViewDelegate?

    @IBAction func getPremiumAction(_ sender: Any) {
        delegate?.getPremiumAction()
    }
    
    @IBAction func gridAction(_ sender: Any) {
        delegate?.gridAction()
    }
    
    @IBAction func previewAction(_ sender: Any) {
        delegate?.previewAction()
    }
}
