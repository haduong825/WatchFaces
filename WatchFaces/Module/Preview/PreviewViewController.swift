//
//  PreviewViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/20/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import SDWebImage

class PreviewViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Preview"
    static var storyboardIdentifier: String? = "PreviewViewController"
    
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageContraint: NSLayoutConstraint!
    @IBOutlet weak var topImageContraint: NSLayoutConstraint!
    @IBOutlet weak var watchImageView: UIImageView!
    @IBOutlet weak var wallpaperImageView: UIImageView!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var fifthView: UIView!
    
    
    var face: Face!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        let width = UIScreen.main.bounds.width * 0.7
        let height = width * 108/67
        
        self.leftImageContraint.constant = (20 / 268) * width
        self.rightImageContraint.constant = -(32 / 268) * width
        self.topImageContraint.constant = (80 / 432) * height
        self.bottomImageContraint.constant = -(100 / 432) * height
        
        let imageUrl = Constants.baseUrl + EndPoint.watch + face.url
        self.wallpaperImageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        self.wallpaperImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        
        let firstButton = UIButton(frame: firstView.frame)
        firstButton.tag = 1000
        firstButton.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
        firstView.addSubview(firstButton)
        let secondButton = UIButton(frame: secondView.frame)
        secondButton.tag = 1001
        secondButton.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
        secondView.addSubview(secondButton)
        let thirdButton = UIButton(frame: thirdView.frame)
        thirdButton.tag = 1002
        thirdButton.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
        thirdView.addSubview(thirdButton)
        let fourButton = UIButton(frame: fourView.frame)
        fourButton.tag = 1003
        fourButton.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
        fourView.addSubview(fourButton)
        let fifthButton = UIButton(frame: fifthView.frame)
        fifthButton.tag = 1004
        fifthButton.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
        fifthView.addSubview(fifthButton)
        
        selectColor(firstButton)
    }
    
    func resetBorder(){
        firstView.layer.borderWidth = 0
        secondView.layer.borderWidth = 0
        thirdView.layer.borderWidth = 0
        fourView.layer.borderWidth = 0
        fifthView.layer.borderWidth = 0
    }
    
    @objc func selectColor(_ sender: UIButton){
        resetBorder()
        switch sender.tag {
        case 1000:
            firstView.layer.borderWidth = 1
            watchImageView.image = #imageLiteral(resourceName: "image_applewatch")
        case 1001:
            secondView.layer.borderWidth = 1
        case 1002:
            thirdView.layer.borderWidth = 1
            watchImageView.image = #imageLiteral(resourceName: "watch_silver")
        case 1003:
            fourView.layer.borderWidth = 1
            watchImageView.image = #imageLiteral(resourceName: "watch_rose_gold")
        case 1004:
            fifthView.layer.borderWidth = 1
        default:
            break
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
}
