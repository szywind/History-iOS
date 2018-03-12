//
//  EncyclopediaViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio

class EncyclopediaViewController: UIViewController {

    var segmentioStyle = SegmentioStyle.imageUnderLabel
    
    @IBOutlet fileprivate weak var segmentViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    // Example viewControllers
    
    fileprivate func preparedViewControllers() -> [ContentViewController] {
        let tornadoController = ContentViewController.create()
        
        let earthquakesController = ContentViewController.create()

        
        let extremeHeatController = ContentViewController.create()

        
        let eruptionController = ContentViewController.create()

        
        let floodsController = ContentViewController.create()

        
        let wildfiresController = ContentViewController.create()

        
        return [
            tornadoController,
            earthquakesController,
            extremeHeatController,
            eruptionController,
            floodsController,
            wildfiresController
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

extension EncyclopediaViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}

