//
//  ContentViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var records = [Record] ()
    var recordDictionary = [String: [Record]]()
    var recordSectionTitles = [String]()
    
    @IBOutlet weak var recordTableView: UITableView!

    func processData() {
        
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
    
    class func create() -> ContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! ContentViewController
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
        recordTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EncyclopediaDetailViewController {
            if let indexPath = recordTableView.indexPathForSelectedRow {
                guard records.count > indexPath.row else { return }
                destination.record = records[indexPath.row]
            }
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

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return recordDictionary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = recordDictionary[recordSectionTitles[section]] else {
            return 0
        }
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recordSectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTableView.dequeueReusableCell(withIdentifier: "recordCell") as! RecordTableViewCell
        
        // Configure the cell...
        guard let sectionData = recordDictionary[recordSectionTitles[indexPath.section]] else {
            return cell
        }
        
        cell.recordLbl.text = sectionData[indexPath.row].name
        cell.recordImage.image = sectionData[indexPath.row].avatar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        performSegue(withIdentifier: "showRecordDetails", sender: self)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return recordSectionTitles
    }
}
