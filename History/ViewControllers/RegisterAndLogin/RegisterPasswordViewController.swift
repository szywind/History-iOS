//
//  RegisterPasswordViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/19/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var warningLbl: UILabel!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var user: AVUser?
    
    var done = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pwdTextField.delegate = self
        pwdTextField.borderStyle = .none
        pwdTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)

        imageView.isHidden = true
        warningLbl.isHidden = true
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        warningLbl.text = "密码应至少有\(Constants.Default.defaultPasswordLimit)位数字，字母或符号。"
        
        doneBtn.isEnabled = false
        self.navigationItem.setHidesBackButton(true, animated: false)

//        let a = user?.username
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // https://stackoverflow.com/questions/31774006/how-to-get-height-of-keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        guard done else {
//            if let username = user?.username! {
//                let cql = "delete from _User where username='\(username)'"
//                AVQuery.doCloudQueryInBackground(withCQL: cql, callback: { (result, error) in
//                    if error == nil {
//                        print("Successfully delete user.")
//                    }
//                })
//            }
//            return
//        }
//    }
    
    
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
        
        warningLbl.isHidden = true
        doneBtn.isEnabled = false
        imageView.isHidden = true
        
        if length > 0 {
            imageView.isHidden = false
            if length < Constants.Default.defaultPasswordLimit {
                imageView.image = UIImage(named: "ic_error_white")
                warningLbl.isHidden = false
                imageView.backgroundColor = UIColor.red
            } else {
                imageView.image = UIImage(named: "ic_done_white")
                //                imageView.tintColor = UIColor.white
                imageView.backgroundColor = UIColor.green
                doneBtn.isEnabled = true
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
        pwdTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        self.showProgressBar()
        user?.password = pwdTextField.text!
        user?.setObject(true, forKey: "valid")
        user?.signUpInBackground({ (succeed, error) in
//        user?.saveInBackground({ (succeed, error) in
            self.hideProgressBar()
            if succeed {
                self.done = true
                self.dismiss(animated: true, completion: nil)
//                self.gotoMainPage()
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toRegister" {
//            if let destination = segue.destination as? RegisterPhoneViewController {
//                destination.username = nameTextField.text
//            }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func gotoMainPage() {
        self.performSegue(withIdentifier: "toMainPageTab", sender: self)
    }
}
