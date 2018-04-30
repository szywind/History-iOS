//
//  BaseMenuViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/27/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio

class BaseMenuViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nicknameLbl: UILabel!
    
    var segmentioStyle = SegmentioStyle.onlyLabel
    var segmentioContent = [SegmentioItem]()
//    fileprivate var viewControllers = [UIViewController]()

    var initCenter: CGPoint?
    var HEIGHT: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
//        let cancelBtn = UIBarButtonItem(image: UIImage(named: "ic_keyboard_arrow_left"), style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        avatar.layer.cornerRadius = avatar.frame.height / 2
//        avatar.layer.shadowColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
        
        HEIGHT = headerView.frame.height - (navigationController?.navigationBar.frame.height)!
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nicknameLbl.text = UserManager.sharedInstance.currentUser().object(forKey: LCConstants.UserKey.nickname) as? String

        if let urlStr = UserManager.sharedInstance.currentUser().object(forKey: LCConstants.UserKey.avatarURL) as? String {
            let url = URL(string: urlStr.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                avatar.image = UIImage(data: data)
            }
        }
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setupNavBar()
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        resetNavBar()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    func initUI() {
        setupNavBar()
        
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
//        viewControllers.removeAll()
//        segmentioContent = []
    }
    
    func selectedSegmentioIndex() -> Int {
        return 0
    }
    
    // MARK: - Setup container view
    func setupScrollView() {
//        scrollView.contentSize = CGSize(
//            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
//            height: containerView.frame.height
//        )
//        
//        for (index, viewController) in viewControllers.enumerated() {
//            viewController.view.frame = CGRect(
//                x: UIScreen.main.bounds.width * CGFloat(index),
//                y: 0,
//                width: scrollView.frame.width,
//                height: scrollView.frame.height
//            )
//            addChildViewController(viewController)
//            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
//            viewController.didMove(toParentViewController: self)
//        }
    }
    
    // MARK: - Actions
    
    func goToControllerAtIndex(_ index: Int) {
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

extension BaseMenuViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}
