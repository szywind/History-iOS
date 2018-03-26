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

class CommunityViewController: UIViewController, UISearchBarDelegate {
    
    var segmentioStyle = SegmentioStyle.imageUnderLabel
    var segmentioContent = [SegmentioItem]()
    var searchActive = false
    var isSearching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate var viewControllers = [CommunityContentViewController]()
    
    var filteredRecords = [Record]()
    
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
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
        
        setupSearchBar()
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
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        //        self.view.addGestureRecognizer(tap)
    }
    
    func setupViewControllers() {
        viewControllers.removeAll()
        if isSearching {
            let filteredController = CommunityContentViewController.create()
            filteredController.records = filteredRecords
            print("filtered records", filteredController.records.count)
            viewControllers.append(filteredController)
            segmentioContent = [
                SegmentioItem(title: "搜索结果", image: UIImage(named: "tornado"))
            ]
        } else {
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
    
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRecords.removeAll()
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            filteredRecords += LocalDataManager.sharedInstance.allPeople.filter({$0.name?.range(of:searchBar.text!) != nil})
            filteredRecords += LocalDataManager.sharedInstance.allEvents.filter({$0.name?.range(of:searchBar.text!) != nil})
        }
        refreshUI()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        refreshUI()
        dismissKeyboard()
    }
    //    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    //        searchActive = true;
    //        searchBar.setShowsCancelButton(true, animated: true)
    //    }
    //
    //    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    //        if(searchBar.text == "") {
    //            searchVar = searchVarDefault
    //            self.performSearch()
    //            showFoodType()
    //        }
    //        searchActive = false;
    //        searchBar.endEditing(true)
    //        searchBar.setShowsCancelButton(false, animated: true)
    //    }
    //
    //    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    //        searchBar.text = ""
    //        showFoodType()
    //        searchActive = false;
    //        searchBar.endEditing(true)
    //    }
    //
    //    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    //        searchVar = searchBar.text!.trimAndLowercase()
    //        self.performSearch()
    //        searchActive = false;
    //        searchBar.endEditing(true)
    //    }
    
    
    
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
