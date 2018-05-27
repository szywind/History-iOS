//
//  EncyclopediaTableViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit
import Kingfisher

class EncyclopediaTableViewController: UITableViewController {

    var records = [Record] ()
    var recordDictionary = [String: [Record]]()
    var recordSectionTitles = [String]()
    
    // setup section by alphabet initial
    func processData() {
        //        records = records.sorted(by: { $0.pinyin! < $1.pinyin! || ($0.pinyin! < $1.pinyin! && $0.start! < $1.start!)}) // sort records by alphabetical order
        for record in records {
            let key = record.pinyin?.prefix(1).uppercased()
            if var value = recordDictionary[key!] {
                value.append(record)
                recordDictionary[key!] = value
            } else {
                recordDictionary[key!] = [record]
            }
        }
        
        recordSectionTitles = recordDictionary.keys.sorted(by: { $0 < $1 })
    }
    
    class func create() -> EncyclopediaTableViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! EncyclopediaTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refresh() {
        processData()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EncyclopediaDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let sectionData = recordDictionary[recordSectionTitles[indexPath.section]] else {
                    return
                }
                guard sectionData.count > indexPath.row else { return }
                destination.record = sectionData[indexPath.row]
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return recordDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = recordDictionary[recordSectionTitles[section]] else {
            return 0
        }
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recordSectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell") as! RecordTableViewCell
        
        // Configure the cell...
        guard let sectionData = recordDictionary[recordSectionTitles[indexPath.section]] else {
            return cell
        }
        
        cell.recordLbl.text = sectionData[indexPath.row].name
//        cell.recordImage.image = sectionData[indexPath.row].avatarURL?.getUIImage()
        cell.recordImage.kf.setImage(with: URL(string: sectionData[indexPath.row].avatarURL!),
                                    placeholder: UIImage(named: Constants.Default.defaultAvatar)!)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRecordDetails", sender: self)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return recordSectionTitles
    }

}
