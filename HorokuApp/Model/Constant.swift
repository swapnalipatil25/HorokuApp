//
//  Constant.swift
//  HorokuApp
//
//  Created by Swapnali on 26/10/17.
//  Copyright © 2017 swapnali. All rights reserved.
//

import UIKit
import Toast_Swift

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

class Constant: NSObject {
    struct Horoku_API {
        static let base_URL = "https://mobiletest-hackathon.herokuapp.com/getdata/"
    }
    
    struct HelperMethods {
        
        private static var loaderView: LoaderView!
        
        static let keyWindow = (UIApplication.shared.delegate as? AppDelegate)?.window
        
        //HUD METHODS
        static func showActivityIndicatory(label: String) {
            loaderView = UINib(nibName: "LoaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LoaderView
            loaderView.frame = UIScreen.main.bounds
            loaderView.loaderLabel.text = label
            HelperMethods.keyWindow?.addSubview(loaderView)
        }
        
        static func hideActivityIndicatory() {
            DispatchQueue.main.async {
                loaderView.removeFromSuperview()
            }
            
        }
        
        
        //CALL ACTION
        static func btnCallAction(strPhoneNo : String)  {
            var mobileNumber = strPhoneNo
            mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
            guard let number = URL(string: "tel:\(mobileNumber)") else { return }
            if #available(iOS 10.0, *)
            {
                UIApplication.shared.open(number)
            }
            else
            {
                // Fallback on earlier versions
                UIApplication.shared.openURL(number)
            }
        }
        
        
        static func showToast(viewToast : UIView,message : String)
        {
            var style = ToastStyle()
            style.messageColor = .white
            viewToast.makeToast(message, duration: 2.0, position: .center, style: style)
        }
    }
}
