//
//  SideMenuViewController.swift
//  slideout
//
//  Created by Zhenyuan Shen on 26/03/2018.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    var initCenter: CGPoint?
    var lasttranslation: CGFloat = 0.0
    
    var blackView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name(rawValue: Constants.Notification.toggleSideMenu), object: nil)
        sideMenuConstraint.constant = -260
        initCenter = panGestureRecognizer.view?.superview?.center
        print("initCenter: ", initCenter?.x, initCenter?.y)
        
        // https://stackoverflow.com/questions/3295061/uitapgesturerecognizer-is-overriding-uibutton-actions-on-scrollview/3372440#3372440
        tapGestureRecognizer.cancelsTouchesInView = false
//        setupTapGesture()
        
        blackView.backgroundColor = Constants.Color.bgColor
        containerView.addSubview(blackView)
        
        blackView.frame = CGRect(origin: CGPoint(x: containerView.frame.origin.x - 260, y: containerView.frame.origin.y), size: containerView.frame.size)
        blackView.alpha = 0
    }
    
//    func setupTapGesture() {
//        let dismissSideMenuSelector = #selector(self.dismissSideMenu)
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: dismissSideMenuSelector)
//        tapRecognizer.delegate = self
//        self.containerView.addGestureRecognizer(tapRecognizer)
//    }
    
    @IBAction func onTapPerformed(_ sender: UITapGestureRecognizer) {
        let pos = sender.location(in: self.view).x
//        let pos2 = sender.location(in: self.view.superview).x //  is 0
//        print("position.x is: ", pos, pos2)
        if pos > 260 {
            dismissSideMenu()
        }
    }
    
    // https://www.youtube.com/watch?v=ISxe1Fq-tTw&index=10&list=PLRD2R20xq-46XBsgacSi4FEhIlRyRpJGo
    // https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pan_gestures
    @IBAction func onPanPerformed(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view.superview).x
        let curCenter = panGestureRecognizer.view!.superview?.center
        print("curCenter: ", curCenter?.x, curCenter?.y)
        if sender.state == .began || sender.state == .changed {
            
            if translation > 0 { // swipe right
                let delta = (initCenter?.x)! - self.sideMenuConstraint.constant - ((curCenter?.x)! + translation)
                let alpha_ = 0.5 + 0.5 * delta / 260.0
                let x_new = min((curCenter?.x)! + translation, (initCenter?.x)! - self.sideMenuConstraint.constant)

                if (curCenter?.x)! < (initCenter?.x)! - self.sideMenuConstraint.constant {
                    lasttranslation = translation
                    self.containerView.isUserInteractionEnabled = false
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        //                        self.sideMenuConstraint.constant = min(self.sideMenuConstraint.constant + translation / 10, 0)
                        ////                        self.sideMenuConstraint.constant += translation / 5
                        
                        self.panGestureRecognizer.view!.superview?.center = CGPoint(x: x_new, y: (curCenter?.y)!)
                        self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
                        self.containerView.alpha = alpha_
                        
//                        self.blackView.frame.origin = CGPoint(x: 0, y: 0)
   
                        self.blackView.alpha = 1 - alpha_

                        self.view.layoutIfNeeded()

//                        print("r: ", alpha_)
                    })
                }
            } else if translation < 0 { // swipe left
                let delta = (curCenter?.x)! + translation - ((initCenter?.x)! - 260 - self.sideMenuConstraint.constant)
                let alpha_ = 1 - 0.5 * delta / 260.0
                let x_new = max((curCenter?.x)! + translation, (self.initCenter?.x)! - 260 - self.sideMenuConstraint.constant)

                if (curCenter?.x)! > (initCenter?.x)! - 260 - self.sideMenuConstraint.constant {
                    lasttranslation = translation
                    self.containerView.isUserInteractionEnabled = false

                    UIView.animate(withDuration: 0.1, animations: {
                        //                        self.sideMenuConstraint.constant = min(self.sideMenuConstraint.constant + translation / 10, 0)
                        ////                        self.sideMenuConstraint.constant += translation / 5
                        self.panGestureRecognizer.view?.superview?.center = CGPoint(x: x_new, y: (curCenter?.y)!)
                        self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
                        self.containerView.alpha = alpha_
                        self.blackView.alpha = 1 - alpha_

                        self.view.layoutIfNeeded()

//                        print("l: ", alpha_)
                    })
                    
                }
            }
        } else if sender.state == .ended {
            
            //            if sideMenuConstraint.constant < -200 {
            //                UIView.animate(withDuration: 0.2, animations: {
            //                    self.sideMenuConstraint.constant = -260
            //                    self.view.layoutIfNeeded()
            //                })
            //            } else {
            //                UIView.animate(withDuration: 0.2, animations: {
            //                    self.sideMenuConstraint.constant = 0
            //                    self.view.layoutIfNeeded()
            //                })
            //            }
            
            
            if lasttranslation > 0 { // swipe right
                showSideMenu()
            } else { // swipe left
                dismissSideMenu()
            }
            
            lasttranslation = 0

            self.panGestureRecognizer.view?.superview!.center = self.initCenter!
            self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func toggleSideMenu() {
        if sideMenuConstraint.constant < 0 {
            showSideMenu()
        } else {
            dismissSideMenu()
        }
        print("show side menu")
    }
    
    @objc func dismissSideMenu() {
        UIView.animate(withDuration: 0, animations: {
            //                    self.panGestureRecognizer.view?.superview!.center = self.initCenter!
            //                    self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
            self.sideMenuConstraint.constant = -260
            //                    self.panGestureRecognizer.view?.superview!.center.x = (self.initCenter?.x)!
            self.containerView.alpha = 1
            self.containerView.isUserInteractionEnabled = true
            
            self.blackView.frame.origin = CGPoint(x: 0, y: 0)
            self.blackView.alpha = 0
            
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func showSideMenu() {
        UIView.animate(withDuration: 0, animations: {
            //                    self.panGestureRecognizer.view?.superview!.center = CGPoint(x: (self.initCenter?.x)! + 260, y: (self.initCenter?.y)!)
            //                    self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view.superview)
            self.sideMenuConstraint.constant = 0
            //                    self.panGestureRecognizer.view?.superview!.center.x = (self.initCenter?.x)! + 260
            self.containerView.alpha = 0.5
            self.containerView.isUserInteractionEnabled = false
            
            self.blackView.frame.origin = CGPoint(x: 260, y: 0)
            self.blackView.alpha = 0.5
            self.view.layoutIfNeeded()
        })
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

