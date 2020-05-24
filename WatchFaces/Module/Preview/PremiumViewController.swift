//
//  PremiumViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/24/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class PremiumViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Preview"
    static var storyboardIdentifier: String? = "PremiumViewController"

    @IBOutlet weak var backView: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI(){
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
    }

}
