//
//  MenuProfilerViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/26/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class MenuProfilerViewController: BaseMenuViewController {

    @IBOutlet weak var editBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editBtn.layer.borderWidth = 1
        editBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func initUI() {
        setupNavBar()
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toEditProfile" {
//            if let destination = segue.destination as? MenuEditProfileViewController {
//                destination.nickname = nicknameLbl.text
//            }
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
