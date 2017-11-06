//
//  CartListViewController.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit
import SDWebImage

class CartListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let cellIdentifier = "CartTableViewCell"
    var arrayProductList = [Product]()
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       self.updateUI()
    }
    
    func updateUI()  {
        arrayProductList = ProductManager().getAllAddToCartProductsObject()
        
        DispatchQueue.main.async {
            
            if self.arrayProductList.count == 0
            {
                self.lblNoDataFound.isHidden = false
                self.tableView.isHidden = true
            }
            else{
                self.tableView.isHidden = false
                self.lblNoDataFound.isHidden = true
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUI()  {
        
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension CartListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProductList.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CartTableViewCell
        let oneProduct = self.arrayProductList[indexPath.row] as Product
        
        cell.lblVendorName.text = oneProduct.vendorName
        cell.lblProductPrice.text = String(oneProduct.price)
        cell.lblProductTitle.text = oneProduct.productName
        cell.lblVendorAddress.text = oneProduct.vendorAddress
        cell.product = oneProduct
        cell.delegate = self
        
        let imgURL  =   NSURL(string: (oneProduct.productImage) )
        cell.imgViewProductThumbnail.sd_setImage(with: imgURL as URL?  , placeholderImage: #imageLiteral(resourceName: "Placeholder"), options: SDWebImageOptions.highPriority, completed: nil)
        
        return cell
}
}

extension CartListViewController : RemoveFromCartDelegate
{
    func btnRemoveFromCartAction()
    {
        self.updateUI()
    }
}
