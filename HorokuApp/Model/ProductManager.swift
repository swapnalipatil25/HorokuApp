//
//  DoctorManager.swift
//  eyada
//
//  Created by webwerks on 12/13/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

import UIKit

import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class Product : Object, Mappable
{
    
        dynamic var productName = ""
        dynamic var price = ""
        dynamic var vendorName = ""
        dynamic var vendorAddress = ""
        dynamic var productImage = ""
        dynamic var phoneNumber = ""
        dynamic var isAddedToCart = false

        override class func primaryKey() -> String?
        {
                return "productName"
        }
        
        required convenience init?(map: Map)
        {
                self.init()
        }
    
        func mapping(map: Map)
        {
            productName        <- map["productname"]
            price              <- map["price"]
            vendorName         <- map["vendorname"]
            vendorAddress      <- map["vendoraddress"]
            productImage       <- map["productImg"]
            phoneNumber        <- map["phoneNumber"]
            isAddedToCart      <- map["isAddedToCart"]
        }
}

class ProductManager: NSObject
{
        func createProductObject(response : Dictionary<String,AnyObject>) -> Product
        {
                let product = Mapper<Product>(context: nil).map(JSON: response)
                
                let realm = try! Realm()
                try! realm.write {
                        realm.add(product!, update: true)
                }
                return product!
        }
        
        func getAllProductsObject() -> [Product]
        {
                let realm = try! Realm()
                let count = realm.objects(Product.self).count
                if count > 0
                {
                        return Array(realm.objects(Product.self))
                }
                else
                {
                        return []
                }
        }
    
    func getAllAddToCartProductsObject() -> [Product]
    {
        let searchByAddedToCart = NSPredicate(format: "isAddedToCart == true")
        let realm = try! Realm()
        let list =  realm.objects(Product.self).filter(searchByAddedToCart)
        
        if list.count > 0
        {
            //return list
            return Array(list)
        }
        else
        {
            return []
        }
    }
    
      func updateProduct(productName : Product, isAddedToCart : Bool)
    {
        
//        DispatchQueue.main.async {
        let searchByProductName = NSPredicate(format: "productName == %@", productName.productName)
        let realm = try! Realm()
        let list =  realm.objects(Product.self).filter(searchByProductName)
        
        if let category = list.first
        {
            try! realm.write
            {
                category.isAddedToCart = isAddedToCart
                realm.add(category, update: true)
            }
        }
    }
//    }
}
