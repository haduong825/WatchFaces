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
    
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var getPremiumButton: UIButton!
    
    var delegate: UnderTopViewDelegate?
    
    open class func createView() -> UnderTopView{
        let views = Bundle.main.loadNibNamed("UnderTopView", owner: self, options: nil)
        let view = views?.first as! UnderTopView
        if PremiumProduct.store.checkPurchased(){
            view.getPremiumButton.backgroundColor = UIColor.black
        } else {
            view.getPremiumButton.backgroundColor = UIColor.clear
        }
        return view
    
    }

    @IBAction func getPremiumAction(_ sender: Any) {
        if !PremiumProduct.store.checkPurchased(){
            delegate?.getPremiumAction()
        }
    }
    
    @IBAction func gridAction(_ sender: Any) {
        previewButton.setImage(#imageLiteral(resourceName: "ic_gray_pager"), for: .normal)
        gridButton.setImage(#imageLiteral(resourceName: "ic_grid_white"), for: .normal)
        delegate?.gridAction()
    }
    
    @IBAction func previewAction(_ sender: Any) {
        previewButton.setImage(#imageLiteral(resourceName: "ic_pager_white"), for: .normal)
        gridButton.setImage(#imageLiteral(resourceName: "ic_grid_gray"), for: .normal)
        delegate?.previewAction()
    }
}
