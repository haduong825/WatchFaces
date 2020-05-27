//
//  MainTabbarViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/12/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import StoreKit

class MainTabbarViewController: PTCardTabBarController {

    override func viewDidLoad() {
        createViewControllers()
        
        super.viewDidLoad()
        
//        SKStoreReviewController.requestReview()

        tabBarBackgroundColor = UIColor(rgb: 0xff1A1A1A)
        
        
    }
    
    func createViewControllers(){
        let favoriteViewController = FavoriteViewController.instantiateWithNavigationController()
        let categoryViewController = CategoryViewController.instantiateWithNavigationController()
        let settingViewController  = SettingViewController.instantiateWithNavigationController()
        
        favoriteViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "grey-heart"), selectedImage: #imageLiteral(resourceName: "red-heart"))
        categoryViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_category"), selectedImage: #imageLiteral(resourceName: "ic_category_selected"))
        settingViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_setting"), selectedImage: #imageLiteral(resourceName: "ic_setting_selected"))

        self.viewControllers = [favoriteViewController, categoryViewController, settingViewController]
    }


}
