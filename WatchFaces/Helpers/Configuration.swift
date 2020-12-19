//
//  BaseViewController.swift
//  TBNMovies
//
//  Created by Hà Hải Dương on 9/9/20.
//  Copyright © 2020 Hà Hải Dương. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Configuration: NSObject {
    // MARK: - ADS unitId
    private let interstitialAdsUnitProd = "ca-app-pub-8418104583641512/5704014987"
    private let interstitialAdsUnitTest = "ca-app-pub-3940256099942544/4411468910"
    
    private let nativeSmallAdsUnitIdProd = "ca-app-pub-8418104583641512/4526664682"
    private let nativeSmallAdsUnitIdTest = "ca-app-pub-3940256099942544/3986624511"
    
    private let nativeLargeAdsUnitIdProd = "ca-app-pub-8418104583641512/9807945367"
    private let nativeLargeAdsUnitIdTest = "ca-app-pub-3940256099942544/3986624511"
    
    private let currentDate: Date = Date()
    private let dueDateString: String = "23:59:59 10/12/2020"
    
    var baseRequestURL: String = ""
    var baseImageURL: String = ""
    var baseInterstitialUnitId: String = ""
    var nativeSmallAdsUnitId: String = ""
    var nativeLargeAdsUnitId: String = ""
    var isShowAdsAndRating: Bool = false
    
    override init() {
        #if DEBUG
            baseInterstitialUnitId = interstitialAdsUnitTest
            nativeSmallAdsUnitId = nativeSmallAdsUnitIdTest
            nativeLargeAdsUnitId = nativeLargeAdsUnitIdTest
            if let dueDate = dueDateString.convertToDateWithFormat(format: "HH:mm:ss dd/MM/yyyy"), currentDate >= dueDate {
                isShowAdsAndRating = true
            }
            else {
                isShowAdsAndRating = false
            }
        #else
        baseInterstitialUnitId = interstitialAdsUnitProd
        nativeSmallAdsUnitId = nativeSmallAdsUnitIdProd
        nativeLargeAdsUnitId = nativeLargeAdsUnitIdProd
            if let dueDate = dueDateString.convertToDateWithFormat(format: "HH:mm:ss dd/MM/yyyy"), currentDate >= dueDate {
                isShowAdsAndRating = true
            }
            else {
                isShowAdsAndRating = false
            }
        #endif
    }
}
