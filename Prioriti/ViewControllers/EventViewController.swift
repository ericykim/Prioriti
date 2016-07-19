//
//  EventViewController.swift
//  Prioriti
//
//  Created by Eric Kim on 7/14/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    let testString: String = "test"
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        let secondDate = (self.parentViewController as! AddController).secondDate
        let firstDate = (self.parentViewController as! AddController).firstDate
        let selectedDate = (self.parentViewController as! AddController).selectedDate
        
        datePicker.date = selectedDate
        datePicker.minimumDate = firstDate
        datePicker.maximumDate = secondDate
//        datePicker.date = formatter.stringFromDate(date)
        
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
