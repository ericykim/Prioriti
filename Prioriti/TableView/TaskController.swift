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
import MGSwipeTableCell

class TaskController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var emptyTableView: UIView!
    
    
///***************************************************************
    let formatter = NSDateFormatter()
    
    
    var events: Results<Event>! {
        didSet {
            eventTableView.reloadData()
        }
    }
    
    
    //            var userDates = [NSDate]()
    //            let userEvents = Event.retrieveEvent()
    //            for event in userEvents {
    //                userDates.append(event.startDate)
    
    func noEventView() {
        emptyTableView.backgroundColor = UIColor(colorWithHexValue: 0xEFFCFC)
        print("start func")
        print(events.count)
        if pastArray.isEmpty && upcomingArray.isEmpty && eventsArray.isEmpty {
            print("empty table view")
            self.emptyTableView.hidden = false
            self.eventTableView.hidden = true
        }
        else {
            emptyTableView.hidden = true
            eventTableView.hidden = false
        }
//        for event in eventArrayData {
//            eventArray.append(event.startDate)
//            print(eventArray.count)
//            print("is it wokring")
//            if eventArray.count == 0 {
//                print("hello")
//            }
//            else{
//                print("else")
//            }
//        }
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upcomingArray.count
        case 1:
            return eventsArray.count
        case 2:
            return pastArray.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch (section) {
        case 0:
            return  "Upcoming Work"
        //return sectionHeaderView
        case 1:
            return "Events"
        //return sectionHeaderView
        case 2:
            return "Past"
        //return sectionHeaderView
        default:
            break
        }
        
        return ""
    }
    
    
    var upcomingArray: [Event] = []
    var eventsArray: [Event] = []
    var pastArray: [Event] = []
    
    func sortEvents() {
        for event in events {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            
            let calendar: NSCalendar = NSCalendar.currentCalendar()
            let dueDate = calendar.startOfDayForDate(event.startDate)
            let today = calendar.startOfDayForDate(NSDate())
            let flags = NSCalendarUnit.Day
            let components = calendar.components(flags, fromDate: today, toDate: dueDate, options: [])
            
            if components.day >= 0 {
                
                if event.eventType == "event" {
                    eventsArray.append(event)
                }
                else {
                    upcomingArray.append(event)
                }
                    
            }
            else {
                pastArray.append(event)
            }

        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as! EventsTableViewCell
      
        
        
        var event: Event
        let row = indexPath.row
        switch indexPath.section {
        case 0:
            event = upcomingArray[row]
            checkPriority(event, cell: cell)
            
        case 1:
            event = eventsArray[row]
            checkPriority(event, cell: cell)
        case 2:
            event = pastArray[row]
            checkPriority(event, cell: cell)
        default:
            fatalError()
        }
        
        
        
        formatter.dateFormat = "EEE, MMM d"
        let dueDate = formatter.stringFromDate((event.startDate))
        
        cell.eventLabel.text = event.title
        cell.dateLabel.text = dueDate
        
        
////delete swipe
        cell.rightExpansion.fillOnTrigger = true
        cell.rightExpansion.buttonIndex = 0
        
        
        
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            if indexPath.section == 0 {
                self.upcomingArray.removeAtIndex(indexPath.row)
            }
            if indexPath.section == 1 {
                self.eventsArray.removeAtIndex(indexPath.row)
            }
            if indexPath.section == 2 {
                self.pastArray.removeAtIndex(indexPath.row)
            }
            let selectedEvent = self.events[indexPath.row]
//            print(self.events[indexPath.section])
            let eventName = EventHelper.sharedInstance.eventStore.eventWithIdentifier(selectedEvent.identifier)
            if eventName == nil {
                event.deleteFromRealm()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            else {
                selectedEvent.deleteSelectedEvent(eventName!)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            print("Convenience callback for delete button!")
            return true
        })]


        
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
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//
//        
//        
//        let selectedEvent = events[indexPath.row]
//        print(selectedEvent.identifier)
//        let eventName = EventHelper.sharedInstance.eventStore.eventWithIdentifier(selectedEvent.identifier)
//        if eventName == nil {
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//            selectedEvent.deleteSelectedEvent(eventName!)
//        }
//        print(eventName)
//        selectedEvent.deleteSelectedEvent(eventName!)
////        selectedEvent.delete()
////        events = Event.retrieveEvent()
////        EventHelper.sharedInstance.deleteEvent(selectedEvent)
////        self.events?.removeAtIndex(indexPath.row)
//        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//        print("hello")
//        
//    }
    

    



///***************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        events = Event.retrieveEvent()
        noEventView()
        sortEvents()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        events = Event.retrieveEvent()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pastArray.removeAll()
        upcomingArray.removeAll()
        eventsArray.removeAll()
        sortEvents()
        noEventView()
        
        
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
