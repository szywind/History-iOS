 //
//  EncyclopediaDetailViewController.swift
//  History
//
//  Created by 1 on 3/18/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Kingfisher
 
class EncyclopediaDetailViewController: UIViewController {

    @IBOutlet weak var recordTextView: UITextView!
    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var recordLbl: UILabel!
    
    @IBOutlet weak var recordTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordImageViewHeightConstraint: NSLayoutConstraint!
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recordTextView.isEditable = false

        recordTextView.text = record?.infoURL?.getText()
        recordTextView.isScrollEnabled = false
        
        // adjust the height of image view to the content
//        recordImageViewHeightConstraint.constant = (record?.avatar?.size.height)! * recordImageView.frame.width / (record?.avatar?.size.width)!
        
        // adjust the height of text view to the content
        let fixedWidth = recordTextView.frame.size.width
        let newSize = recordTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let lineHeight = recordTextView.font?.lineHeight
        recordTextViewHeightConstraint.constant = newSize.height + 5 * lineHeight!
        
        
//        recordImageView.image = record?.avatarURL?.getUIImage()
        recordImageView.kf.setImage(with: URL(string: (record?.avatarURL!)!),
                                      placeholder: UIImage(named: Constants.Default.defaultAvatar)!)
        recordLbl.text = record?.name
        
        addNavBarMask()
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
