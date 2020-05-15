//
//  WatchCell.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import FSPagerView

class WatchCell: FSPagerViewCell {
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageContraint: NSLayoutConstraint!
    @IBOutlet weak var topImageContraint: NSLayoutConstraint!
    @IBOutlet weak var watchImage: UIImageView!
    @IBOutlet weak var wallpaperImage: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI(){
        let width = UIScreen.main.bounds.width - 150
        let height = width * 108/67
        
        self.leftImageContraint.constant = (20 / 268) * width
        self.rightImageContraint.constant = -(32 / 268) * width
        self.topImageContraint.constant = (80 / 432) * height
        self.bottomImageContraint.constant = -(100 / 432) * height
        layoutIfNeeded()
    }
    
}
