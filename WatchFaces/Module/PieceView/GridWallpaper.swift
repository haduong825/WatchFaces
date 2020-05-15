//
//  GridWallpaper.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/14/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class GridWallpaper: UIView {
    
    @IBOutlet weak var wallpaperCollectionView: UICollectionView!
    
    private let kWallpaperCell = "WallpaperCell"
    
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
    
    
}


extension GridWallpaper: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWallpaperCell, for: indexPath) as! WallpaperCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 45) / 2
        let height = width * 201 / 163
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
}
