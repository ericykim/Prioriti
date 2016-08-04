//
//  ViewController.swift
//  testApplicationCalendar
//
//  Created by Jay Thomas on 2016-03-01.
//  Copyright © 2016 OS-Tech. All rights reserved.
//

import JTAppleCalendar
import EventKit
import Realm
import RealmSwift

class PlanController: UIViewController {
    var numberOfRows = 6
    
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var currentDate: UIButton!
    @IBOutlet var backgroundView: UIView!
    
    
//Current Date
    @IBAction func goToCurrentDate(sender: UIButton) {
//        for date in calendarView.selectedDates {
//            print(formatter.stringFromDate(date))
//        }
        let date = NSDate()
        self.calendarView.selectDates([NSDate()], triggerSelectionDelegate: true)
        calendarView.scrollToDate(date)
        currentDate.shake()
        

        
    }
//unwind
    @IBAction func canceltoPlanController(segue:UIStoryboardSegue) {
    }
    
    
    let formatter = NSDateFormatter()
    let testCalendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    
//
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toAddViewController") {
            let firstDate = segue.destinationViewController as! AddController
            firstDate.firstDate = formatter.dateFromString("01/01/2014")
            
            let secondDate = segue.destinationViewController as! AddController
            secondDate.secondDate = formatter.dateFromString("01/01/2020")
            
            let choosenDate = segue.destinationViewController as! AddController
            choosenDate.selectedDate = selectedDate

            
        }
    }


    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        calendarView.reloadData()
        
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        EventHelper.sharedInstance.askPermission()
        
        
        formatter.dateFormat = "MM/dd/yyyy"
        testCalendar.timeZone = NSTimeZone(abbreviation: "GMT")!

        
        calendarView.delegate = self
        calendarView.dataSource = self
        // Registering your cells is manditory   ******************************************************
        
        calendarView.registerCellViewXib(fileName: "CellView") // Registering your cell is manditory
//         calendarView.registerCellViewClass(fileName: "JTAppleCalendar_Example.CodeCellView")
        
        // ********************************************************************************************
        
        
        // Enable the following code line to show headers. There are other lines of code to uncomment as well
//         calendarView.registerHeaderViewXibs(fileNames: ["PinkSectionHeaderView", "WhiteSectionHeaderView"]) // headers are Optional. You can register multiple if you want.
        
        // The following default code can be removed since they are already the default.
        // They are only included here so that you can know what properties can be configured
        calendarView.direction = .Vertical                       // default is horizontal
        calendarView.cellInset = CGPoint(x: 0, y: 0.35)               // default is (3,3)
        calendarView.allowsMultipleSelection = false               // default is false
        calendarView.bufferTop = 0                                 // default is 0. - still work in progress on this
        calendarView.bufferBottom = 0                              // default is 0. - still work in progress on this
        calendarView.firstDayOfWeek = .Sunday                      // default is Sunday
        calendarView.scrollEnabled = true                          // default is true
        calendarView.pagingEnabled = true                          // default is true
        calendarView.scrollResistance = 0.75                       // default is 0.75 - this is only applicable when paging is not enabled.
//        calendarView.itemSize = nil                                // default is nil. Use a value here to change the size of your cells
//        calendarView.cellSnapsToEdge = true                        // default is true. Disabling this causes calendar to not snap to grid
        calendarView.reloadData()
        selectTodaydate()
        
        backgroundView.backgroundColor = UIColor(colorWithHexValue: 0xEFFCFC)
        calendarView.backgroundColor = UIColor(colorWithHexValue: 0xEFFCFC)
        // After reloading. Scroll to your selected date, and setup your calendar
        calendarView.scrollToDate(NSDate(), triggerScrollToDateDelegate: false, animateScroll: false) {
            let currentDate = self.calendarView.currentCalendarDateSegment()
            self.setupViewsOfCalendar(currentDate.startDate, endDate: currentDate.endDate)
        }
        
    
    }
    
    var selectedDate : NSDate!
    func selectDate() {
        for date in calendarView.selectedDates {
            selectedDate = date
            print(selectedDate)
            
        }
   
        
        
    }
    
    func selectTodaydate() {
        self.calendarView.selectDates([NSDate()], triggerSelectionDelegate: true)
    }

    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViewsOfCalendar(startDate: NSDate, endDate: NSDate) {
        let month = testCalendar.component(NSCalendarUnit.Month, fromDate: startDate)
        let monthName = NSDateFormatter().monthSymbols[(month-1) % 12] // 0 indexed array
        let year = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: startDate)
        monthLabel.text = monthName
        yearLabel.text = String(year)
    }
    

    
    
    ///realm
    
    
    ///
    
    
    
    
}
extension UIButton {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 10, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 10, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
    }
    
}


// MARK : JTAppleCalendarDelegate
extension PlanController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    

    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, numberOfRows: Int, calendar: NSCalendar) {
        
        let firstDate = formatter.dateFromString("01/01/2016")
        let secondDate = formatter.dateFromString("01/01/2020")
        let aCalendar = NSCalendar.currentCalendar() // Properly configure your calendar to your time zone here
        return (startDate: firstDate!, endDate: secondDate!, numberOfRows: numberOfRows, calendar: aCalendar)
    }

    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        guard let cellView = cell as? CellView else {
            return
        }
        
        cellView.setupCellBeforeDisplay(cellState, date: date)
        cellView.disableFollowingMonthDates(cellState)
        
        let userEventDates = Event.retrieveEvent().map { $0.startDate }
        cellView.eventNotificationView.hidden = userEventDates.contains(date) ? false : true
        
        // if date is special
        // do something special
        // else hide view

        
//        (cell as? CellView)?.displayNotification(cellState)
        
        
        
    }

    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState)
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState)
        selectDate()
        setupViewsOfCalendar(date, endDate: date)
        
        
    
        
    //Scroll when clicked out of month
        if cellState.dateBelongsTo == .FollowingMonthWithinBoundary {
            self.calendarView.scrollToNextSegment()
//            let currentDate = self.calendarView.currentCalendarDateSegment()
//            self.setupViewsOfCalendar(currentDate.startDate, endDate: currentDate.endDate)
//            calendar.reloadData()
        }
        if cellState.dateBelongsTo == .PreviousMonthWithinBoundary {
            self.calendarView.scrollToPreviousSegment()
//            calendar.reloadData()
//            let currentDate = self.calendarView.currentCalendarDateSegment()
//            self.setupViewsOfCalendar(currentDate.startDate, endDate: currentDate.endDate)
        }
    }
    
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        let currentDate = self.calendarView.currentCalendarDateSegment()
        self.setupViewsOfCalendar(currentDate.startDate, endDate: currentDate.endDate)

        
    }
//    
//    func calendar(calendar: JTAppleCalendarView, sectionHeaderIdentifierForDate date: (startDate: NSDate, endDate: NSDate)) -> String? {
//        let comp = testCalendar.component(.Month, fromDate: date.startDate)
//        if comp % 2 > 0{
//            return "WhiteSectionHeaderView"
//        }
//        return "PinkSectionHeaderView"
//    }
   
    func calendar(calendar: JTAppleCalendarView, sectionHeaderSizeForDate date: (startDate: NSDate, endDate: NSDate)) -> CGSize {
        if testCalendar.component(.Month, fromDate: date.startDate) % 2 == 1 {
            return CGSize(width: 200, height: 50)
        } else {
            return CGSize(width: 200, height: 100) // Yes you can have different size headers
        }
    }
    

    

}


func delayRunOnMainThread(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
