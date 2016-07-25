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
    
    dynamic var title: String!
    dynamic var startDate: NSDate!
    dynamic var endDate: NSDate!
    dynamic var identifier: String!
//    dynamic var selectedEvent: EKEvent!
    
    static func retrieveEvent() -> Results<Event> {
        let realm = try! Realm()
        return realm.objects(self)
    }

    
    //create event
    init(title: String, startDate: NSDate, endDate: NSDate) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.identifier = ""
        super.init()
        let event = EventHelper.sharedInstance.createEvent(title, startDate: startDate, endDate: endDate)
        identifier = event?.eventIdentifier
        print(identifier)
    }
    
    
    func deleteSelectedEvent(event: EKEvent) {
      EventHelper.sharedInstance.deleteEvent(event)
        deleteFromRealm()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
//        let createEvent = EventHelper.sharedInstance.createEvent(title!, startDate: eventDatePicker.date, endDate: endDate)

    
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
    
    


}
