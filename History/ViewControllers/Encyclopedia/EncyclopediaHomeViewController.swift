//
//  EncyclopediaHomeViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Segmentio

class EncyclopediaHomeViewController: UIViewController, UISearchBarDelegate {

    fileprivate var currentStyle = SegmentioStyle.onlyLabel
    fileprivate var containerViewController: EmbedContainerViewController?
    
    var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = Constants.Color.naviBarTint
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
//        searchBar.showsCancelButton = false
//        searchBar.placeholder = "请输入要搜索的词条"
//        searchBar.delegate = self
//        searchBar.isHidden = true
//        self.navigationItem.titleView = searchBar
//        
//        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
//
//        self.navigationItem.rightBarButtonItem = searchBtn
    }
    
//    @objc func searchTapped() {
//        searchBar.isHidden = false
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: EmbedContainerViewController.self) {
            containerViewController = segue.destination as? EmbedContainerViewController
            containerViewController?.style = currentStyle
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
