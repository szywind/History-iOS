//
//  CommunityTableViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class CommunityTableViewController: UITableViewController {

    var records = [Record] ()
    
    class func create() -> CommunityTableViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! CommunityTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommunityDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.record = records[indexPath.row]
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        
        cell.topicLbl.text = records[indexPath.row].name
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showArticleDetails", sender: self)
    }

}
