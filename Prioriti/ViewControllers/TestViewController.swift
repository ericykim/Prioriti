//
//  TestViewController.swift
//  Prioriti
//
//  Created by Eric Kim on 7/14/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import UIKit
import EventKit
class TestViewController: UIViewController {
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var testDatePicker: UIDatePicker!
    @IBOutlet weak var testTitleField: UITextField!
    
///************************************************************
    
    
    @IBAction func addTest(sender: AnyObject) {
        
        let title = testTitleField.text
        let startDate = testDatePicker.date
        let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour
        
        Event(title: title!, startDate: startDate, endDate: endDate).saveToRealm()

    }
    

///************************************************************
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let secondDate = (self.parentViewController as! AddController).secondDate
        let firstDate = (self.parentViewController as! AddController).firstDate
        let selectedDate = (self.parentViewController as! AddController).selectedDate
        
        testDatePicker.date = selectedDate
        testDatePicker.minimumDate = firstDate
        testDatePicker.maximumDate = secondDate
        
        
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
