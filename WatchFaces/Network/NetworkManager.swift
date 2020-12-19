//
//  NetworkManager.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/18/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    func request(url: String, parameters: [String: String], completion: @escaping(Data?) -> Void){
        
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        let urlRequest = URLRequest(url: components.url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            
            completion(responseData)
        }
        task.resume()
    }
    
    func getCategories(completion: @escaping(CategoryResponse) -> Void){
        let url = Constants.categoryUrl + EndPoint.categorySearch
        let param = ["filter": "titleEng==\"**\"", "pageIndex": "0", "pageSize": "100"]
        request(url: url, parameters: param) { (data) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(CategoryResponse.self, from: data)
                completion(categories)
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func getFaces(id: String, completion: @escaping(FacesResponse) -> Void){
        let url = Constants.categoryUrl + EndPoint.faceSearch
        let param = ["filter": "categoryId==\"*\(id)*\"", "pageIndex": "0", "pageSize": "100"]
        request(url: url, parameters: param) { (data) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let faces = try decoder.decode(FacesResponse.self, from: data)
                completion(faces)
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}
