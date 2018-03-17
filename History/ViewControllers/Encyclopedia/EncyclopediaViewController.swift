//
//  EncyclopediaViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio
import CoreData
import LeanCloud

class EncyclopediaViewController: UIViewController, UISearchBarDelegate {

    var segmentioStyle = SegmentioStyle.imageUnderLabel
    var searchActive : Bool = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
//    var people = [Person]()
//    var events = [Event]()
    
//    fileprivate lazy var viewControllers: [ContentViewController] = {
//        return self.preparedViewControllers()
//    }()
    
    fileprivate var viewControllers = [ContentViewController]()
    
    // MARK: - Init
    
    class func create() -> EncyclopediaViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! EncyclopediaViewController
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
        
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PersonManager.sharedInstance.fetchAllPeople(withBlock: didFetchPerson)
    }
    
    func refresh() {
        setupScrollView()
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
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
    
    
    func didFetchPerson(result: LCQueryResult<LCObject>) {
        let peopleController = ContentViewController.create()
        peopleController.records = Record.getRecords(people: CoreDataManager.fetchAllPeople())
        print("person records", peopleController.records.count)

        viewControllers.append(peopleController)
        EventManager.sharedInstance.fetchAllEvent(withBlock: didFetchEvent)
    }
    
    func didFetchEvent(result: LCQueryResult<LCObject>) {
        let eventController = ContentViewController.create()
        eventController.records = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "event", format: Constants.CoreData.eventTypeFilterFormat))
        print("event records", eventController.records.count)
        
        let geoController = ContentViewController.create()
        geoController.records = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "geography", format: Constants.CoreData.eventTypeFilterFormat))
        print("geo records", geoController.records.count)

        let artController = ContentViewController.create()
        artController.records = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "art", format: Constants.CoreData.eventTypeFilterFormat))
        print("art records", artController.records.count)

        let techController = ContentViewController.create()
        techController.records = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "technology", format: Constants.CoreData.eventTypeFilterFormat))
        print("tech records", techController.records.count)

        let allController = ContentViewController.create()
        allController.records = Record.getRecords(events: CoreDataManager.fetchAllEvents())
        print("all records", allController.records.count)

        viewControllers.append(eventController)
        viewControllers.append(geoController)
        viewControllers.append(artController)
        viewControllers.append(techController)
        viewControllers.append(allController)
        
        refresh()
    }
    
    // Example viewControllers
    
//    fileprivate func preparedViewControllers() -> [ContentViewController] {
//        PersonManager.sharedInstance.fetchAllPeople(withBlock: didFetchPerson)
//        EventManager.sharedInstance.fetchAllEvent(withBlock: didFetchEvent)
//
//
//
//
//
//        return [
//            peopleController,
//            eventController,
//            geoController,
//            artController,
//            techController,
//            allController
//        ]
//    }
    
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
//
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        searchVar = searchText.trimAndLowercase()
//        self.performSearch()
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

extension EncyclopediaViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}

