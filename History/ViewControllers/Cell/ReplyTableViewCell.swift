//
//  ReplyTableViewCell.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var numStarLbl: UILabel!
    @IBOutlet weak var numSubscriberLbl: UILabel!
    @IBOutlet weak var numReply: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
