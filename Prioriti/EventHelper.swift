//
//  EventHelper.swift
//  Prioriti
//
//  Created by Eric Kim on 7/20/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import Foundation
import EventKit

class EventHelper {
    
    // Example:
    // let eventHelper = EventHelper.sharedInstance
    static let sharedInstance = EventHelper()
    
    let eventStore = EKEventStore()
    var savedEventId : String = ""
    
///*********
    func createEvent(title: String, startDate: NSDate, endDate: NSDate) -> EKEvent? {
        let event = EKEvent(eventStore: eventStore)
        event.allDay = true
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            return event
        } catch {
            print("Bad things happened")
            return nil
        }
        
    }
    
///********
    
    func deleteEvent(selectedEvent: EKEvent) {
        do {
            try eventStore.removeEvent(selectedEvent, span: EKSpan.ThisEvent, commit: true)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
///********
    typealias EventsCallback = ([EKEvent]) -> Void
//    func someFunction([EKEvent])  {
//        
//    }
//    call back does callback after function is run
    
    func fetchAllEvents(callback: EventsCallback) {
        let calendar = eventStore.defaultCalendarForNewEvents
        // Create a date formatter instance to use for converting a string to a date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Create start and end date NSDate instances to build a predicate for which events to select
        let startDate = dateFormatter.dateFromString("2014-01-01")
        let endDate = dateFormatter.dateFromString("2020-01-01")
        
        // Use an event store instance to create and properly configure an NSPredicate
        let eventsPredicate = eventStore.predicateForEventsWithStartDate(startDate!, endDate: endDate!, calendars: [calendar])
        
        // Use the configured NSPredicate to find and return events in the store that match
        let events = eventStore.eventsMatchingPredicate(eventsPredicate).sort(){
            (e1: EKEvent, e2: EKEvent) -> Bool in
            return e1.startDate.compare(e2.startDate) == NSComparisonResult.OrderedAscending
        }
        
        callback(events)
    
    }
///*******
    func askPermission() {
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                print("getting permission")
            })
        } else {
            print("already have permission")
        }
    }
}




