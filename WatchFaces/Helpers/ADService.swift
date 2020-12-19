//
//  ADService.swift
//  TBNMovies
//
//  Created by Hà Hải Dương on 10/24/20.
//  Copyright © 2020 Hà Hải Dương. All rights reserved.
//

import Foundation
import GoogleMobileAds

@objc protocol ADSServiceDelegate: class {
    @objc optional func adsServiceInterstitialWillDismissScreenn(adsService: ADSService, with ad: GADInterstitial)
    @objc optional func adsServicdeAdLoader(adsService: ADSService, _ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd)
    @objc optional func adsServiceAdViewDidReceiveAd(adsService: ADSService, _ bannerView: GADBannerView)
}

class ADSService: NSObject {
    static let shared: ADSService = {
        let ads = ADSService()
        return ads
    }()
    
    private var interstitial: GADInterstitial!
    private var isLoading: Bool = false
    private var numberTapped: Int = 0
    private var action: (() -> ())?
    weak var delegate: ADSServiceDelegate?
    
    private var adLoader: GADAdLoader!
    private var nativeAds: GADUnifiedNativeAd!
    private var bannerView: GADBannerView!
    
    private var configuration: Configuration = {
        let config = Configuration.init()
        return config
    }()
    
    private func getInterstitialUnitIdString() -> String {
        return configuration.baseInterstitialUnitId
    }
    
    private func getNativeAdsUnitIdString(isGlobal: Bool = true) -> String {
        return configuration.nativeSmallAdsUnitId
    }
    
    private func getBannerAdsUnitIdString() -> String {
        return configuration.nativeSmallAdsUnitId
    }
    
    func isShow() -> Bool {
        return configuration.isShowAdsAndRating
    }
    
    private func createInterstitial() -> GADInterstitial {
        let interstitialObj = GADInterstitial.init(adUnitID: getInterstitialUnitIdString())
        interstitialObj.delegate = self
        interstitialObj.load(GADRequest())
        return interstitialObj
    }
    
    func loadNativeAdLoader(rootViewController: UIViewController) {
        adLoader = GADAdLoader.init(adUnitID: getNativeAdsUnitIdString(), rootViewController: rootViewController, adTypes: [.unifiedNative], options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest.init())
    }
    
    func loadInterstitial() {
        isLoading = true
        interstitial = createInterstitial()
    }
    
    func resetNumberTapped() {
        self.numberTapped = 0
    }
    
    func show(viewController: UIViewController, isUseNumberTap: Bool = false, countTime: Int = 3) {
        if !isShowAds {return}
        if interstitial.isReady, isShow() {
            if isUseNumberTap {
                numberTapped += 1
                if numberTapped % countTime == 0 {
                    do {
                        UIApplication.shared.isStatusBarHidden = true
                        try interstitial.canPresent(fromRootViewController: viewController)
                        interstitial.present(fromRootViewController: viewController)
                    }
                    catch {
                        print(">>> \(error.localizedDescription)")
                    }
                }
            }
            else {
                do {
                    UIApplication.shared.isStatusBarHidden = true
                    try interstitial.canPresent(fromRootViewController: viewController)
                    interstitial.present(fromRootViewController: viewController)
                }
                catch {
                    print(">>> \(error.localizedDescription)")
                }
            }
        }
        else {
            print(">>> interstitial NOT READY")
        }
    }
    
    func showADSFromMainTabbar() {
        if isShow() {
            NotificationCenter.default.post(name: NSNotification.Name("showads"), object: nil)
        }
    }
    
    func isReady() -> Bool {
        return self.isLoading
    }
    
    func getInterstitial() -> GADInterstitial {
        return self.interstitial
    }
    
    func getNativeAds() -> GADUnifiedNativeAd? {
        if let nativeAds = self.nativeAds {
            return nativeAds
        }
        return nil
    }
    
    func initGADBannerView(viewController: UIViewController) {
        let adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.width, height: 50))
        bannerView = GADBannerView(adSize: adSize)
        bannerView.adUnitID = getBannerAdsUnitIdString()
        bannerView.rootViewController = viewController
        let request = GADRequest()
        bannerView.load(request)
        bannerView.isAutoloadEnabled = true
        bannerView.delegate = self
    }
}

// MARK: - GADBannerViewDelegate
extension ADSService: GADBannerViewDelegate{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("\(#function) is called")
        if let delegate = delegate {
            delegate.adsServiceAdViewDidReceiveAd?(adsService: self, bannerView)
        }
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
}


// MARK: - GADAdLoaderDelegate
extension ADSService: GADAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
    }
    
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        print("\(#function) is called")
    }
    
}

// MARK: - GADInterstitialDelegate
extension ADSService: GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        loadInterstitial()
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        isLoading = false
        print(">>> interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        isLoading = false
        print(">>> interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print(">>> interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print(">>> interstitialWillDismissScreen")
        if let delegate = delegate {
            delegate.adsServiceInterstitialWillDismissScreenn?(adsService: self, with: ad)
        }
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print(">>> nterstitialWillLeaveApplication")
    }
}
