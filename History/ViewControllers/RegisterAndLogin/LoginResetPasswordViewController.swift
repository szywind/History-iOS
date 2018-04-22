//
//  LoginResetPasswordViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/22/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class LoginResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var zoneTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var warningLbl: UILabel!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextBtn: UIButton!

    var isValidEmail = false
    var isValidPhone = false
    
    var user: AVUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userTextField.delegate = self
        userTextField.borderStyle = .none
        userTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        zoneTextField.borderStyle = .none
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        warningLbl.text = "请输入有效的手机号码。" // "注意：你的电话号码应该为11位。"
        
        imageView.isHidden = true
        warningLbl.isHidden = true
        nextBtn.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // https://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes/35845040
    @objc func textFieldDidChange(textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        
        let input = textField.text
        
        let length = input?.count ?? 0

//        if input?.isEmpty {
        if length == 0 {
            imageView.isHidden = true
            warningLbl.isHidden = true
            nextBtn.isEnabled = false
        } else {
            isValidEmail = (input?.isValidateEmail())!
            isValidPhone = (input?.isValidateMobile())!
            self.imageView.isHidden = false
            if isValidEmail || isValidPhone {
                self.imageView.image = UIImage(named: "ic_done_white")
                self.imageView.backgroundColor = UIColor.green
                self.warningLbl.isHidden = true
                self.nextBtn.isEnabled = true
            } else {
                self.imageView.image = UIImage(named: "ic_error_white")
                self.imageView.backgroundColor = UIColor.red
                self.warningLbl.isHidden = false
                self.nextBtn.isEnabled = false
            }
        }
        
    }
    
    // Hide/Dismiss keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewBottomConstraint.constant = 0
    }
    
    // Hide/Dismiss keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        var key = LCConstants.UserKey.email
        if isValidPhone {
            key = LCConstants.UserKey.phone
        }
        
        UserManager.sharedInstance.findUser(key: key, value: userTextField.text!) { (objects, error) in
            if error == nil && objects?.count == 1 {
                self.user = objects?.first as? AVUser
                if self.isValidPhone {
                    self.phoneVerify()
                } else {
                    self.emailVerify()
                }
            } else {
                print(error?.localizedDescription)
                self.errorAlert()
            }
        }

        
    }
    
    func phoneVerify() {
        AVUser.requestPasswordResetCode(forPhoneNumber: userTextField.text!, options: nil) { (succeed, error) in
//        AVSMS.requestShortMessage(forPhoneNumber: userTextField.text!, options: nil) { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toSmsCode", sender: self)
            } else {
                print(error?.localizedDescription)
                self.errorAlert()
            }
        }
    }
    
    func emailVerify() {
        AVUser.requestPasswordResetForEmail(inBackground: userTextField.text!) { (succeed, error) in
            if succeed {
                self.performSegue(withIdentifier: "toEmailVerification", sender: self)
            } else {
                print(error?.localizedDescription)
                self.errorAlert()
            }
        }
    }

    func errorAlert() { // TODO
        // popup alert
        let alert = UIAlertController(title: "错误", message: "未找到" + userTextField.text! + "对应的账号，请确认输入正确的手机号码或email并重试", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel) { (action) in
            
        }
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSmsCode" {
            if let destination = segue.destination as? RegisterSmsCodeViewController {
                destination.user = user
            }
        } else if segue.identifier == "toEmailVerification" {
            if let destination = segue.destination as? LoginEmailVerificationViewController {
                destination.mainVC = self
            }
        }
    }
}
