//
//  SettingViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/13/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import StoreKit
import SafariServices

class SettingViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Setting"
    @IBOutlet weak var getPremiumAction: GradientView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var reviewAppView: UIView!
    @IBOutlet weak var shareAppView: UIView!
    @IBOutlet weak var privacyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI(){
        getPremiumAction.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPremium)))
        feedbackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFeedback)))
        reviewAppView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showReviewApp)))
        shareAppView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareApp)))
        privacyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPrivacy)))
    }
    
    @objc func showPremium(){
        let vc = PremiumViewController.instantiate()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func showFeedback(){
        let vc = SFSafariViewController(url: URL(string: "https://sites.google.com/view/termswfg/home")!)
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self
    }
    
    @objc func showReviewApp(){
        SKStoreReviewController.requestReview()
    }
    
    @objc func shareApp(){
        UIGraphicsBeginImageContext(view.frame.size)
                view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                let textToShare = "Check out my app"
                
                if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
                    let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "watch_silver")] as [Any]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    //Excluded Activities
        //            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                    
                    activityVC.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                    
                    // Anything you want to exclude
                    activityVC.excludedActivityTypes = [
                        UIActivity.ActivityType.postToWeibo,
                        UIActivity.ActivityType.print,
                        UIActivity.ActivityType.assignToContact,
                        UIActivity.ActivityType.saveToCameraRoll,
                        UIActivity.ActivityType.addToReadingList,
                        UIActivity.ActivityType.postToFlickr,
                        UIActivity.ActivityType.postToVimeo,
                        UIActivity.ActivityType.postToTencentWeibo,
                        UIActivity.ActivityType.postToFacebook
                    ]
                    
                    //               activityVC.popoverPresentationController?.sourceView = sender
                    self.present(activityVC, animated: true, completion: nil)
                }
                
    }
    
    @objc func showPrivacy(){
        let vc = SFSafariViewController(url: URL(string: "https://www.termsfeed.com/privacy-policy/e0f8a1cdc135bf771d08411385b28a2d")!)
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self
    }
    
}


extension SettingViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
