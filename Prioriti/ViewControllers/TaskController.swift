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
        
        switch event.priority {
        case 1:
            cell.backgroundColor = UIColor.redColor()
        case 2:
            cell.backgroundColor = UIColor.yellowColor()
        case 3:
            cell.backgroundColor = UIColor.greenColor()
        case 4:
            cell.backgroundColor = UIColor.whiteColor()
        default:
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        cell.eventLabel.text = event.title
        cell.dateLabel.text = dueDate
        
        return cell
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
        events = Event.retrieveEvent()
    }

    override func viewWillAppear(animated: Bool) {
//        loadEvents()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

