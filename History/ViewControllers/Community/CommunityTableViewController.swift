//
//  CommunityTableViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class CommunityTableViewController: UITableViewController {

    var posts = [AVObject]()
    var type: PostCellType = .latest
    
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
        setupData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData() {
        switch type {
        case .latest:
            break
        case .hot:
            posts = posts.sorted(by: {PostManager.sharedInstance.getReplies(post: $0) > PostManager.sharedInstance.getReplies(post: $1)})
        case .best:
            posts = posts.sorted(by: {PostManager.sharedInstance.getLikes(post: $0) > PostManager.sharedInstance.getLikes(post: $1)})
        }
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommunityDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.post = posts[indexPath.row]
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        
        cell.topicLbl.text = PostManager.sharedInstance.getTitle(post: posts[indexPath.row])
        
        PostManager.sharedInstance.getAuthor(post: posts[indexPath.row]) { (objects, error) in
            if error == nil && (objects?.count)! == 1 {
                let user = objects?.first as! AVUser
                cell.authorLbl.text = UserManager.sharedInstance.getNickname(user: user)
            } else {
                cell.authorLbl.text = Constants.Default.defaultNickname
            }
//            self.refresh()
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showArticleDetails", sender: self)
    }

}
