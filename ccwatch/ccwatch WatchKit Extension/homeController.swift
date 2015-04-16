//
//  homeController.swift
//  ccwatch
//
//  Created by Boy Genius on 2015/04/16.
//  Copyright (c) 2015 Boy Genius. All rights reserved.
//

import WatchKit
import Foundation


class homeController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?{
        let today = NSDate()
        var formatDate = NSDateFormatter();
        formatDate.dateFormat = "yyyyMMdd";
        if(segueIdentifier == "today"){
            return ["date" : formatDate.stringFromDate(today)]
        }else if(segueIdentifier == "Yesterday"){
            let yesterday = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay,value: -1,toDate: today,options: NSCalendarOptions(0))
                //var convdate = formatDate.stringFromDate(yesterday!)
            return ["date" : formatDate.stringFromDate(yesterday!)]
        }else{
            return ["date" : ""]
        }
    }
}
