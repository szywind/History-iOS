//
//  MenuEditProfileViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/29/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class MenuEditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var badge: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var addHintImageView: UIImageView!
        
    var imagePicker = UIImagePickerController()

    var nickname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveBtn
        
        avatar.layer.cornerRadius = avatar.frame.height / 2
//        avatar.layer.shadowColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
        
        nicknameTextField.borderStyle = .none
        
        imageView.isHidden = true
        warningLbl.isHidden = true
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onChangeImage))
        singleTap.numberOfTapsRequired = 1
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(singleTap)
        
        addHintImageView.isUserInteractionEnabled = true
        addHintImageView.addGestureRecognizer(singleTap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // https://stackoverflow.com/questions/31774006/how-to-get-height-of-keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        nickname = UserManager.sharedInstance.currentUser().object(forKey: LCConstants.UserKey.nickname) as? String
        nicknameTextField.text = nickname
        nicknameTextField.placeholder = nickname
        
        if let urlStr = UserManager.sharedInstance.currentUser().object(forKey: LCConstants.UserKey.avatarURL) as? String {
            let url = URL(string: urlStr.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                avatar.image = UIImage(data: data)
            }
        }
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

        let length = textField.text?.count ?? 0
        
        warningLbl.isHidden = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        imageView.isHidden = true
        
        if length > 0 {
            imageView.isHidden = false
            if length > Constants.Default.defaultUsernameLimit {
                imageView.image = UIImage(named: "ic_error_white")
                warningLbl.isHidden = false
                warningLbl.text = "注意：你的全名不能多于\(Constants.Default.defaultUsernameLimit)个字符。"
                
                //                imageView.tintColor = UIColor.white
                navigationItem.rightBarButtonItem?.isEnabled = false
                imageView.backgroundColor = UIColor.red
            } else {
                
                imageView.image = UIImage(named: "ic_done_white")
                //                imageView.tintColor = UIColor.white
                imageView.backgroundColor = UIColor.green
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
        nicknameTextField.resignFirstResponder()
        viewBottomConstraint.constant = 0
        return true
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        if !(nicknameTextField.text?.isEmpty)! {
            nickname = nicknameTextField.text
        }
        showProgressBar()
        UserManager.sharedInstance.saveUser(nickname: nickname!, image: avatar.image!){ (succeed, error) in
            self.hideProgressBar()
            if succeed {
                self.navigationController?.popViewController(animated: true)
//                self.dismiss(animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
        hideProgressBar()
    }
    
    @objc func onChangeImage(sender : AnyObject?) {
        let alert = UIAlertController(title: "更新照片", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "从相册选择", style: .default, handler: {
            (UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        alert.addAction(action)
        let action2 = UIAlertAction(title: "从相机拍摄", style: .default, handler: {
            (UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        alert.addAction(action2)
        let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action3)
        self.present(alert, animated:true, completion:nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatar.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
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
