//
//  WallpaperCollectionViewCell.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/14/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class WallpaperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var freeView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    
    var face: Face!
    let realm = try! Realm()
    
    @IBAction func likeAction(_ sender: Any) {
        try! realm.write{
            face.isLiked = !face.isLiked
            likeButton.setImage(face.isLiked ? #imageLiteral(resourceName: "red-heart") : #imageLiteral(resourceName: "line-heart"), for: .normal)
            if face.isLiked{
                realm.add(face)
            } else {
                let predicate = NSPredicate(format: "id = %@", face.id)
                let f = realm.objects(Face.self).filter(predicate)
                if f.count > 0 {
                    f[0].isLiked = false
                }
            }
        }
    }
    
    func setupUI(){
        self.contentView.isUserInteractionEnabled = false
        let imageUrl = Constants.baseUrl + EndPoint.watch + face.url
        self.wallpaperImageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        self.wallpaperImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        
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
}
