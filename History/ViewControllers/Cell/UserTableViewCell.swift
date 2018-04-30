//
//  UserTableViewCell.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followBtnWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = Constants.Color.naviBarTint.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
