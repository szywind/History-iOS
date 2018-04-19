//
//  RegisterDetailViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/19/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterPhoneViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var zoneTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var warningLbl: UILabel!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phoneTextField.delegate = self
        phoneTextField.borderStyle = .none
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        zoneTextField.borderStyle = .none
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        warningLbl.text = "请输入有效的手机号码。" // "注意：你的电话号码应该为11位。"

        imageView.isHidden = true
        warningLbl.isHidden = true
        nextBtn.isEnabled = false
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
        
        if length < 11 {
            imageView.isHidden = true
            warningLbl.isHidden = true
            nextBtn.isEnabled = false
        } else if (length > 11 || (length == 11 && !isValidateMobile(mobile: textField.text!))) {
            imageView.isHidden = false
            imageView.image = UIImage(named: "ic_error_white")
            imageView.backgroundColor = UIColor.red
            warningLbl.isHidden = false
            nextBtn.isEnabled = false
        } else {
            imageView.isHidden = false
            imageView.image = UIImage(named: "ic_done_white")
            imageView.backgroundColor = UIColor.green
            warningLbl.isHidden = true
            nextBtn.isEnabled = true
        }
    }
    
    // Hide/Dismiss keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewBottomConstraint.constant = 0
    }
    
    // Hide/Dismiss keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zoneTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        let alert = UIAlertController(title: "确认手机号", message: phoneTextField.text! + "\n我们将发送短信到上面的手机号", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let confirm = UIAlertAction(title: "确认", style: .default) { (action) in
            self.requireSmsCode()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    func requireSmsCode() {
//        AVUser.requestMobilePhoneVerify(phoneTextField.text!) { (succeed, error) in

        AVOSCloud.requestSmsCode(withPhoneNumber: phoneTextField.text!) { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toSmsCode", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
//    func registerWithPhone(){
//        let user = AVUser()
//        user.username = username
//        user.password = "123456"
//        //        user.email = "szywind@163.com"
//        user.mobilePhoneNumber = phoneTextField.text ?? ""
//        
//        AVUser.requestMobilePhoneVerify(user.mobilePhoneNumber!) { (succeed, error) in
//            if succeed {
//                self.performSegue(withIdentifier: "toEnterVerificationCode", sender: self)
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
//    }
    
    @IBAction func switchToEmailRegister(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.emailRegister), object: nil)
    }
    
    // https://blog.csdn.net/liu_esther/article/details/51578762
    func isValidateMobile(mobile: String) -> Bool {
        let mobile_ = mobile.replacingOccurrences(of: " ", with: "")
        if (mobile_.count != 11) {
            return false
        }
        // 移动号段正则表达式
        let cmNumReg = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"
        // 联通号段正则表达式
        let cuNumReg = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"
        // 电信号段正则表达式
        let ctNumReg = "^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$"
        
        let pred1 = NSPredicate(format: "SELF MATCHES %@", cmNumReg)
        let isMatch1 = pred1.evaluate(with: mobile)
        
        let pred2 = NSPredicate(format: "SELF MATCHES %@", cuNumReg)
        let isMatch2 = pred2.evaluate(with: mobile)
        
        let pred3 = NSPredicate(format: "SELF MATCHES %@", ctNumReg)
        let isMatch3 = pred3.evaluate(with: mobile)
        
        return isMatch1 || isMatch2 || isMatch3
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSmsCode" {
            if let destination = segue.destination as? RegisterSmsCodeViewController {
                destination.username = username
                destination.phone = phoneTextField.text
            }
        }
    }
}
