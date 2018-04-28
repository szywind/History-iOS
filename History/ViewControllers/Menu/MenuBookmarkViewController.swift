//
//  MenuBookmarkViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/27/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio

class MenuBookmarkViewController: BaseMenuViewController {

    fileprivate var viewControllers = [MenuBookmarkTableViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupViewControllers() {
        viewControllers.removeAll()
        let postController = MenuBookmarkTableViewController.create()
        let replyController = MenuBookmarkTableViewController.create()
        let likeController = MenuBookmarkTableViewController.create()
        
        viewControllers.append(postController)
        viewControllers.append(replyController)
        viewControllers.append(likeController)
        
        segmentioContent = [
            SegmentioItem(title: "发帖", image: nil),
            SegmentioItem(title: "回帖", image: nil),
            SegmentioItem(title: "喜欢", image: nil)
        ]
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
