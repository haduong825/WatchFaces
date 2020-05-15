//
//  FavoriteViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import FSPagerView

class FavoriteViewController: UIViewController, StoryboardInstantiable {
    static var storyboardName: String = "Favorite"

    @IBOutlet weak var pagerView: UIView!
    
    var previewWatch: PreviewWatch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewWatch = PreviewWatch.createView()
        previewWatch.frame = pagerView.frame
        pagerView.addSubview(previewWatch)
    }
    
}

