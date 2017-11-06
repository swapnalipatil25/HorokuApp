//
//  ProductCollectionViewCell.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit

protocol AddToCartDelegate: NSObjectProtocol{
    func btnAddToCartAction()
}

class ProductCollectionViewCell: UICollectionViewCell {

    var delegate:AddToCartDelegate!
    
    @IBOutlet weak var imgViewProductHeader: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblVendorAddress: UILabel!
    @IBOutlet weak var lblVenderName: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    var product :Product? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func btnAddToCartAction(_ sender: AnyObject) {
        DispatchQueue.main.async {
            ProductManager().updateProduct(productName: self.product!, isAddedToCart: true)
            
            Constant.HelperMethods.showToast(viewToast: APP_DELEGATE.window!, message: "Added to cart")
            
            self.btnAddToCart.isEnabled = false

        }
    }
}
