//
//  CommunityDetailViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class CommunityDetailViewController: UIViewController {
    
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleLbl: UILabel!
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articleTextView.isEditable = false

        articleTextView.text = record?.info
        articleImageView.image = record?.avatar
        articleLbl.text = record?.name
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
