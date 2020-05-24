//
//  StickerCollectionViewCell.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/23/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stickerImageView: UIImageView!
    
    var stickerImage: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(){
        stickerImageView.image = stickerImage
    }

}
