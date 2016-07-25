//
//  EventViewController.swift
//  Prioriti
//
//  Created by Eric Kim on 7/14/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import UIKit
import EventKit
import RealmSwift

class EventViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var eventTitleField: UITextField!
    
///*********************************************
    
    @IBAction func addEvent(sender: AnyObject) {
        
        let title = eventTitleField.text
        let startDate = eventDatePicker.date
        let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour

        Event(title: title!, startDate: startDate, endDate: endDate).saveToRealm()
        
    }

///******************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        print(eventTitleField.text)
        
        // Do any additional setup after loading the view.
    }
    
    let testString: String = "test"
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        let secondDate = (self.parentViewController as! AddController).secondDate
        let firstDate = (self.parentViewController as! AddController).firstDate
        let selectedDate = (self.parentViewController as! AddController).selectedDate
        
        eventDatePicker.date = selectedDate
        eventDatePicker.minimumDate = firstDate
        eventDatePicker.maximumDate = secondDate

        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
