//
//  RegisterHomeViewController.swift
//  History
//
//  Created by 1 on 4/17/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterHomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var warningLbl: UILabel!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var inputNickname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        nameTextField.borderStyle = .none
        
        imageView.isHidden = true
        warningLbl.isHidden = true
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        warningLbl.text = "注意：你的全名不能多于\(Constants.Default.defaultUsernameLimit)个字符。"
        
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
        inputNickname = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        let length = inputNickname?.count ?? 0
        
        warningLbl.isHidden = true
        nextBtn.isEnabled = false
        imageView.isHidden = true
        
        if length > 0 {
            imageView.isHidden = false
            if length > Constants.Default.defaultUsernameLimit {
                imageView.image = UIImage(named: "ic_error_white")
                warningLbl.isHidden = false
                warningLbl.text = "注意：你的全名不能多于\(Constants.Default.defaultUsernameLimit)个字符。"

//                imageView.tintColor = UIColor.white
                imageView.backgroundColor = UIColor.red
            } else {
                
                imageView.image = UIImage(named: "ic_done_white")
//                imageView.tintColor = UIColor.white
                imageView.backgroundColor = UIColor.green
                nextBtn.isEnabled = true
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
        nameTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    @IBAction func onNextTapped(_ sender: UIButton) {
        nameTextField.text = inputNickname
        performSegue(withIdentifier: "toRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegister" {
            if let destination = segue.destination as? RegisterViewController {
                let user = AVUser()
                user.setObject(inputNickname, forKey: "nickname")
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

}
