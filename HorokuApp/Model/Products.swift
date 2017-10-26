//
//  Products.swift
//  HorokuApp
//
//  Created by Swapnali on 27/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit

struct Products {
    var productName, price, vendorName, vendorAddress, productImg, phoneNumber: String
    
    init(jsonData: [String: Any]) {
        self.productName = jsonData["productname"] as? String ?? ""
        self.price = jsonData["price"] as? String ?? ""
        self.vendorName = jsonData["vendorname"] as? String ?? ""
        self.vendorAddress = jsonData["vendoraddress"] as? String ?? ""
        self.productImg = jsonData["productImg"] as? String ?? ""
        self.phoneNumber = jsonData["phoneNumber"] as? String ?? ""
    }
}
