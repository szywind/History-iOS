//
//  BaseViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = Constants.Color.naviBarTint
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
        
//        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createView() {
    }
    
//    // https://stackoverflow.com/questions/37805885/how-to-create-dispatch-queue-in-swift-3
//    func refreshUI() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            // Bounce back to the main thread to update the UI
//            DispatchQueue.main.async {
//                self.createView()
//            }
//        }
//    }

    func dismissKeyboard(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
