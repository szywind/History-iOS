//
//  EncyclopediaRecordTableViewCell.swift
//  History
//
//  Created by Cloudream on 13/03/2018.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class EncyclopediaRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var recordImage: UIImageView!
    @IBOutlet weak var recordLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
