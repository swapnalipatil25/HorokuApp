//
//  APIService.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit

class APIService: NSObject {
    
//    static func getProductList(completion:  @escaping (String) -> ()) {
    static func getProductList(completion:  @escaping (_  : [Products]) -> ()) {
        let searchURL = Constant.Horoku_API.base_URL

        if let url = URL(string: searchURL) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                
                guard let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    print("error while fetching data")
                    return
                }
                
                
                if let apiJSON = jsonData as? [String: Any], let products = apiJSON["products"] as? [String: Any]
                {
                    completion(products.map({_,_ in Products.init(jsonData: products)}))
                }
                
                
                
//                if let data = data, let jsonString = String(data: data, encoding: String.Encoding.utf8), error == nil {
//                    completion(jsonString)
//                } else {
//                    print("error=\(error!.localizedDescription)")
//                }
            }
            task.resume()
        }
    }
    
    
    
    
}
