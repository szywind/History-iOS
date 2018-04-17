//
//  SearchViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/29/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class SearchHomeViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchResultView: UIView!
    @IBOutlet weak var searchRecommendView: UIView!
    
    @IBOutlet weak var searchHint: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var isSearching = false
    var searchBar = UISearchBar()
    
    var filteredPeople = [Record]()
    var filteredEvents = [Record]()
    var filteredPosts = [Record]()
    var numSection = 0
    let allSectionTitles = ["人物", "事件", "社区"]
    var sectionTitles = [String]()
    var section2index = [Int: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switchToRecommendPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
        setupSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "请输入要搜索的词条"
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.isHidden = false
        searchBar.tintColor = Constants.Color.coral
        
//        searchBar.barTintColor = UIColor.red
        
        self.navigationItem.titleView = searchBar
        let searchCancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSearch))
        self.navigationItem.rightBarButtonItem = searchCancelBtn
        
        // let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        // self.view.addGestureRecognizer(tap)
        
    }
   
    
    func switchToRecommendPage() {
        searchRecommendView.isHidden = false
        
        searchResultView.isHidden = true
        searchResultTableView.isHidden = false
        searchHint.isHidden = true
    }
    
    func switchToResultPage() {
        searchRecommendView.isHidden = true
        
        searchResultView.isHidden = false
        searchResultTableView.isHidden = true
        searchHint.isHidden = false
    }
    
    // MARK: - Search Bar
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        filteredRecords.removeAll()
    //        if searchBar.text == nil || searchBar.text == "" {
    //            isSearching = false
    //            view.endEditing(true)
    //        } else {
    //            isSearching = true
    //            filteredRecords += LocalDataManager.sharedInstance.allPeople.filter({$0.name?.range(of:searchBar.text!) != nil})
    //            filteredRecords += LocalDataManager.sharedInstance.allEvents.filter({$0.name?.range(of:searchBar.text!) != nil})
    //        }
    //        refreshUI()
    //    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch(searchWord: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        willSearch()
    }

    
    private func willSearch() {
        switchToResultPage()
    }
    
    private func performSearch(searchWord: String) {
        numSection = 0
        sectionTitles.removeAll()
        section2index.removeAll()
        dismissKeyboard()
        filteredPeople = LocalDataManager.sharedInstance.allPeople.filter({$0.name?.range(of: searchWord) != nil})
        if !filteredPeople.isEmpty {
            section2index[numSection] = 0
            numSection += 1
            sectionTitles.append(allSectionTitles[0])
        }
        filteredEvents = LocalDataManager.sharedInstance.allEvents.filter({$0.name?.range(of: searchWord) != nil})
        if !filteredEvents.isEmpty {
            section2index[numSection] = 1
            numSection += 1
            sectionTitles.append(allSectionTitles[1])
        }
        
        filteredPosts = filteredPeople + filteredEvents
        if !filteredPosts.isEmpty {
            section2index[numSection] = 2
            numSection += 1
            sectionTitles.append(allSectionTitles[2])
        }
        
        refreshUI()
    }
    
    @objc private func cancelSearch() {
        dismissKeyboard()
        isSearching = false
        searchBar.text = ""
        switchToRecommendPage()
    }
    
    func refreshUI() {
        searchResultTableView.isHidden = false
        searchHint.isHidden = true
        searchResultTableView.reloadData()
    }
    
    override func dismissKeyboard() {
        self.searchBar.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecordDetails3" {
            if let destination = segue.destination as? EncyclopediaDetailViewController {
                if let indexPath = searchResultTableView.indexPathForSelectedRow {
                    var sectionData = [Record]()
                    let index = section2index[indexPath.section]
                    if index == 0 {
                        sectionData = filteredPeople
                    } else if index == 1 {
                        sectionData = filteredEvents
                    }
                    
                    if sectionData.isEmpty {
                        return
                    }
                    guard sectionData.count > indexPath.row else { return }
                    destination.record = sectionData[indexPath.row]
                }
            }
        } else if segue.identifier == "showArticleDetails3" {
            if let destination = segue.destination as? CommunityDetailViewController {
                if let indexPath = searchResultTableView.indexPathForSelectedRow {
                    var sectionData = [Record]()
                    let index = section2index[indexPath.section]
                    if index == 2 {
                        sectionData = filteredPosts
                    }
                    
                    if sectionData.isEmpty {
                        return
                    }
                    guard sectionData.count > indexPath.row else { return }
                    destination.record = sectionData[indexPath.row]
                }
            }
        }
    }
    
}

extension SearchHomeViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = section2index[section]
        if index == 0 {
            return filteredPeople.count
        } else if index == 1 {
            return filteredEvents.count
        } else if index == 2 {
            return filteredPosts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell1 = EncyclopediaRecordTableViewCell()
        var cell2 = CommunityForumTableViewCell()
        
        // Configure the cell...
        var sectionData = [Record]()
        let index = section2index[indexPath.section]

        if index == 0 {
            sectionData = filteredPeople
            cell1 = searchResultTableView.dequeueReusableCell(withIdentifier: "recordCell") as! EncyclopediaRecordTableViewCell
            cell1.recordLbl.text = sectionData[indexPath.row].name
            cell1.recordImage.image = sectionData[indexPath.row].avatar
        } else if index == 1 {
            sectionData = filteredEvents
            cell1 = searchResultTableView.dequeueReusableCell(withIdentifier: "recordCell") as! EncyclopediaRecordTableViewCell
            cell1.recordLbl.text = sectionData[indexPath.row].name
            cell1.recordImage.image = sectionData[indexPath.row].avatar
        } else if index == 2 {
            sectionData = filteredPosts
            cell2 = searchResultTableView.dequeueReusableCell(withIdentifier: "postCell") as! CommunityForumTableViewCell
            cell2.topicLbl.text = sectionData[indexPath.row].name
        }
        
        if sectionData.isEmpty {
            return cell1
        }
        
        if index! < 2 {

            return cell1
        } else {

            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        
        let index = section2index[indexPath.section]
        if index == 0 {
            performSegue(withIdentifier: "showRecordDetails3", sender: self)
        } else if index == 1 {
            performSegue(withIdentifier: "showRecordDetails3", sender: self)
        } else if index == 2 {
            performSegue(withIdentifier: "showArticleDetails3", sender: self) // TODO
        }
    }
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return sectionTitles
//    }
}
