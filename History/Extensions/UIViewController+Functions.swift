//
//  UIViewController+Functions.swift
//  History
//
//  Created by Zhenyuan Shen on 4/27/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    @objc func dismissKeyboard(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
    }
    
    func showProgressBar() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor(Constants.Color.backgroundGray)
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                SVProgressHUD.show()
                self.view.isUserInteractionEnabled = false
                self.navigationController?.navigationBar.isUserInteractionEnabled = false
            }
        }
    }
    
    func hideProgressBar() {
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.view.isUserInteractionEnabled = true
                self.navigationController?.navigationBar.isUserInteractionEnabled = true
            }
        }
    }
    
    func showErrorAlert(title: String, msg: String){
        showErrorAlert(title: title, msg: msg, handler: nil)
    }
    
    func showErrorAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?) {
        // popup alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // https://stackoverflow.com/questions/19082963/how-to-make-completely-transparent-navigation-bar-in-ios-7
    // https://stackoverflow.com/questions/18969248/how-to-draw-a-transparent-uitoolbar-or-uinavigationbar-in-ios7
    
    //    var navBarBackgroundImage: UIImage?
    //    var navBarShadowImage: UIImage?
    
    func setupNavBar() {
        //        navBarBackgroundImage = self.navigationController?.navigationBar.backgroundImage(for: .default) // navBarBackgroundImage is nil
        //        navBarShadowImage = self.navigationController?.navigationBar.shadowImage // navBarShadowImage is nil
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func resetNavBar() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
    }
}
