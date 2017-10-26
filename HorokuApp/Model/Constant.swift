//
//  Constant.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit

class Constant: NSObject {
    struct Horoku_API {
        static let base_URL = "https://mobiletest-hackathon.herokuapp.com/getdata/"
    }
    
    struct HelperMethods {
        
        private static var loaderView: LoaderView!
        
        static let keyWindow = (UIApplication.shared.delegate as? AppDelegate)?.window
        
        static func showActivityIndicatory(label: String) {
            loaderView = UINib(nibName: "LoaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LoaderView
            loaderView.frame = UIScreen.main.bounds
            loaderView.loaderLabel.text = label
            HelperMethods.keyWindow?.addSubview(loaderView)
        }
        
        static func hideActivityIndicatory() {
            loaderView.removeFromSuperview()
        }
    }
}
