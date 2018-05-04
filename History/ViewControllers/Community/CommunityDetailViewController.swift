//
//  CommunityDetailViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class CommunityDetailViewController: UIViewController {
    
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleLbl: UILabel!
    
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var articleImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var articleTextViewHeightConstraint: NSLayoutConstraint!
    var post: AVObject?
    var user: AVUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articleTextView.isEditable = false

        articleTextView.text = PostManager.sharedInstance.getText(post: post!)
        articleTextView.isScrollEnabled = false
        
        // https://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        // https://stackoverflow.com/questions/28389913/resize-textfield-based-on-content
        // var height = articleTextView.contentSize.height // not work since height is 300
        let fixedWidth = articleTextView.frame.size.width
        let newSize = articleTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let lineHeight = articleTextView.font?.lineHeight
        
        articleTextViewHeightConstraint.constant = newSize.height + 2 * lineHeight!
        
        if let image = PostManager.sharedInstance.getImage(post: post!) {
            articleImageView.image = image
        } else {
            articleImageHeightConstraint.constant = 0
        }
        
        articleLbl.text = PostManager.sharedInstance.getTitle(post: post!)
        articleLbl.adjustsFontSizeToFitWidth = true
        articleLbl.numberOfLines = 3
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.image = UserManager.sharedInstance.getAvatar(user: user)
        
        authorLbl.text = UserManager.sharedInstance.getNickname(user: user)
        
        addNavBarMask()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if (self.navigationController?.navigationBar.isTranslucent)! {
//            self.navigationController?.navigationBar.isTranslucent = false
//        }
//    }
//
//    override func willMove(toParentViewController parent: UIViewController?) {
//        super.willMove(toParentViewController: parent)
//        if String(describing: parent) == "CommunityForumViewController" {
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.navigationController?.navigationBar.isTranslucent = true
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
