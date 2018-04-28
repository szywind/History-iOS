//
//  MenuSubscriberViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/27/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio
import AVOSCloud

class MenuSubscriberViewController: BaseMenuViewController {

    var followers = [AVUser]()
    var followees = [AVUser]()

    var viewControllers = [MenuSubscriberTableViewController]()
    
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
        let followerController = MenuSubscriberTableViewController.create()
        followerController.records = LocalDataManager.sharedInstance.allPeople
        
        let followeeController = MenuSubscriberTableViewController.create()
        let celebController = MenuSubscriberTableViewController.create()
        let recomController = MenuSubscriberTableViewController.create()

        
        viewControllers.append(followerController)
        viewControllers.append(followeeController)
        viewControllers.append(celebController)
        viewControllers.append(recomController)
        
        segmentioContent = [
            SegmentioItem(title: "关注者", image: nil),
            SegmentioItem(title: "正在关注", image: nil),
            SegmentioItem(title: "最热用户", image: nil),
            SegmentioItem(title: "可能喜欢", image: nil)
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
