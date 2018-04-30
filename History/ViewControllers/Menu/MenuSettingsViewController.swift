//
//  MenuSettingsViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/30/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class MenuSettingsViewController: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        //        let cancelBtn = UIBarButtonItem(image: UIImage(named: "ic_keyboard_arrow_left"), style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        logoutBtn.layer.borderWidth = 1
        logoutBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
        logoutBtn.isHidden = !UserManager.sharedInstance.isLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(_ sender: UIButton) {
        UserManager.sharedInstance.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
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
