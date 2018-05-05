//
//  RegisterViewController.swift
//  History
//
//  Created by 1 on 4/19/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterViewController: UIViewController {

    @IBOutlet weak var phoneRegisterVC: UIView!
    @IBOutlet weak var emailRegisterVC: UIView!
    
    fileprivate var phoneRegisterViewController: RegisterPhoneViewController?
    fileprivate var emailRegisterViewController: RegisterEmailViewController?

    var phone: String?
    var email: String?
    var user: AVUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailRegisterVC.isHidden = true
        phoneRegisterVC.isHidden = false
        
        user?.password = Constants.Default.defaultPassword
        user?.setObject(Constants.Default.defaultValid, forKey: "valid")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(switchPages), name: NSNotification.Name(rawValue: Constants.Notification.phoneRegister), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(switchPages), name: NSNotification.Name(rawValue: Constants.Notification.emailRegister), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(phoneRegister), name: NSNotification.Name(rawValue: Constants.Notification.toSmsCodePage), object: phone)
//        NotificationCenter.default.addObserver(self, selector: #selector(emailRegister), name: NSNotification.Name(rawValue: Constants.Notification.toSetupPwdPage), object: email)
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
    
    /*
    @objc func phoneRegister(notification: NSNotification) {
        phone = notification.userInfo!["phone"] as? String
        user?.username = phone
        user?.mobilePhoneNumber = phone

//        AVUser.requestMobilePhoneVerify(phone!) { (succeed, error) in
        AVSMS.requestShortMessage(forPhoneNumber: phone!, options: nil) { (succeed, error) in
//        user?.signUpInBackground { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toSmsCode", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @objc func emailRegister(notification: NSNotification) {
        email = notification.userInfo!["email"] as? String
        user?.username = email
        user?.email = email
        
//        user?.signUpInBackground { (succeed, error) in
//            if succeed {
//                self.performSegue(withIdentifier: "toSetupPwd", sender: self)
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
        performSegue(withIdentifier: "toSetupPwd", sender: self)
    }
    */
    
    func phoneRegister() {
        user?.username = phone
        user?.mobilePhoneNumber = phone
        
        //        AVUser.requestMobilePhoneVerify(phone!) { (succeed, error) in
        AVSMS.requestShortMessage(forPhoneNumber: phone!, options: nil) { (succeed, error) in
            //        user?.signUpInBackground { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toSmsCode", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func emailRegister() {
        user?.username = email
        user?.email = email
        
        //        user?.signUpInBackground { (succeed, error) in
        //            if succeed {
        //                self.performSegue(withIdentifier: "toSetupPwd", sender: self)
        //            } else {
        //                print(error?.localizedDescription)
        //            }
        //        }
        performSegue(withIdentifier: "toSetupPwd", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSmsCode" {
            if let destination = segue.destination as? RegisterSmsCodeViewController {
                destination.user = user
                destination.isSignup = true
            }
        } else if segue.identifier == "toSetupPwd" {
            if let destination = segue.destination as? RegisterPasswordViewController {
                destination.user = user
                destination.isSignup = true
            }
        } else if segue.identifier == String(describing: RegisterPhoneViewController.self) {
            self.phoneRegisterViewController = segue.destination as? RegisterPhoneViewController
            self.phoneRegisterViewController?.mainVC = self
        } else if segue.identifier == String(describing: RegisterEmailViewController.self) {
            self.emailRegisterViewController = segue.destination as? RegisterEmailViewController
            self.emailRegisterViewController?.mainVC = self
        }
    }
}
