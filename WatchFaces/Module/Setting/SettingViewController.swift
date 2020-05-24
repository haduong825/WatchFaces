//
//  SettingViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Setting"
    @IBOutlet weak var getPremiumAction: GradientView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI(){
        getPremiumAction.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPremium)))
    }
    
    @objc func showPremium(){
        let vc = PremiumViewController.instantiate()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
