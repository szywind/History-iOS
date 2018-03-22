//
//  BaseViewController.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var allPeople = [Record]()
    var allEvents = [Record]()
    var events = [Record]()
    var geo = [Record]()
    var art = [Record]()
    var tech = [Record]()
    var allRecords = [Record]()
    let dynasty2index = ["夏":0, "商":1, "西周":2, "春秋":3, "战国":4, "秦":5, "西汉":6, "东汉":7, "三国":8, "西晋":9, "东晋十六国":10,
                     "隋":11, "唐":12, "魏晋南北朝":13, "北宋":14, "辽":15, "金":16, "南宋":17, "元":18, "明":19, "清":20]
    let index2dynasty = ["夏", "商", "西周", "春秋", "战国", "秦", "西汉", "东汉", "三国", "西晋", "东晋十六国",
                         "隋", "唐", "魏晋南北朝", "北宋", "辽", "金", "南宋", "元", "明", "清"]
    func setupData() {
        allPeople = Record.getRecords(people: CoreDataManager.fetchAllPeople())
        allPeople.sort { (record1, record2) -> Bool in
            record1.start! < record2.start! || (record1.start! == record2.start! && record1.end! < record2.end!)
        }
        allEvents = Record.getRecords(events: CoreDataManager.fetchAllEvents())
        allEvents.sort { (record1, record2) -> Bool in
            record1.start! < record2.start! || (record1.start! == record2.start! && record1.end! < record2.end!)
        }
        allRecords = allPeople + allEvents
        allRecords.sort(by: {$0.start! < $1.start! || ($0.start! == $1.start! && $0.end! < $1.end!)})
        events = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "event", format: Constants.CoreData.eventTypeFilterFormat))
        geo = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "geography", format: Constants.CoreData.eventTypeFilterFormat))
        art = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "art", format: Constants.CoreData.eventTypeFilterFormat))
        tech = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "technology", format: Constants.CoreData.eventTypeFilterFormat))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: Constants.Notification.fetchDataFromLC), object: nil, queue: nil) { (_) in
            self.setupData()
            self.refreshUI()
        }
        setupData()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createView() {
    }
    
    // https://stackoverflow.com/questions/37805885/how-to-create-dispatch-queue-in-swift-3
    func refreshUI() {
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.createView()
            }
        }
    }
    
    @objc func dismissKeyboard(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.view.endEditing(true)
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
