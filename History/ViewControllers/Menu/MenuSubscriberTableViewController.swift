//
//  MenuSubscriberTableViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import AVOSCloud

class MenuSubscriberTableViewController: UITableViewController {

    var type: CellType = .follower
    
    var users: [AVUser]?
    var followees: [String]?
    
    class func create() -> MenuSubscriberTableViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! MenuSubscriberTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.separatorStyle = .none
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupData() {
        switch type {
        case .followee:
            break
        case .follower:
            users = [AVUser]()
            FollowManager.sharedInstance.fetchAllFollowers { (objects, error) in
                if error == nil && (objects?.count)! > 0 {
                    for object in objects!{
                        self.users?.append(object as! AVUser)
                        
                    }
                    self.tableView.reloadData()
                }
            }
        case .celeb, .recommendation:
            users = [AVUser]()
            UserManager.sharedInstance.findHotUsers { (objects, error) in
                if error == nil && (objects?.count)! > 0 {
                    for object in objects!{
                        self.users?.append(object as! AVUser)
                    }
                    //                self.users = objects as! [AVUser]
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func onFollowTapped(_ sender: UIButton) {
        let user = users?[sender.tag]
        AVUser.current()?.follow((user?.objectId)!, andCallback: { (succeed, error) in
            if succeed {
                print("succeed")
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    @objc func onUnfollowTapped(_ sender: UIButton) {
        let user = users?[sender.tag]
        AVUser.current()?.unfollow((user?.objectId)!, andCallback: { (succeed, error) in
            if succeed {
                print("succeed")
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTableViewCell
        
//        cell.avatarImage.image = records[indexPath.row].avatar
//        cell.nameLbl.text = records[indexPath.row].name
        cell.nameLbl.text = UserManager.sharedInstance.getNickname(user: users?[indexPath.row])
        cell.avatarImage.image = UserManager.sharedInstance.getAvatar(user: users?[indexPath.row])
        
        cell.followBtn.tag = indexPath.row
        cell.followBtn.addTarget(self, action: #selector(onFollowTapped(_:)), for: UIControlEvents.touchUpInside)
        cell.unfollowBtn.tag = indexPath.row
        cell.unfollowBtn.addTarget(self, action: #selector(onUnfollowTapped(_:)), for: UIControlEvents.touchUpInside)
        
//        FollowManager.sharedInstance.checkExistFollowee(user: users[indexPath.row], block: { (objects, error) in
//
//            if error == nil && (objects?.count)! > 0 {
//                cell.followBtn.isHidden = true
//            } else {
//                cell.followBtn.isHidden = false
//            }
//            cell.unfollowBtn.isHidden = !cell.followBtn.isHidden
//        })
        cell.followBtn.isHidden = (self.followees?.contains((users?[indexPath.row].objectId)!))!
        cell.unfollowBtn.isHidden = !cell.followBtn.isHidden
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
