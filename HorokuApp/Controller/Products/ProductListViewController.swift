//
//  ProductListViewController.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit
import SDWebImage


class ProductListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrayProductList = [Product]()
    fileprivate let sectionInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(10)
    var itemHeight = CGFloat(322)
    var itemWidth = CGFloat(0)
    
    let reuseIdentifier = "ProductCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupCollectionView()
        self.callProductList_API()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateData()
        
    }
    
    func updateData()
    {
        self.arrayProductList = []
        self.arrayProductList = ProductManager().getAllProductsObject()
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false

        self.collectionView.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let aspectRatio = CGFloat(1.34) //(258/180)
        itemWidth =  (UIScreen.main.bounds.width - 30)/2
        itemHeight = itemWidth * aspectRatio
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = 10
        
        collectionView!.collectionViewLayout = layout
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func callProductList_API()  {
        
        Constant.HelperMethods.showActivityIndicatory(label: "Fetching Products...")
        APIService.getProductList { (products) in
            self.arrayProductList = products
                self.collectionView.reloadData()
                Constant.HelperMethods.hideActivityIndicatory()
        }
    }
}


// MARK: - UICollectionView Delegate and DataSource
extension ProductListViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProductCollectionViewCell
        let oneProduct = self.arrayProductList[indexPath.row] as Product
        
        cell.lblVenderName.text = oneProduct.vendorName
        cell.lblProductPrice.text = String(oneProduct.price)
        cell.lblProductTitle.text = oneProduct.productName
        cell.lblVendorAddress.text = oneProduct.vendorAddress
        
        if oneProduct.isAddedToCart
        {
            cell.btnAddToCart.isEnabled = false
        }
        else
        {
            cell.btnAddToCart.isEnabled = true
        }
        
        
        cell.product = oneProduct
        cell.delegate = self
        let imgURL  =   NSURL(string: (oneProduct.productImage) )
        cell.imgViewProductHeader.sd_setImage(with: imgURL as URL?  , placeholderImage: #imageLiteral(resourceName: "Placeholder"), options: SDWebImageOptions.highPriority, completed: nil)
        return cell
    }
}

extension ProductListViewController : AddToCartDelegate
{
    func btnAddToCartAction()
    {
        self.updateData()
    }
}
