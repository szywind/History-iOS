//
//  MainViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!

    var sideMenuOpen = false
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(dismissSideMenu), name: NSNotification.Name(rawValue: Constants.Notification.toggleSideMenu), object: nil)
        
        setupGestureRecognizers()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @objc func toggleSideMenu() {
//        if sideMenuOpen {
//            sideMenuConstraint.constant = -280
//        } else {
//            sideMenuConstraint.constant = 0
//        }
//        sideMenuOpen = !sideMenuOpen
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }

    fileprivate func setupGestureRecognizers() {
        let dissmisSideMenuSelector = #selector(dismissSideMenu)
        let openSideMenuSelector = #selector(openSideMenu)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: dissmisSideMenuSelector)
        tapRecognizer.delegate = self
        mainView.addGestureRecognizer(tapRecognizer)
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: dissmisSideMenuSelector)
        swipeLeftRecognizer.direction = .left
        swipeLeftRecognizer.delegate = self
        view.addGestureRecognizer(swipeLeftRecognizer)
        
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: openSideMenuSelector)
        swipeRightRecognizer.direction = .right
        swipeRightRecognizer.delegate = self
        view.addGestureRecognizer(swipeRightRecognizer)
    }
    
    @objc func dismissSideMenu() {
        if sideMenuOpen {
            sideMenuConstraint.constant = -280
        }
        sideMenuOpen = !sideMenuOpen
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func openSideMenu() {
        if !sideMenuOpen {
            sideMenuConstraint.constant = 0
        }
        sideMenuOpen = !sideMenuOpen
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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

extension SideMenuViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
