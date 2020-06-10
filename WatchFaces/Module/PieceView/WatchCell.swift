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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        try! realm.write{
            face.isLiked = !face.isLiked
            likeButton.setImage(face.isLiked ? #imageLiteral(resourceName: "red-heart") : #imageLiteral(resourceName: "line-heart"), for: .normal)
            if face.isLiked{
                face.isLiked = true
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
        let width = UIScreen.main.bounds.width - 150
        let height = width * 108/67
        
        if totalText == 0{
            self.leftImageContraint.constant = (25 / 246) * width
            self.rightImageContraint.constant = -(25 / 246) * width
            self.topImageContraint.constant = (89 / 452) * height
            self.bottomImageContraint.constant = -(108 / 452) * height
            
            self.positionLabel.text = ""
            self.wallpaperImage.image = #imageLiteral(resourceName: "favorite_empty")
            self.wallpaperImage.contentMode = .scaleAspectFit
            self.freeView.isHidden = true
            self.likeButton.isHidden = true
        } else {
            self.leftImageContraint.constant = (13 / 246) * width
            self.rightImageContraint.constant = -(13 / 246) * width
            self.topImageContraint.constant = (89 / 452) * height
            self.bottomImageContraint.constant = -(108 / 452) * height
            
            self.wallpaperImage.layer.cornerRadius = 30 * UIScreen.main.bounds.width / 375
            
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
