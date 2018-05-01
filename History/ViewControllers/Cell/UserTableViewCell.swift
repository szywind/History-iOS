//
//  UserTableViewCell.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followBtnWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var unfollowBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
        unfollowBtn.layer.borderWidth = 1
        unfollowBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    @IBAction func onFollowTapped(_ sender: UIButton) {
//        AVUser.current()?.follow((user?.objectId)!, andCallback: { (succeed, error) in
//            if succeed {
//                print("succeed")
//            } else {
//                print(error?.localizedDescription)
//            }
//        })
//    }
//
//    @IBAction func onUnfollowTapped(_ sender: UIButton) {
//        AVUser.current()?.unfollow((user?.objectId)!, andCallback: { (succeed, error) in
//            if succeed {
//                print("succeed")
//            } else {
//                print(error?.localizedDescription)
//            }
//        })
//    }
}
