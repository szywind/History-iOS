//
//  LoginViewController.swift
//  History
//
//  Created by 1 on 3/8/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onConfirmTapped(_ sender: Any) {
        let alert = UIAlertController(title: "确认手机号", message: phone.text! + "\n我们将发送短信到上面的手机号", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let confirm = UIAlertAction(title: "确认", style: .default) { (action) in
            self.performSegue(withIdentifier: "toEnterVerificationCode", sender: self)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
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
