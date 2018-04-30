//
//  CommunityContentViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class CommunityContentViewController: UIViewController {
    
    var records = [Record] ()
    var recordDictionary = [String: [Record]]()
    var recordSectionTitles = [String]()
    
    @IBOutlet weak var topicCollectionView: UICollectionView!
    
    func processData() {
        //        records = records.sorted(by: { $0.pinyin! < $1.pinyin! || ($0.pinyin! < $1.pinyin! && $0.start! < $1.start!)}) // sort records by alphabetical order
        for record in records {
            let key = record.dynasty
            if var value = recordDictionary[key!] {
                value.append(record)
                recordDictionary[key!] = value
            } else {
                recordDictionary[key!] = [record]
            }
        }
        
        recordSectionTitles = recordDictionary.keys.sorted { (dynasty1, dynasty2) -> Bool in
            return LocalDataManager.dynasty2index[dynasty1]! < LocalDataManager.dynasty2index[dynasty2]!
        }
    }
    
    class func create() -> CommunityContentViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! CommunityContentViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        processData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if (self.navigationController?.navigationBar.isTranslucent)! {
//            self.navigationController?.navigationBar.isTranslucent = false
//        }
        topicCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommunityForumViewController {
            if let indexPath = topicCollectionView.indexPathsForSelectedItems?.first {
                guard let sectionData = recordDictionary[recordSectionTitles[indexPath.section]] else {
                    return
                }
                guard sectionData.count > indexPath.row else { return }
//                destination.topic = sectionData[indexPath.row].objectId
                destination.posts = [sectionData[indexPath.row]]
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

// MARK: - Collection View
extension CommunityContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recordDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionData = recordDictionary[recordSectionTitles[section]] else {
            return 0
        }
        return sectionData.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! CommunityCollectionViewCell

        // Configure the cell...
        guard let sectionData = recordDictionary[recordSectionTitles[indexPath.section]] else {
            return cell
        }
        cell.topicLbl.text = sectionData[indexPath.row].name
        cell.topicImage.image = sectionData[indexPath.row].avatar
        
        return cell
        
    }
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return recordSectionTitles
    }
    
    // Section Header View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeaderView", for: indexPath) as! SectionHeaderView
        let title = recordSectionTitles[indexPath.section]
        
        sectionHeaderView.dynastyTitle = title
        
        return sectionHeaderView
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "enterForum", sender: self)
    }
}
