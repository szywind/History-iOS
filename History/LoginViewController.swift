//
//  LoginViewController.swift
//  History
//
//  Created by 1 on 3/8/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import LeanCloudSocial
class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.phone.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        let alert = UIAlertController(title: "确认手机号", message: phone.text! + "\n我们将发送短信到上面的手机号", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let confirm = UIAlertAction(title: "确认", style: .default) { (action) in
            self.registerWithPhone()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    // hide/dismiss keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hide/dismiss keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phone.resignFirstResponder()
        return true
    }
    
    func registerWithPhone(){
        let user = AVUser()
        user.username = phone.text
        user.password =  "123456"
        user.email = "hang@leancloud.rocks"
        user.mobilePhoneNumber = phone.text
        user.signUp(nil)
        self.performSegue(withIdentifier: "toEnterVerificationCode", sender: self)
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
