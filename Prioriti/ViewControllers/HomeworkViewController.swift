//
//  HomeworkViewController.swift
//  Prioriti
//
//  Created by Eric Kim on 7/14/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import UIKit
import EventKit

class HomeworkViewController: UIViewController {
    
    @IBOutlet weak var homeworkDatePicker: UIDatePicker!
    @IBOutlet weak var homeworkButton: UIButton!
    @IBOutlet weak var homeworkTitleField: UITextField!
///************************************************************
    
    
    @IBAction func addHomework(sender: AnyObject) {
        
        let title = homeworkTitleField.text
        let startDate = homeworkDatePicker.date
        let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour

        Event(title: title!, startDate: startDate, endDate: endDate, eventType: "homework").saveToRealm()
    }
    
    
///************************************************************
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let secondDate = (self.parentViewController as! AddController).secondDate
        let firstDate = (self.parentViewController as! AddController).firstDate
        let selectedDate = (self.parentViewController as! AddController).selectedDate
        
        homeworkDatePicker.date = selectedDate
        homeworkDatePicker.minimumDate = firstDate
        homeworkDatePicker.maximumDate = secondDate
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
