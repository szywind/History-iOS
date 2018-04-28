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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
