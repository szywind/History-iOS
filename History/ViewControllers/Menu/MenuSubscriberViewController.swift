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

enum UserCellType {
    case follower
    case followee
    case celeb
    case recommendation
}

class MenuSubscriberViewController: BaseMenuViewController {

    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var users = [AVUser]()
    var followeeIds = Set<String>()
    
    var viewControllers = [MenuSubscriberTableViewController]()
    
    override func viewDidLoad() {
        setupData()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initCenter = panGestureRecognizer.view?.superview?.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupViewControllers() {
        self.viewControllers.removeAll()
        let followerController = MenuSubscriberTableViewController.create()
        followerController.type = .follower
        followerController.users = users
//        followerController.followees = followeeIds
        followerController.mainVC = self
        
        //        followerController.records = LocalDataManager.sharedInstance.allPeople
        //        followerController.users = hotusers
            
        let followeeController = MenuSubscriberTableViewController.create()
        followeeController.type = .followee
        followeeController.users = users
//        followeeController.followees = followeeIds
        followeeController.mainVC = self
        
        let celebController = MenuSubscriberTableViewController.create()
        celebController.type = .celeb
        celebController.users = users
//        celebController.followees = followeeIds
        celebController.mainVC = self
        
        let recomController = MenuSubscriberTableViewController.create()
        recomController.type = .recommendation
        recomController.users = users
//        recomController.followees = followeeIds
        recomController.mainVC = self
        
        self.viewControllers.append(followerController)
        self.viewControllers.append(followeeController)
        self.viewControllers.append(celebController)
        self.viewControllers.append(recomController)
            
        self.segmentioContent = [
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
    
    func setupData() {
        followeeIds.removeAll()
        users = [AVUser]()
        FollowManager.sharedInstance.getAllFollowees { (objects, error) in
            if error == nil && (objects?.count)! > 0 {
                for object in objects!{
                    let user = object as! AVUser
                    //                    let bar = UserManager.sharedInstance.getNickname(user: foo)
                    self.users.append(user)
                    self.followeeIds.insert(user.objectId!)
                }
            }
            self.refreshUI()
        }
    }
    
    @IBAction func onPanPerformed(_ sender: UIPanGestureRecognizer) {
        return
        let translation = sender.translation(in: self.view.superview).y
        let curCenter = panGestureRecognizer.view!.superview?.center
        print("curCenter: ", curCenter?.x, curCenter?.y)
        if sender.state == .began || sender.state == .changed {
            if translation > 0 { // pull down
                let y_new = min((curCenter?.y)! + translation, (initCenter?.y)!)

                if (curCenter?.y)! < (initCenter?.y)! {
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.panGestureRecognizer.view!.superview?.center = CGPoint(x: (curCenter?.x)!, y: y_new)
                        self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
                        
                        self.view.layoutIfNeeded()
                    })
                }
            } else if translation < 0 { // pull up
                let y_new = max((curCenter?.y)! + translation, (self.initCenter?.y)! - HEIGHT)
                
                if (curCenter?.y)! > (initCenter?.y)! - HEIGHT {
                    UIView.animate(withDuration: 0.1, animations: {

                        self.panGestureRecognizer.view?.superview?.center = CGPoint(x: (curCenter?.x)!, y: y_new)
                        self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
                        
                        self.view.layoutIfNeeded()
                    })
                    
                }
            }
        } else if sender.state == .ended {
            
            //            if sideMenuLeadingConstraint.constant < -200 {
            //                UIView.animate(withDuration: 0.2, animations: {
            //                    self.sideMenuLeadingConstraint.constant = - WIDTH
            //                    self.view.layoutIfNeeded()
            //                })
            //            } else {
            //                UIView.animate(withDuration: 0.2, animations: {
            //                    self.sideMenuLeadingConstraint.constant = 0
            //                    self.view.layoutIfNeeded()
            //                })
            //            }
            
            self.panGestureRecognizer.view?.superview!.center = self.initCenter!
            self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
        }
    }
}
