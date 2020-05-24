//
//  CategoryViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Category"
    static var storyboardBundle: Bundle? = Bundle(for: CategoryViewController.self)

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var listCategory = [Category]()
    var listWatchView: ListWatchView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listWatchView = ListWatchView.createView(at: view)
        listWatchView.delegate = self
        listWatchView.previewWatch.delegate = self
        listWatchView.gridWallpaper.delegate = self
        self.listView.addSubview(listWatchView)
        UIApplication.shared.statusBarUIView?.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCategories()
    }
    
    private func fetchCategories(){
        LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
        NetworkManager.shared.getCategories { [weak self] (response) in
            guard let self = self else {return}
            self.listCategory = response.data
            DispatchQueue.main.async {
                self.categoryCollectionView.reloadData()
                self.categoryCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
                self.selectCategory(index: 0)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func selectCategory(index: Int){
        LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
        NetworkManager.shared.getFaces(id: self.listCategory[index].id) { [weak self] (response) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                var data = response.data
                self.mapWithRealm(faces: &data)
                self.listWatchView.previewWatch.setupDataSource(faces: data)
                self.listWatchView.gridWallpaper.setupDataSource(faces: data)
            }
        }
    }
    
    private func mapWithRealm(faces: inout [Face]){
        let faceinDB = Array(realm.objects(Face.self))
        for face in faces{
            let isExist = faceinDB.first(where: {$0.id == face.id})
            if isExist != nil{
                face.isLiked = true
            } else {
                face.isLiked = false
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

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectCategory(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.name = listCategory[indexPath.row].titleEng
        cell.setupData()
        return cell
    }
    
}

extension CategoryViewController: PreviewWatchDelegate{
    func chooseFace(face: Face) {
        directToPreview(face: face)
    }
    
}


extension CategoryViewController: GridWallpaperDelegate{
    func didSelect(at face: Face) {
        directToPreview(face: face)
    }
}

extension CategoryViewController: ListWatchViewDelegate{
    func getPremiumAction() {
        let vc = PremiumViewController.instantiate()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
