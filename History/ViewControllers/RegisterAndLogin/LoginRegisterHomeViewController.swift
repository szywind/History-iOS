//
//  LoginRegisterHomeViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/15/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class LoginRegisterHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
//        let backButton = UIBarButtonItem(title: , style: .can, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cancel() {
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
