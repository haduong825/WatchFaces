//
//  AppConstants.swift
//  Ringtunes
//
//  Created by Hà Dương on 3/4/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let baseUrl      : String = "http://45.33.47.79"
    static let categoryUrl  : String = Constants.baseUrl + ":6977"
}

struct EndPoint{
    static let categorySearch = "/category/search"
    static let faceSearch     = "/face/search"
    static let watch          = "/watch/"
}
