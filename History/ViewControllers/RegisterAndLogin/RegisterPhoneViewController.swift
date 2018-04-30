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
    
    var mainVC: RegisterViewController?
    
//    var username: String?
    
//    class func create() -> RegisterPhoneViewController {
//        let board = UIStoryboard(name: "Main", bundle: nil)
//        return board.instantiateViewController(withIdentifier: String(describing: self)) as! RegisterPhoneViewController
//    }
    
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
        //        textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let length = textField.text?.count ?? 0
        
        if length < 11 {
            imageView.isHidden = true
            warningLbl.isHidden = true
            nextBtn.isEnabled = false
        } else if (length > 11 || (length == 11 && !(textField.text!.isValidateMobile()))) {
            imageView.isHidden = false
            imageView.image = UIImage(named: "ic_error_white")
            imageView.backgroundColor = UIColor.red
            warningLbl.isHidden = false
            warningLbl.text = "请输入有效的手机号码。"
            nextBtn.isEnabled = false
        } else {
            UserManager.sharedInstance.findUser(key: LCConstants.UserKey.phone, value: textField.text!) { (objects, error) in
                if error == nil {
                    self.imageView.isHidden = false
                    if objects?.count == 0 {
                        self.imageView.image = UIImage(named: "ic_done_white")
                        self.imageView.backgroundColor = UIColor.green
                        self.warningLbl.isHidden = true
                        self.nextBtn.isEnabled = true
                    } else {
                        self.imageView.image = UIImage(named: "ic_error_white")
                        self.imageView.backgroundColor = UIColor.red
                        self.warningLbl.isHidden = false
                        self.warningLbl.text = "该手机账号已存在，请重新输入。"
                        self.nextBtn.isEnabled = false
                    }
                } else {
                    print(error?.localizedDescription)
                }
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
        zoneTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        let alert = UIAlertController(title: "确认手机号", message: phoneTextField.text! + "\n我们将发送短信到上面的手机号", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let confirm = UIAlertAction(title: "确认", style: .default) { (action) in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.toSmsCodePage), object: nil, userInfo: ["phone" : self.phoneTextField.text!])
            self.mainVC?.phone = self.phoneTextField.text!
            self.mainVC?.phoneRegister()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func switchToEmailRegister(_ sender: UIButton) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.emailRegister), object: nil)
        mainVC?.switchPages()
    }
}
