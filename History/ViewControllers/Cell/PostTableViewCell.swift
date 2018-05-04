//
//  PostTableViewCell.swift
//  History
//
//  Created by Zhenyuan Shen on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var numStarLbl: UILabel!
    @IBOutlet weak var numSubscriberLbl: UILabel!
    @IBOutlet weak var numReply: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        topicLbl.adjustsFontSizeToFitWidth = true
        topicLbl.numberOfLines = 3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

