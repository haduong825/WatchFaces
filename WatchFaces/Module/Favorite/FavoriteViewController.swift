//
//  FavoriteViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController, StoryboardInstantiable {
    static var storyboardName: String = "Favorite"

    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var underTopContainerView: UIView!
    
    var listWatchView: ListWatchView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setupUI(){
        listWatchView = ListWatchView.createView(at: view)
        self.view.addSubview(listWatchView)
    }
    
    private func fetchData(){
        let faces = Array(realm.objects(Face.self))
        self.listWatchView.previewWatch.setupDataSource(faces: faces)
        self.listWatchView.gridWallpaper.setupDataSource(faces: faces)
    }
    
}


extension FavoriteViewController: WatchCellProtocol{
    func updateData() {
        fetchData()
    }
}

extension FavoriteViewController: PreviewWatchDelegate{
    func chooseFace(face: Face) {
        let vc = PreviewViewController.instantiate()
        self.present(vc, animated: true, completion: nil)
    }
    
}
