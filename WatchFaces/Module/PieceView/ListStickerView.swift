//
//  ListStickerView.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/23/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

protocol ListStickerViewDelegate {
    func closeStickerAction()
    func doneStickerAction()
    func selectSticker(image: UIImage)
}

class ListStickerView: UIView {

    @IBOutlet weak var stickerCollectionView: UICollectionView!
    
    var delegate: ListStickerViewDelegate?
    var stickers: [UIImage]!
    private let kCell = "StickerCollectionViewCell"
    
    open class func createView() -> ListStickerView{
        let views = Bundle.main.loadNibNamed("ListStickerView", owner: self, options: nil)
        let view = views?.first as! ListStickerView
        view.initCollectionView()
        return view
    }
    
    private func initCollectionView(){
        let nib = UINib(nibName: kCell, bundle: nil)
        stickerCollectionView.register(nib, forCellWithReuseIdentifier: kCell)
        stickerCollectionView.dataSource = self
        stickerCollectionView.delegate = self
    }
    
    @IBAction func closeButton(_ sender: Any) {
        delegate?.closeStickerAction()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        delegate?.doneStickerAction()
    }
}


extension ListStickerView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCell, for: indexPath) as? StickerCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.stickerImage = stickers[indexPath.row]
        cell.setupData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectSticker(image: stickers[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
