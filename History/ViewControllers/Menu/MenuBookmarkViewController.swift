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

    var viewControllers = [MenuBookmarkTableViewController]()
    
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
        postController.records = LocalDataManager.sharedInstance.allPeople

        let replyController = MenuBookmarkTableViewController.create()
        let likeController = MenuBookmarkTableViewController.create()
        let bookmarkController = MenuBookmarkTableViewController.create()
        
        viewControllers.append(postController)
        viewControllers.append(replyController)
        viewControllers.append(likeController)
        viewControllers.append(bookmarkController)
        
        segmentioContent = [
            SegmentioItem(title: "发帖", image: nil),
            SegmentioItem(title: "回帖", image: nil),
            SegmentioItem(title: "喜欢", image: nil),
            SegmentioItem(title: "收藏", image: nil)
        ]
    }
    
    // MARK: - Setup container view
    override func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height
        )
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            addChildViewController(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParentViewController: self)
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
