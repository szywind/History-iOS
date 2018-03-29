//
//  CommunityArticleTableViewCell.swift
//  History
//
//  Created by 1 on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class CommunityArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

