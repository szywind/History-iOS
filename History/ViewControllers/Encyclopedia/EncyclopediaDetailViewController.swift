//
//  EncyclopediaDetailViewController.swift
//  History
//
//  Created by 1 on 3/18/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class EncyclopediaDetailViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var recordImageView: UIImageView!
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        infoTextView.text = record?.info
        recordImageView.image = record?.avatar
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
