//
//  MenuViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/27/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var usernameHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuTableView: UITableView!
    
    let titles = [["信息", "关注", "书签", "知识库"], ["设置和隐私", "关于我们"]]
    let icons = [["ic_person_outline", "ic_people_outline", "ic_bookmark_border", "ic_star_border"], ["ic_settings", "ic_help_outline"]]
    let segues = [["toProfile", "toSubscriber", "toBookmark", "toLibrary"], ["toSettings", "toInfo"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let borderColor = UITableView().separatorColor?.cgColor
//        bottomView.layer.borderWidth = 0.5
//        bottomView.layer.borderColor = borderColor
        
        self.navigationController?.navigationBar.isHidden = true
        
        signUpBtn.layer.borderWidth = 1
        signUpBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signUpBtn.isHidden = UserManager.sharedInstance.isLogin()
        if UserManager.sharedInstance.isLogin() {
            usernameHeightConstraint.constant = 40
        } else {
            usernameHeightConstraint.constant = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuTableViewCell
        cell.menuLbl.text = titles[indexPath.section][indexPath.row]
        cell.menuIcon.image = UIImage(named: icons[indexPath.section][indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        performSegue(withIdentifier: segues[indexPath.section][indexPath.row], sender: self)
    }
    
    // https://stackoverflow.com/questions/31693901/design-uitableviews-section-header-in-interface-builder
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = menuTableView.dequeueReusableCell(withIdentifier: "header")
        header?.backgroundColor = Constants.Color.naviBarTint // UITableView().separatorColor
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
