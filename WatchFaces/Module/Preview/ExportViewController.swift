//
//  ExportViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/24/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import StoreKit

class ExportViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Preview"
    static var storyboardIdentifier: String? = "ExportViewController"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var watchImageView: UIImageView!
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageContraint: NSLayoutConstraint!
    @IBOutlet weak var topImageContraint: NSLayoutConstraint!
    
    var wallpaperImage: UIImage!
    var watchImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        LoadingOverlay.shared.showOverlay(view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        let height = containerView.frame.height
        let width = containerView.frame.width
        
        self.leftImageContraint.constant = (13 / 246) * width
        self.rightImageContraint.constant = -(25 / 246) * width
        self.topImageContraint.constant = (89 / 452) * height
        self.bottomImageContraint.constant = -(108 / 452) * height
        
        self.wallpaperImageView.image = wallpaperImage
        self.watchImageView.image = watchImage
        LoadingOverlay.shared.hideOverlayView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToWatchAction(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(wallpaperImage, nil, nil, nil)
        SPAlert.present(title: "Added to Photos", preset: .done)
        SKStoreReviewController.requestReview()
    }
    
    @IBAction func backToHomeAction(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
