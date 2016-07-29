//
//  TaskController.swift
//  Prioriti
//
//  Created by Eric Kim on 7/19/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import UIKit
import EventKit
import Realm
import RealmSwift

class TaskController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var eventTableView: UITableView!
///***************************************************************
    let formatter = NSDateFormatter()
    
    
    var events: Results<Event>! {
        didSet {
            eventTableView.reloadData()
        }
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as! EventsTableViewCell
       
        let row = indexPath.row
        let event = events[row]
        
        formatter.dateFormat = "MM/dd/yyyy"
        let dueDate = formatter.stringFromDate((event.startDate))
        
        checkPriority(event, cell: cell)
        
        cell.eventLabel.text = event.title
        cell.dateLabel.text = dueDate
        
        return cell
    }
    
    func checkPriority(event: Event, cell: EventsTableViewCell) {
        switch event.priority {
        case 1:
            cell.backgroundColor = UIColor(colorWithHexValue: 0xD7263D)
        case 2:
            cell.backgroundColor = UIColor(colorWithHexValue: 0xFFED76)
        case 3:
            cell.backgroundColor = UIColor(colorWithHexValue: 0x1CD883)
        case 4:
            cell.backgroundColor = UIColor(colorWithHexValue: 0xFEFEFF)
        default:
            cell.backgroundColor = UIColor(colorWithHexValue: 0xFEFEFF)
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        

        
        
        let selectedEvent = events[indexPath.row]
        print(selectedEvent.identifier)
        let eventName = EventHelper.sharedInstance.eventStore.eventWithIdentifier(selectedEvent.identifier)
        if eventName == nil {
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            selectedEvent.deleteSelectedEvent(eventName!)
        }
        print(eventName)
        selectedEvent.deleteSelectedEvent(eventName!)
//        selectedEvent.delete()
//        events = Event.retrieveEvent()
//        EventHelper.sharedInstance.deleteEvent(selectedEvent)
//        self.events?.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        print("hello")
        
    }
    

    



///***************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        events = Event.retrieveEvent()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        events = Event.retrieveEvent()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        for event in events {
            print(event.startDate)
            
            
            
            print(event.priority)
            
            let newEvent = Event()
            
            newEvent.title = event.title
            newEvent.startDate = event.startDate
            newEvent.endDate = event.endDate
            newEvent.identifier = event.identifier
            newEvent.eventType = event.eventType
            newEvent.priority = event.priority
            newEvent.prioritize(event.startDate)
            Event.updateEvent(event, newEvent: newEvent)
            eventTableView.reloadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
