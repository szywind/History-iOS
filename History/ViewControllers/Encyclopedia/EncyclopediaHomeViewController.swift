//
//  EncyclopediaHomeViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio

class EncyclopediaHomeViewController: BaseViewController {

    fileprivate var currentStyle = SegmentioStyle.onlyLabel
    fileprivate var containerViewController: EncyclopediaEmbedContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: EncyclopediaEmbedContainerViewController.self) {
            containerViewController = segue.destination as? EncyclopediaEmbedContainerViewController
            containerViewController?.style = currentStyle
        }
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
