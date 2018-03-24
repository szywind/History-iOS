//
//  SettingsViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 08/03/2018.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    
//    @IBAction func OnClickRegisterOrLogin(_ sender: UIButton) {
//        // TODO
//        // https://github.com/leancloud/leancloud-social-ios
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = Constants.Color.naviBarTint
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
