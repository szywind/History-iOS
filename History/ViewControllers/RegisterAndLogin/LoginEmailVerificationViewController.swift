//
//  LoginEmailVerificationViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/22/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class LoginEmailVerificationViewController: UIViewController {

    @IBOutlet weak var noteLbl: UILabel!
    
    var mainVC: LoginResetPasswordViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let email = mainVC?.user?.email
        noteLbl.text = "我们已经向\(email!)发送了一封邮件。点击邮件中的链接以重置你的密码。\n\n如果没有看到该邮件，请检查可能出现的其他位置，如垃圾邮件箱等"
        noteLbl.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func resendEmailLink(_ sender: UIButton) {
        mainVC?.emailVerify()
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
