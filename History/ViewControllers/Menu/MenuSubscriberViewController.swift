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

    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var followers = [AVUser]()
    var followees = [AVUser]()

    var viewControllers = [MenuSubscriberTableViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initCenter = panGestureRecognizer.view?.superview?.center
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
    
    @IBAction func onPanPerformed(_ sender: UIPanGestureRecognizer) {
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
