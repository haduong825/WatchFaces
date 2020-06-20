//
//  PremiumViewController.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/24/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import UIKit
import StoreKit
import SafariServices

public struct PremiumProduct {
    
    public static let weekID = "com.prox.watchWallpaper.weekly"
    public static let yearID = "com.prox.watchWallpaper.yearlyPremium"
    
    private static let productIdentifiers: Set<ProductIdentifier> = [PremiumProduct.weekID, PremiumProduct.yearID]
    
    public static let store = IAPHelper(productIds: productIdentifiers)
}

class PremiumViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String = "Preview"
    static var storyboardIdentifier: String? = "PremiumViewController"
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var yearlyView: GradientView!
    @IBOutlet weak var weeklyView: UIView!
    @IBOutlet weak var yearlyLabel: UILabel!
    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var termButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    
    var yearProduct: SKProduct?
    var weekProduct: SKProduct?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI(){
        yearlyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(yearlyAction)))
        weeklyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(weeklyAction)))
        
        termButton.underline()
        privacyButton.underline()
    }
    
    private func setupData(){
        LoadingOverlay.shared.showOverlay(view: self.view)
        PremiumProduct.store.requestProducts{ [weak self] success, products in
            guard let self = self else { return }
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if success {
                    self.yearProduct = products!.first { (product) -> Bool in
                        product.productIdentifier == PremiumProduct.yearID
                    }
                    self.weekProduct = products!.first { (product) -> Bool in
                        product.productIdentifier == PremiumProduct.weekID
                    }
                    self.yearlyLabel.text = self.priceStringForProduct(item: self.yearProduct!)
                    self.weeklyLabel.text = self.priceStringForProduct(item: self.weekProduct!)
                }
            }
        }
    }
    
    func priceStringForProduct(item: SKProduct) -> String? {
        let price = item.price
        if price == NSDecimalNumber(decimal: 0.00) {
            return "Loading"
        } else {
            let numberFormatter = NumberFormatter()
            let locale = item.priceLocale
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = locale
            return numberFormatter.string(from: price)
        }
    }
    
    @objc func yearlyAction(){
        if let yearProduct = self.yearProduct{
            PremiumProduct.store.buyProduct(yearProduct)
        }
    }
    
    @objc func weeklyAction(){
        if let weekProduct = self.weekProduct{
            PremiumProduct.store.buyProduct(weekProduct)
        }
    }
    
    @IBAction func restoreAction(_ sender: Any) {
        LoadingOverlay.shared.showOverlay(view: self.view)
        PremiumProduct.store.restorePurchases()
        LoadingOverlay.shared.hideOverlayView()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func termAction(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://proxpolicy.github.io/Watch_Face/terms_of_service")!)
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self
    }
    @IBAction func privacyAction(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://proxpolicy.github.io/Watch_Face/privacy")!)
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self
    }
}


extension PremiumViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
