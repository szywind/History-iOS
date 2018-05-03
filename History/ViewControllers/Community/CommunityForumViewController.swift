//
//  CommunityForumViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/31/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio
import CoreData
import AVOSCloud

enum PostCellType {
    case latest
    case hot
    case best
}

class CommunityForumViewController: UIViewController {
    
//    var topic: String! {
//        didSet {
//            setupPosts()
//            refreshUI()
//        }
//    }
    
    var topic: String?
    var segmentioStyle = SegmentioStyle.onlyLabel
    var segmentioContent = [SegmentioItem]()
    var posts = [AVObject]()
    
    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate var viewControllers = [CommunityTableViewController]()
    
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshUI), name: NSNotification.Name(rawValue: Constants.Notification.refreshUI), object: nil)
        
        self.segmentioView.isHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
  
    // https://stackoverflow.com/questions/39511088/navigationbar-coloring-in-viewwillappear-happens-too-late-in-ios-10
//    override func willMove(toParentViewController parent: UIViewController?) {
//        super.willMove(toParentViewController: parent)
//        self.navigationController?.navigationBar.isTranslucent = false
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        resetNavBar()
//    }
    
    func setupData() {
        PostManager.sharedInstance.fetchPostFromLC(forKey: LCConstants.PostKey.subtopic, value: topic!, withBlock: { (objects, error) in
            if error == nil && (objects?.count)! > 0 {
                self.posts.removeAll()
                for object in objects! {
                    self.posts.append(object as! AVObject)
                }
                self.segmentioView.isHidden = false
                self.refreshUI()
            } else {
                self.segmentioView.isHidden = true
                print(error?.localizedDescription)
            }
        })
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
        let latestController = CommunityTableViewController.create()
        latestController.posts = posts
        latestController.type = .latest
        print("latest posts", latestController.posts.count)
        
        let hotController = CommunityTableViewController.create()
        hotController.posts = posts
        hotController.type = .hot
        print("hottest posts", hotController.posts.count)
        
        let bestController = CommunityTableViewController.create()
        bestController.posts = posts
        bestController.type = .best
        print("best posts", bestController.posts.count)
        
        viewControllers.append(latestController)
        viewControllers.append(hotController)
        viewControllers.append(bestController)

        
        segmentioContent = [
            SegmentioItem(title: "最新发布", image: nil),
            SegmentioItem(title: "最多回复", image: nil),
            SegmentioItem(title: "最多喜欢", image: nil)
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
    
    func setupPosts() {
        
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

extension CommunityForumViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}

