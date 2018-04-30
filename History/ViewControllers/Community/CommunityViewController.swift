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
        
        refreshUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshUI), name: NSNotification.Name(rawValue: Constants.Notification.refreshUI), object: nil)
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
        let peopleController = CommunityContentViewController.create()
        peopleController.records = LocalDataManager.sharedInstance.allPeople
        print("person records", peopleController.records.count)
            
        let allController = CommunityContentViewController.create()
        allController.records = LocalDataManager.sharedInstance.allEvents
        print("all records", allController.records.count)
            
        let eventController = CommunityContentViewController.create()
        eventController.records = LocalDataManager.sharedInstance.events
        print("event records", eventController.records.count)
            
        let geoController = CommunityContentViewController.create()
        geoController.records = LocalDataManager.sharedInstance.geo
        print("geo records", geoController.records.count)
            
        let artController = CommunityContentViewController.create()
        artController.records = LocalDataManager.sharedInstance.art
        print("art records", artController.records.count)
            
        let techController = CommunityContentViewController.create()
        techController.records = LocalDataManager.sharedInstance.tech
        print("tech records", techController.records.count)
            
        viewControllers.append(peopleController)
        viewControllers.append(allController)
        viewControllers.append(eventController)
        viewControllers.append(geoController)
        viewControllers.append(artController)
        viewControllers.append(techController)
            
        segmentioContent = [
            SegmentioItem(title: "人物", image: UIImage(named: "tornado")),
            SegmentioItem(title: "全部", image: UIImage(named: "earthquakes")),
            SegmentioItem(title: "事件", image: UIImage(named: "heat")),
            SegmentioItem(title: "地理", image: UIImage(named: "eruption")),
            SegmentioItem(title: "艺术", image: UIImage(named: "floods")),
            SegmentioItem(title: "科技", image: UIImage(named: "wildfires"))
        ]
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
