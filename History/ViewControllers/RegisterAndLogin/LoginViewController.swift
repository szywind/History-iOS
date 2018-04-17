//
//  LoginViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/8/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class LoginViewController: ViewController, UITextFieldDelegate {

    @IBOutlet var phoneTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.phoneTextfield.delegate = self
        
        // test LeanCloud setup as https://leancloud.cn/docs/start.html
//        let post = LCObject(className: "TestObject")
//        post.set("words", value: "Hello World!")
//        post.save()
        
        phoneTextfield.setBottomBOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        let alert = UIAlertController(title: "确认手机号", message: phoneTextfield.text! + "\n我们将发送短信到上面的手机号", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let confirm = UIAlertAction(title: "确认", style: .default) { (action) in
            self.registerWithPhone()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    // Hide/Dismiss keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Hide/Dismiss keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextfield.resignFirstResponder()
        return true
    }
    
    func registerWithPhone(){
        let user = AVUser()
        user.username = phoneTextfield.text
        user.password = "123456"
//        user.email = "szywind@163.com"
        user.mobilePhoneNumber = phoneTextfield.text ?? ""
        
        AVUser.requestMobilePhoneVerify(user.mobilePhoneNumber!) { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toEnterVerificationCode", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func registerWithUsername(){
        
    }
    
    func instantLoginWithPhone(){
        
    }
    
    func loginWithPhone(){
        
    }
    
    func loginWithUsername(){
        
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
