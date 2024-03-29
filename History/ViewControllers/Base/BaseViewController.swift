//
//  BaseViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let menuBtn = UIBarButtonItem(image: UIImage(named: "ic_account_circle"), style: .plain, target: self, action: #selector(toggleSideMenu))
        self.navigationItem.leftBarButtonItem = menuBtn

        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO
        
//        navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "ic_account_circle"), for: .normal, barMetrics: .defaultPrompt)
//
//        if UserManager.sharedInstance.isLogin() {
//            if let urlStr = UserManager.sharedInstance.currentUser().object(forKey: LCConstants.UserKey.avatarURL) as? String {
//                let url = URL(string: urlStr.convertToHttps())
//                if let data = try? Data(contentsOf: url!) {
//                    navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(data: data), for: .normal, barMetrics: .defaultPrompt)
//                }
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func toggleSideMenu() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.toggleSideMenu), object: nil)
    }
    
    func initUI() {
        setupNavBar()
        
        let borderColor = UITableView().separatorColor?.cgColor
        
//        self.view.layer.borderWidth = 0.5
//        self.view.layer.borderColor = borderColor
        
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        
        self.tabBarController?.tabBar.layer.borderWidth = 0.5
        self.tabBarController?.tabBar.layer.borderColor = borderColor
        self.tabBarController?.tabBar.backgroundColor = UIColor.clear
        self.tabBarController?.tabBar.clipsToBounds = true
        
        addNavBarMask()
    }
    
//    func createView() {
//    }
//    
//    // https://stackoverflow.com/questions/37805885/how-to-create-dispatch-queue-in-swift-3
//    func refreshUI() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            // Bounce back to the main thread to update the UI
//            DispatchQueue.main.async {
//                self.createView()
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

}
