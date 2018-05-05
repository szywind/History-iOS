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

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var visibleBtn: UIButton!
    @IBOutlet weak var forgotPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userTextField.delegate = self
        userTextField.borderStyle = .none
        userTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)

        pwdTextField.delegate = self
        pwdTextField.borderStyle = .none
        pwdTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        pwdTextField.isSecureTextEntry = true
        
        visibleBtn.isHidden = true
        visibleBtn.setBackgroundImage(UIImage(named: "ic_visibility"), for: .normal)
        visibleBtn.tintColor = Constants.Color.naviBarTint
        visibleBtn.setTitleColor(UIColor.clear, for: .normal)
        visibleBtn.isEnabled = false
        
        loginBtn.isEnabled = false
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
//        textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let length = textField.text?.count ?? 0
        loginBtn.isEnabled = (!(userTextField.text?.isEmpty)! && !(pwdTextField.text?.isEmpty)!)
        
        if textField.accessibilityIdentifier == "password" {
            if length > 0 {
                visibleBtn.isHidden = false
                visibleBtn.isEnabled = true
            } else {
                visibleBtn.isHidden = true
                visibleBtn.isEnabled = false
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegister" {
            if let destination = segue.destination as? RegisterViewController {
                let user = AVUser()
                user.setObject(userTextField.text, forKey: "nickname")
                destination.user = user
            }
        }
    }
    
    @IBAction func onShowPwdTapped(_ sender: UIButton) {
        if pwdTextField.isSecureTextEntry {
            visibleBtn.setBackgroundImage(UIImage(named: "ic_visibility_off"), for: .normal)
            visibleBtn.tintColor = Constants.Color.naviBarTint
        } else {
            visibleBtn.setBackgroundImage(UIImage(named: "ic_visibility"), for: .normal)
            visibleBtn.tintColor = Constants.Color.naviBarTint
        }
        pwdTextField.isSecureTextEntry = !pwdTextField.isSecureTextEntry
    }
    
    @IBAction func onLoginTapped(_ sender: UIButton) {
        self.showProgressBar()
        AVUser.logInWithUsername(inBackground: userTextField.text!, password: pwdTextField.text!) { (user, error) in
            self.hideProgressBar()
            if error == nil {
//                UserManager.sharedInstance.setUserLocation()
//                AVUser.current()?.saveInBackground()
//                self.gotoMainPage()
                
//                let a = user?.username
//                let b = AVUser.current()?.username
//                assert(a == b)
                
                self.dismiss(animated: true, completion: nil)
//                self.gotoMainPage()
            } else {
//                if error?.localizedDe == kAVErrorUserNotFound {
//                    self.showErrorAlert(NSLocalizedString("user not found", comment:"user not found"), msg: "")
//                } else if error.code == kAVErrorUsernamePasswordMismatch {
//                    self.showErrorAlert(NSLocalizedString("wrong password", comment:"wrong password"), msg: "")
//                }
                print(error?.localizedDescription)
                self.showErrorAlert(title: "错误", msg: "登录失败，请确认输入正确的手机号码或email并重试") { (action) in
//                    self.userTextField.text?.removeAll()
//                    self.pwdTextField.text?.removeAll()
                    
                    self.loginBtn.isEnabled = false
                }
            }
        }
    }
    
    func gotoMainPage() {
        self.performSegue(withIdentifier: "toMainPageTab", sender: self)
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
