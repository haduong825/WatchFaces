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
    
    @IBOutlet weak var colorStackView: UIStackView!
    @IBOutlet weak var chooseColorLabel: UILabel!
    @IBOutlet weak var widthWatchContraint: NSLayoutConstraint!
    
    @IBOutlet weak var premiumView: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var blurLabel: UILabel!
    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var stickerLabel: UILabel!
    @IBOutlet weak var editorStackView: UIStackView!
    
    var face: Face!
    var blurView: BlurView!
    var listStickerView: ListStickerView!
    var faceImage: UIImage?
    let visualEffectView = VisualEffectView()
    var blurRadius: CGFloat = 0
    var watchImage: UIImage!
    var stickers = [UIImage]()
    var stickerImageViews = [UIImageView]()
    private var listSticker = [StickerView]()
    private var _selectedStickerView:StickerView?
    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            
            // if other sticker choosed then resign the handler
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            
            // assign handler to new sticker added
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.hidesBottomBarWhenPushed = true
        let width = UIScreen.main.bounds.width * 0.7
        let height = width * 108/67
        
        self.leftImageContraint.constant = (20 / 268) * width
        self.rightImageContraint.constant = -(32 / 268) * width
        self.topImageContraint.constant = (80 / 432) * height
        self.bottomImageContraint.constant = -(100 / 432) * height
        
        for i in 10..<94{
            stickers.append(UIImage(named: "Rectangle Copy \(i)") ?? UIImage())
        }
        
        firstView.layer.cornerRadius = firstView.frame.width / 2
        
        
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
        
        blurView = BlurView.createView()
        blurView.delegate = self
        blurView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 130, width: UIScreen.main.bounds.width, height: 130)

        listStickerView = ListStickerView.createView()
        listStickerView.delegate = self
        listStickerView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 260, width: UIScreen.main.bounds.width, height: 260)
        listStickerView.stickers = stickers
        
        if face.paid && !PremiumProduct.store.checkPurchased() {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.8649501039, blue: 0.2220553254, alpha: 1)
            premiumView.isHidden = false
            unlockButton.isHidden = false
            backButton.setImage(#imageLiteral(resourceName: "ic_back_black"), for: .normal)
            titleLabel.textColor = UIColor.black
            saveButton.setTitleColor(UIColor.black, for: .normal)
            saveButton.setTitle("Unlock", for: .normal)
            firstView.borderColor = UIColor.black
            secondView.borderColor = UIColor.black
            thirdView.borderColor = UIColor.black
            fourView.borderColor = UIColor.black
            fifthView.borderColor = UIColor.black
            blurImageView.image = #imageLiteral(resourceName: "ic-blur-black")
            blurLabel.textColor = UIColor.black
            stickerImageView.image = #imageLiteral(resourceName: "ic-sticker-black")
            stickerLabel.textColor = UIColor.white
            chooseColorLabel.textColor = UIColor.black
            blurView.backgroundColor = #colorLiteral(red: 1, green: 0.8649501039, blue: 0.2220553254, alpha: 1)
            editorStackView.isHidden = true
        } else {
            view.backgroundColor = UIColor.black
            premiumView.isHidden = true
            unlockButton.isHidden = true
            backButton.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
            titleLabel.textColor = UIColor.white
            saveButton.setTitleColor(UIColor.white, for: .normal)
            saveButton.setTitle("Save", for: .normal)
            firstView.borderColor = UIColor.white
            secondView.borderColor = UIColor.white
            thirdView.borderColor = UIColor.white
            fourView.borderColor = UIColor.white
            fifthView.borderColor = UIColor.white
            blurImageView.image = #imageLiteral(resourceName: "ic_blur")
            blurLabel.textColor = UIColor.white
            stickerImageView.image = #imageLiteral(resourceName: "sticker")
            stickerLabel.textColor = UIColor.white
            chooseColorLabel.textColor = UIColor.white
            blurView.backgroundColor = UIColor.black
            editorStackView.isHidden = false
        }
        
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
            watchImageView.image = #imageLiteral(resourceName: "aw-b")
        case 1002:
            thirdView.layer.borderWidth = 1
            watchImageView.image = #imageLiteral(resourceName: "watch_silver")
        case 1003:
            fourView.layer.borderWidth = 1
            watchImageView.image = #imageLiteral(resourceName: "watch_rose_gold")
        case 1004:
            fifthView.layer.borderWidth = 1
            watchImageView.image = #imageLiteral(resourceName: "watch_rose_gold")
        default:
            break
        }
    }
    
    private func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage?{
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {
            return nil
        }
        
        return UIImage(ciImage: outputImage)
    }
    
    @IBAction func blurAction(_ sender: Any) {
        visualEffectView.frame = CGRect(x: 0, y: 0, width: wallpaperImageView.frame.width, height: wallpaperImageView.frame.height)
        visualEffectView.colorTint = .black
        visualEffectView.colorTintAlpha = 0
        visualEffectView.blurRadius = 0
        visualEffectView.scale = 1
        wallpaperImageView.addSubview(visualEffectView)
        self.view.addSubview(blurView)
    }
    
    @IBAction func stickerAction(_ sender: Any) {
        self.view.addSubview(listStickerView)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if face.paid && !PremiumProduct.store.checkPurchased() {
            let vc = PremiumViewController.instantiate()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            self.selectedStickerView?.showEditingHandlers = false
            
            let img = self.wallpaperImageView.takeScreenshot()
            
            let vc = ExportViewController.instantiate()
            vc.wallpaperImage = img
            vc.watchImage = watchImageView.image
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func unlockAction(_ sender: Any) {
        let vc = PremiumViewController.instantiate()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}


extension PreviewViewController: BlurViewDelegate{
    func closeAction() {
        visualEffectView.removeFromSuperview()
        self.blurView.removeFromSuperview()
    }
    
    func doneAction() {
        self.blurView.removeFromSuperview()
    }
    
    func blurChange(value: Float) {
        self.blurRadius = CGFloat(value)
        visualEffectView.blurRadius = self.blurRadius * 10
    }
    
}


extension PreviewViewController: ListStickerViewDelegate{
    func closeStickerAction() {
        listStickerView.removeFromSuperview()
        for sticker in listSticker{
            sticker.removeFromSuperview()
        }
    }
    
    func doneStickerAction() {
        self.selectedStickerView?.showEditingHandlers = false
        
        for sticker in listSticker{
            let frame = wallpaperImageView.convert(sticker.frame, from: view)
            sticker.frame = frame
            sticker.removeFromSuperview()
            wallpaperImageView.addSubview(sticker)
        }
        
        listSticker.removeAll()
        listStickerView.removeFromSuperview()
    }
    
    func selectSticker(image: UIImage) {
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let stickerView = StickerView(contentView: imageView)
        listSticker.append(stickerView)
        stickerView.delegate = self
        stickerView.center = visualEffectView.contentView.center
        stickerView.setImage(UIImage.init(named: "Close")!, forHandler: StickerViewHandler.close)
//        stickerView.setImage(UIImage.init(named: "Rotate")!, forHandler: StickerViewHandler.rotate)
        stickerView.enableRotate = false
        stickerView.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
        stickerView.setHandlerSize(30)
        stickerView.showEditingHandlers = true
        view.addSubview(stickerView)
    }
}

extension PreviewViewController: StickerViewDelegate{
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        guard let index = listSticker.firstIndex(of: stickerView) else {return}
        listSticker.remove(at: index)
    }
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    
}
