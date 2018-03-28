//
//  SearchViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/29/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate {
    
    var filteredRecords = [Record]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "请输入要搜索的词条"
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.isHidden = false
//        searchBar.tintColor = UIColor.blue
//        searchBar.barTintColor = UIColor.red
        self.navigationItem.titleView = searchBar
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(performSearch))
        self.navigationItem.rightBarButtonItem = searchBtn
        
        //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        //        self.view.addGestureRecognizer(tap)
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
    
    @objc func performSearch() {
        
    }
    
    func refreshUI() {
        
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
