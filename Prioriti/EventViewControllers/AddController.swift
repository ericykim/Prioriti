//
//  AddSwift.swift
//  JTAppleCalendar
//
//  Created by Eric Kim on 7/13/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import JTAppleCalendar
import EventKit

class AddController: UIViewController {
    
    var firstDate: NSDate!
    var secondDate: NSDate!
    var selectedDate: NSDate!
    
    @IBOutlet weak var testContainer: UIView!
    @IBOutlet weak var homeworkContainer: UIView!
    @IBOutlet weak var eventContainer: UIView!
    @IBOutlet var addView: UIView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addView.backgroundColor = UIColor(colorWithHexValue: 0xEFFCFC)
        eventContainer.hidden = true
        homeworkContainer.hidden = false
        testContainer.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventContainer.hidden = true
        homeworkContainer.hidden = false
        testContainer.hidden = true
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    @IBAction func showEventContainer(sender: AnyObject) {
        eventContainer.hidden = false
        homeworkContainer.hidden = true
        testContainer.hidden = true
    }
    @IBAction func showHomeworkContainer(sender: AnyObject) {
        eventContainer.hidden = true
        homeworkContainer.hidden = false
        testContainer.hidden = true
    }
    @IBAction func showTestContainer(sender: AnyObject) {
        eventContainer.hidden = true
        homeworkContainer.hidden = true
        testContainer.hidden = false
    }
    
    
}
