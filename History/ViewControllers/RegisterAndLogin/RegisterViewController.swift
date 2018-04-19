//
//  RegisterViewController.swift
//  History
//
//  Created by 1 on 4/19/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var phoneRegisterVC: UIView!
    @IBOutlet weak var emailRegisterVC: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailRegisterVC.isHidden = true
        phoneRegisterVC.isHidden = false
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Constants.Notification.emailRegister), object: self, queue: nil, using: { (notification) in
//            self.emailRegisterVC.isHidden = false
//            self.phoneRegisterVC.isHidden = true
//        })
//        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Constants.Notification.phoneRegister), object: self, queue: nil, using: { (notification) in
//            self.emailRegisterVC.isHidden = true
//            self.phoneRegisterVC.isHidden = false
//        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.switchPages), name: NSNotification.Name(rawValue: Constants.Notification.phoneRegister), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.switchPages), name: NSNotification.Name(rawValue: Constants.Notification.emailRegister), object: nil)
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
    
    @objc func switchPages() {
        emailRegisterVC.isHidden = !emailRegisterVC.isHidden
        phoneRegisterVC.isHidden = !phoneRegisterVC.isHidden
    }
}
