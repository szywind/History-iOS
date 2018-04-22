//
//  RegisterEmailViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/19/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var warningLbl: UILabel!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var mainVC: RegisterViewController?

//    var username: String?

//    class func create() -> RegisterEmailViewController {
//        let board = UIStoryboard(name: "Main", bundle: nil)
//        return board.instantiateViewController(withIdentifier: String(describing: self)) as! RegisterEmailViewController
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        emailTextField.borderStyle = .none
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        warningLbl.text = "请输入有效的Email。"
        
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
    
        imageView.isHidden = false
        if length == 0 {
            imageView.isHidden = true
        }
        
        if textField.text!.isValidateEmail() {
            UserManager.sharedInstance.findUser(key: LCConstants.UserKey.email, value: textField.text!) { (objects, error) in
                if error == nil {
                    if objects?.count == 0 {
                        self.imageView.image = UIImage(named: "ic_done_white")
                        self.imageView.backgroundColor = UIColor.green
                        self.warningLbl.isHidden = true
                        self.nextBtn.isEnabled = true
                    } else {
                        self.imageView.image = UIImage(named: "ic_error_white")
                        self.imageView.backgroundColor = UIColor.red
                        self.warningLbl.isHidden = false
                        self.warningLbl.text = "该Email账号已存在，请重新输入。"
                        self.nextBtn.isEnabled = false
                    }
                } else {
                    print(error?.localizedDescription)
                }
            }
        } else {
            imageView.image = UIImage(named: "ic_error_white")
            imageView.backgroundColor = UIColor.red
            warningLbl.isHidden = false
            warningLbl.text = "请输入有效的Email。"

            nextBtn.isEnabled = false
        }
    }
    
    // Hide/Dismiss keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewBottomConstraint.constant = 0
    }
    
    // Hide/Dismiss keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.toSetupPwdPage), object: nil, userInfo: ["email" : emailTextField.text!])
        self.mainVC?.email = self.emailTextField.text!
        mainVC?.emailRegister()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func switchToPhoneRegister(_ sender: UIButton) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.phoneRegister), object: nil)
        mainVC?.switchPages()
    }
}
