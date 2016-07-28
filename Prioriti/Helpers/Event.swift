//
//  RealmHelper.swift
//  Prioriti
//
//  Created by Eric Kim on 7/22/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import Foundation
import RealmSwift
import EventKit
import Realm

class Event: Object {
    
    dynamic var title: String
    dynamic var startDate: NSDate
    dynamic var endDate: NSDate
    dynamic var identifier: String
    dynamic var eventType: String
    dynamic var priority: Int
    
    

    
//    dynamic var selectedEvent: EKEvent!
    
    static func retrieveEvent() -> Results<Event> {
        let realm = try! Realm()
//        return realm.objects(self)
        return realm.objects(Event).sorted("priority", ascending: true)
    }
    
    
//    enum eventType: Int {  eventType.Homework.rawValue
//        case Homework = 0, Test, Other
//    }

    enum EventType: String {
        case Event = "event"
        case Homework = "homework"
        case Test = "test"
        
    }
    
    
    //create event
    init(title: String, startDate: NSDate, endDate: NSDate, eventType: String) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.identifier = ""
        self.eventType = eventType
        self.priority = 0
        super.init()
        prioritize(startDate)
        print(priority)
        if let event = EventHelper.sharedInstance.createEvent(title, startDate: startDate, endDate: endDate) {
            identifier = event.eventIdentifier
        }
        print(priority)
        print(identifier)
        print(eventType)


        
    }
    

    
    
        required init() {
            self.title = ""
            self.startDate = NSDate()
            self.endDate = NSDate()
            self.identifier = ""
            self.eventType = ""
            self.priority = 0
            super.init()
        }
    
        required init(realm: RLMRealm, schema: RLMObjectSchema) {
            self.title = ""
            self.startDate = NSDate()
            self.endDate = NSDate()
            self.identifier = ""
            self.eventType = ""
            self.priority = 0
            super.init(realm: realm, schema: schema)
        }
    
        required init(value: AnyObject, schema: RLMSchema) {
            self.title = ""
            self.startDate = NSDate()
            self.endDate = NSDate()
            self.identifier = ""
            self.eventType = ""
            self.priority = 0
            super.init(value: value, schema: schema)
        }
    //        let createEvent = EventHelper.sharedInstance.createEvent(title!, startDate: eventDatePicker.date, endDate: endDate)
    

    
    func prioritize(startDate: NSDate) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        let dueDate = calendar.startOfDayForDate(startDate)
        
        ////debug
//        let fakedate = formatter.dateFromString("7/29/2016")
//        let today = calendar.startOfDayForDate(fakedate!)
        ////
        
      let today = calendar.startOfDayForDate(NSDate())
        
        let flags = NSCalendarUnit.Day
        let components = calendar.components(flags, fromDate: today, toDate: dueDate, options: [])
        
        print("difference is \(components.day)")
        
        
        
        
        if components.day >= 0 {
            if eventType == EventType.Event.rawValue {
                switch components.day {
                case 0:
                    
                    priority = 4
                default:
                    
                    priority = 4
                }
            }
            if eventType == EventType.Homework.rawValue {
                switch components.day {
                case 0:
                    
                    priority = 1
                case 1:
                    
                    priority = 1
                case 2:
                    print("hello")
                    priority = 1
                case 3:
                    
                    priority = 2
                case 4:
                    
                    priority = 2
                default:
                    
                    priority = 3
                }
            }
            if eventType == EventType.Test.rawValue {
                switch components.day {
                case 0:
                    
                    priority = 1
                case 1:
                    
                    priority = 1
                case 2:
                    
                    priority = 1
                case 3:
                    
                    priority = 1
                case 4:
                    
                    priority = 1
                case 5:
                    
                    priority = 2
                case 6:
                    
                    priority = 2
                default:
                    
                    priority = 3
                }
            }
            
//            return priority
        }
        else {
            
            priority = 4
            
//            return priority
        }
        
        
    }
    
 
    func deleteSelectedEvent(event: EKEvent) {
      EventHelper.sharedInstance.deleteEvent(event)
        deleteFromRealm()
    }
    
    // eventInstance.saveToRealm()
    func saveToRealm() {
        let realm = try! Realm()
        try! realm.write() {
            // save, modify, or delete some object(s) here
            realm.add(self)
        }
    }
    
    
    func deleteFromRealm() {
        let realm = try! Realm()
        try! realm.write() {
            // save, modify, or delete some object(s) here
            realm.delete(self)
        }
    }
    
    
    static func updateEvent(oldEvent: Event, newEvent: Event){
        let realm = try! Realm()
        try! realm.write(){
            oldEvent.title = newEvent.title
            oldEvent.startDate = newEvent.startDate
            oldEvent.endDate = newEvent.endDate
            oldEvent.identifier = newEvent.identifier
            oldEvent.eventType = newEvent.eventType
            oldEvent.priority = newEvent.priority
            
        }
    }

}
