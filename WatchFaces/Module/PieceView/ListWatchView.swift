//
//  ListWatchView.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/17/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import UIKit

enum ViewType{
    case Grid
    case Preview
}

class ListWatchView: UIView{
    var previewWatch : PreviewWatch!
    var underTopView : UnderTopView!
    var gridWallpaper: GridWallpaper!
    
    var viewType: ViewType = .Grid {
        didSet{
            if self.viewType == .Grid{
                gridWallpaper.isHidden = false
                previewWatch.isHidden = true
            } else {
                gridWallpaper.isHidden = true
                previewWatch.isHidden = false
            }
        }
    }
    
    open class func createView(at parentView: UIView) -> ListWatchView{
        let view = ListWatchView()
        view.frame = parentView.frame
        view.createGetPremiumView()
        
        view.createPreviewWatch()
        view.createGridWallpaper()
        
        view.viewType = .Preview
        parentView.addSubview(view)
        return view
    }
    
    private func createGetPremiumView(){
        underTopView = UnderTopView.createView()
        underTopView.delegate = self
        underTopView.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: UIScreen.main.bounds.width, height: 50)
        self.addSubview(underTopView)
    }
    
    private func createPreviewWatch(){
        previewWatch = PreviewWatch.createView()
        previewWatch.frame = CGRect(x: CGFloat.zero, y: self.underTopView.frame.height, width: UIScreen.main.bounds.width, height: self.frame.height - underTopView.frame.height)
        self.addSubview(previewWatch)
    }
    
    private func createGridWallpaper(){
        gridWallpaper = GridWallpaper.createView()
        gridWallpaper.frame = CGRect(x: CGFloat.zero, y: self.underTopView.frame.height, width: UIScreen.main.bounds.width, height: self.frame.height - underTopView.frame.height)
        self.addSubview(gridWallpaper)
    }
}

extension ListWatchView: UnderTopViewDelegate{
    func getPremiumAction() {
        
    }
    
    func gridAction() {
        self.viewType = .Grid
    }
    
    func previewAction() {
        self.viewType = .Preview
    }
    
    
}
