//
//  SectionHeaderView.swift
//  History
//
//  Created by Zhenyuan Shen on 3/31/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit


class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var dynastyTitleLbl: UILabel!
    
    var dynastyTitle: String! {
        didSet {
            dynastyTitleLbl.text = dynastyTitle
        }
    }
    
}
