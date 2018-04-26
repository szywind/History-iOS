//
//  MenuViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/27/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let borderColor = UITableView().separatorColor?.cgColor
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = borderColor
        
        self.navigationController?.navigationBar.isHidden = true
        
        signUpBtn.layer.borderWidth = 1
        signUpBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
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
