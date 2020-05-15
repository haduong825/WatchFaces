//
//  PreviewWatch.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/14/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import FSPagerView

class PreviewWatch: UIView {

    @IBOutlet weak var pagerView: FSPagerView!
    
    private let kCell = "watchCell"
    
    class func createView() -> PreviewWatch{
        let views = Bundle.main.loadNibNamed("PreviewWatch", owner: self, options: nil)
        let view = views?.first as! PreviewWatch
        view.initPagerView()
        return view
    }
    
    private func initPagerView(){
        let nib = UINib(nibName: "WatchCell", bundle: nil)
        pagerView.register(nib, forCellWithReuseIdentifier: "watchCell")
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.itemSize = CGSize(width: UIScreen.main.bounds.width - 150, height: (UIScreen.main.bounds.width - 150) * 108/67)
        pagerView.dataSource = self
        pagerView.delegate = self
    }
}


extension PreviewWatch: FSPagerViewDataSource, FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: kCell, at: index) as! WatchCell
        cell.setupUI()
        return cell
    }
    
    
    
    
}
