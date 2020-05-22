//
//  GridWallpaper.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/14/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import SDWebImage

class GridWallpaper: UIView {
    
    @IBOutlet weak var wallpaperCollectionView: UICollectionView!
    
    private let kWallpaperCell = "WallpaperCell"
    var arrWatch = [Face]()
    
    class func createView() -> GridWallpaper{
        let views = Bundle.main.loadNibNamed("GridWallpaper", owner: self, options: nil)
        let view = views?.first as! GridWallpaper
        view.initCollectionView()
        return view
    }
    
    private func initCollectionView(){
        let nib = UINib(nibName: "WallpaperCollectionViewCell", bundle: nil)
        wallpaperCollectionView.register(nib, forCellWithReuseIdentifier: kWallpaperCell)
        wallpaperCollectionView.dataSource = self
        wallpaperCollectionView.delegate = self
    }
    
    func setupDataSource(faces: [Face]){
        arrWatch = faces
        wallpaperCollectionView.reloadData()
    }
}


extension GridWallpaper: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWatch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWallpaperCell, for: indexPath) as! WallpaperCollectionViewCell
        let imageUrl = Constants.baseUrl + EndPoint.watch + arrWatch[indexPath.row].url
        cell.wallpaperImageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        cell.wallpaperImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 45) / 2
        let height = width * 201 / 163
        return CGSize(width: width, height: height)
    }
    
}
