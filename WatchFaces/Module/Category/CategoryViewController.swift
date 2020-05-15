//
//  CategoryViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Category"
    static var storyboardBundle: Bundle? = Bundle(for: CategoryViewController.self)

    @IBOutlet weak var listView: UIView!
    var gridWallpaper: GridWallpaper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridWallpaper = GridWallpaper.createView()
        gridWallpaper.frame = listView.frame
        listView.addSubview(gridWallpaper)
    }
    


}
