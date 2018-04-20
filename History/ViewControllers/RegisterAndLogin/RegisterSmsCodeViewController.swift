//
//  RegisterSmsCodeViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/19/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterSmsCodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var smsCodeTextField: UITextField!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var hintLbl: UILabel!
    
    var user: AVUser?
    var phone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        smsCodeTextField.delegate = self
        smsCodeTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        smsCodeTextField.borderStyle = .none

        phone = user?.mobilePhoneNumber
        
        hintLbl.text = "请在下面输入验证码以确认\n+86 \(phone!)"
        hintLbl.numberOfLines = 2
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // https://stackoverflow.com/questions/31774006/how-to-get-height-of-keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            viewBottomConstraint.constant = -keyboardHeight
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // https://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes/35845040
    @objc func textFieldDidChange(textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        
        let length = textField.text?.count ?? 0
        
        if length == Constants.Default.defaultSmsCodeLength {
            // TODO
            // spindle
            checkSmsCode()
        }
    }
    

    // Hide/Dismiss keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewBottomConstraint.constant = 0
    }
    
    // Hide/Dismiss keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        smsCodeTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSetupPwd" {
            if let destination = segue.destination as? RegisterPasswordViewController {
//                let user = AVUser()
//                user.username = username
//                user.mobilePhoneNumber = phone
//                user.setValue(true, forKey: "mobilePhoneVerified")
                destination.user = user
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

    func checkSmsCode() {
//        AVUser.verifyMobilePhone(smsCodeTextField.text!) { (succeed, error) in
        AVOSCloud.verifySmsCode(smsCodeTextField.text!, mobilePhoneNumber: phone!) { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toSetupPwd", sender: self)
            } else {
                print(error?.localizedDescription)
                self.smsCodeTextField.text?.removeAll()
                
                // popup alert
                let alert = UIAlertController(title: "错误", message: "你输入的验证码不正确，请重试。", preferredStyle: .alert)
     
                let ok = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
                }

                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
