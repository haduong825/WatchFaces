//
//  CategoryCollectionViewCell.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/18/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var name: String!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                containerView.backgroundColor = UIColor.white
                nameLabel.textColor = UIColor.black
            } else {
                nameLabel.textColor = UIColor.white
                containerView.backgroundColor = UIColor.clear
            }
        }
    }
    
    func setupData(){
        nameLabel.text = name
    }
}
