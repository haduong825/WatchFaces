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
        listWatchView.delegate = self
        listWatchView.previewWatch.delegate = self
        listWatchView.gridWallpaper.delegate = self
        
        let vc = PremiumViewController.instantiate()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        fetchData()
    }
    
    private func setupUI(){
        listWatchView = ListWatchView.createView(at: view)
        self.view.addSubview(listWatchView)
    }
    
    private func fetchData(){
        let predicate = NSPredicate(format: "isLiked = true")
        let faces = Array(realm.objects(Face.self).filter(predicate))
        self.listWatchView.previewWatch.setupDataSource(faces: faces)
        self.listWatchView.gridWallpaper.setupDataSource(faces: faces)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let predicate = NSPredicate(format: "isLiked = false")
        let facesDelete = Array(realm.objects(Face.self).filter(predicate))
        
        if facesDelete.count > 0 {
            try! realm.write {
                realm.delete(facesDelete)
            }
        }
    }
    
    func directToPreview(face: Face){
        let vc = PreviewViewController.instantiate()
        vc.face = face
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension FavoriteViewController: PreviewWatchDelegate{
    func chooseFace(face: Face) {
        directToPreview(face: face)
    }
    
}

extension FavoriteViewController: GridWallpaperDelegate{
    
    func didSelect(at face: Face) {
        directToPreview(face: face)
    }
}

extension FavoriteViewController: ListWatchViewDelegate{
    func getPremiumAction() {
        let vc = PremiumViewController.instantiate()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
