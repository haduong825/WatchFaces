//
//  PreviewWatch.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/14/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

protocol PreviewWatchDelegate {
    func chooseFace(face: Face)
}

class PreviewWatch: UIView {

    @IBOutlet weak var pagerView: FSPagerView!
    
    private let kCell = "watchCell"
    
    var arrWatch = [Face]()
    var delegate: PreviewWatchDelegate?
    
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
    
    func setupDataSource(faces: [Face]){
        arrWatch = faces
        pagerView.reloadData()
    }
    
    
    @IBAction func chooseAction(_ sender: Any) {
        delegate?.chooseFace(face: arrWatch[pagerView.currentIndex])
    }
}


extension PreviewWatch: FSPagerViewDataSource, FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrWatch.count == 0 ? 1 : arrWatch.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: kCell, at: index) as! WatchCell
        cell.positionText = index
        cell.totalText = arrWatch.count
        if arrWatch.count > 0{
            cell.face = arrWatch[index]
        }
        cell.setupUI()
        return cell
    }
    
}
