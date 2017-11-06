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
    static func getProductList(completion:  @escaping (_  : [Product]) -> ()) {
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
                var arrayProducts  = [Product]()
                if let apiJSON = (jsonData as AnyObject).object(forKey: "products") as? [[String:AnyObject]]
                    
                {
                    for oneProduct in apiJSON {
                        let product =  ProductManager().createProductObject(response: oneProduct)
                        arrayProducts.append(product)
                    }
                }
                completion(arrayProducts)
            }
            task.resume()
        }
    }
    
    
    
    
}
