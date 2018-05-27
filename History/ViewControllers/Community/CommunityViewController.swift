//
//  CommunityViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio
import CoreData
import AVOSCloud

class CommunityViewController: UIViewController {
    
    var segmentioStyle = SegmentioStyle.imageUnderLabel
    var segmentioContent = [SegmentioItem]()
    
    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate var viewControllers = [CommunityContentViewController]()
    
    // MARK: - Init
    
    class func create() -> CommunityViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! CommunityViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 35
            break
        case .onlyImage:
            segmentViewHeightConstraint.constant = 50
            break
        case .imageUnderLabel, .imageOverLabel:
            segmentViewHeightConstraint.constant = 85
            break
        default:
            break
        }
        
        if UserManager.sharedInstance.isLogin() {
            State.currentSubscribeTopics.removeAll()
            State.currentSubscribeTopics = Set(UserManager.sharedInstance.getSubscribeTopics()!)
        } else {
            State.currentSubscribeTopics.removeAll()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshUI), name: NSNotification.Name(rawValue: Constants.Notification.refreshUI), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshUI() {
        setupViewControllers()
        setupScrollView()
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle,
            segmentioContent: segmentioContent
        )
        //        SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: 1)
        
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
        }
    }
    
    
    func setupViewControllers() {
        viewControllers.removeAll()
        segmentioContent = []
        if UserManager.sharedInstance.isLogin() {
            let subscribeController = CommunityContentViewController.create()
            subscribeController.topics = LocalDataManager.sharedInstance.getFollowingTopics()
            viewControllers.append(subscribeController)
            segmentioContent.append(SegmentioItem(title: "关注", image: nil))
        }
        
        LocalDataManager.sharedInstance.sort()
        
        let peopleController = CommunityContentViewController.create()
        peopleController.topics = LocalDataManager.sharedInstance.allPeople
        print("person records", peopleController.topics.count)
            
//        let allController = CommunityContentViewController.create()
//        allController.topics = LocalDataManager.sharedInstance.allEvents
//        print("all records", allController.topics.count)
        
        let eventController = CommunityContentViewController.create()
        eventController.topics = LocalDataManager.sharedInstance.events
        print("event records", eventController.topics.count)
            
        let geoController = CommunityContentViewController.create()
        geoController.topics = LocalDataManager.sharedInstance.geo
        print("geo records", geoController.topics.count)
            
        let artController = CommunityContentViewController.create()
        artController.topics = LocalDataManager.sharedInstance.art
        print("art records", artController.topics.count)
            
        let techController = CommunityContentViewController.create()
        techController.topics = LocalDataManager.sharedInstance.tech
        print("tech records", techController.topics.count)
        
        viewControllers.append(peopleController)
//        viewControllers.append(allController)
        viewControllers.append(eventController)
        viewControllers.append(geoController)
        viewControllers.append(artController)
        viewControllers.append(techController)
            
        segmentioContent.append(contentsOf: [
//            SegmentioItem(title: "关注", image: nil),
            SegmentioItem(title: "人物", image: nil),
//            SegmentioItem(title: "全部", image: nil),
            SegmentioItem(title: "事件", image: nil),
            SegmentioItem(title: "地理", image: nil),
            SegmentioItem(title: "艺术", image: nil),
            SegmentioItem(title: "科技", image: nil)
        ])
    }
    
    fileprivate func selectedSegmentioIndex() -> Int {
        return 0
    }
    
    // MARK: - Setup container view
    
    fileprivate func setupScrollView() {
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
    
    // MARK: - Actions
    
    fileprivate func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
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

extension CommunityViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}

//extension CommunityViewController:  UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if touch.view?.isDescendant(of: auto) {
//            return false
//        }
//        return true
//    }
//}
