//
//  WatchCell.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import SDWebImage
import RealmSwift

protocol WatchCellProtocol{
    func updateData()
}

class WatchCell: FSPagerViewCell {
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageContraint: NSLayoutConstraint!
    @IBOutlet weak var topImageContraint: NSLayoutConstraint!
    @IBOutlet weak var watchImage: UIImageView!
    @IBOutlet weak var wallpaperImage: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var freeView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    
    var positionText = 0
    var totalText = 0
    var face: Face!
    let realm = try! Realm()
    var delegate: WatchCellProtocol?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeAction(_ sender: Any) {
        try! realm.write{
            face.isLiked = !face.isLiked
            if !face.isLiked {
                likeButton.setImage(#imageLiteral(resourceName: "line-heart"), for: .normal)
                let predicate = NSPredicate(format: "id = %@", face.id)
                let f = realm.objects(Face.self).filter(predicate)
                if f.count > 0 {
                    realm.delete(f)
                }
            } else {
                likeButton.setImage(#imageLiteral(resourceName: "red-heart"), for: .normal)
                realm.add(face, update: .all)
            }
        }
        
        delegate?.updateData()
        
    }
    
    func setupUI(){
        let width = UIScreen.main.bounds.width - 150
        let height = width * 108/67
        
        self.leftImageContraint.constant = (20 / 268) * width
        self.rightImageContraint.constant = -(32 / 268) * width
        self.topImageContraint.constant = (80 / 432) * height
        self.bottomImageContraint.constant = -(100 / 432) * height
        
        if totalText == 0{
            self.positionLabel.text = ""
            self.wallpaperImage.image = #imageLiteral(resourceName: "favorite_empty")
            self.wallpaperImage.contentMode = .scaleAspectFit
            self.freeView.isHidden = true
            self.likeButton.isHidden = true
        } else {
            self.positionLabel.text = "\(positionText+1) / \(totalText)"
            self.wallpaperImage.contentMode = .scaleAspectFill
            let imageUrl = Constants.baseUrl + EndPoint.watch + face.url
            self.wallpaperImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            self.wallpaperImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
            if face.paid {
                freeView.isHidden = true
            } else {
                freeView.isHidden = false
            }
            self.freeView.isHidden = false
            self.likeButton.isHidden = false
            if face.isLiked{
                likeButton.setImage(#imageLiteral(resourceName: "red-heart"), for: .normal)
            } else {
                likeButton.setImage(#imageLiteral(resourceName: "line-heart"), for: .normal)
            }
        }
        layoutIfNeeded()
    }
    
}
