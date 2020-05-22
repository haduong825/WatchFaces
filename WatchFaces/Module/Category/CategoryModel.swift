//
//  CategoryModel.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/18/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoryResponse = try? newJSONDecoder().decode(CategoryResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let status: String
    let code: Int
    let data: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id: String
    let titleEng: String
    let totalImg: Int
}

// MARK: - FacesResponse
struct FacesResponse: Codable {
    let status: String
    let code: Int
    let data: [Face]
}

// MARK: - Face
class Face: Object, Codable {
    @objc dynamic var id: String
    @objc dynamic var url: String
    @objc dynamic var paid: Bool
    @objc dynamic var categoryID: String
    
    @objc dynamic var isLiked: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id, url, paid
        case categoryID = "categoryId"
    }
    
}
