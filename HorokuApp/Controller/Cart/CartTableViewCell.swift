//
//  CartTableViewCell.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit

protocol RemoveFromCartDelegate: NSObjectProtocol{
    func btnRemoveFromCartAction()
}

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgViewProductThumbnail: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var lblVendorAddress: UILabel!
    
    var delegate : RemoveFromCartDelegate!
    
    var product :Product? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCallVendorAction(_ sender: AnyObject) {
        Constant.HelperMethods.btnCallAction(strPhoneNo: (product?.phoneNumber)!)
        
    }
    @IBAction func btnRemoveFromCartAction(_ sender: AnyObject) {
         ProductManager().updateProduct(productName: product!, isAddedToCart: false)
        Constant.HelperMethods.showToast(viewToast: APP_DELEGATE.window!, message: "Removed from cart")
        
        // call delegate here
        self.delegate.btnRemoveFromCartAction()
    }
}
