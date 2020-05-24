//
//  ExportViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/24/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class ExportViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Preview"
    static var storyboardIdentifier: String? = "ExportViewController"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageContraint: NSLayoutConstraint!
    @IBOutlet weak var topImageContraint: NSLayoutConstraint!
    
    var wallpaperImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI(){
        self.wallpaperImageView.image = wallpaperImage
        
        let height = self.view.safeAreaLayoutGuide.layoutFrame.size.height - 250
        let width = height * 67/108
        
        self.leftImageContraint.constant = (20 / 268) * width
        self.rightImageContraint.constant = -(32 / 268) * width
        self.topImageContraint.constant = (80 / 432) * height
        self.bottomImageContraint.constant = -(100 / 432) * height
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToWatchAction(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(wallpaperImage, nil, nil, nil)
        SPAlert.present(title: "Added to Photos", preset: .done)
        
    }
    
    @IBAction func backToHomeAction(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
