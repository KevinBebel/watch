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
    let defaults = NSUserDefaults(suiteName: "watchGrp")
    @IBOutlet var todatbtn: WKInterfaceButton!
    @IBOutlet var yesterdaybtn: WKInterfaceButton!
    var supplierID:String!
    var UserID:String!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        checkLogin()
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    func checkLogin(){
        self.supplierID = defaults?.objectForKey("SupplierID") as? String
        self.UserID = defaults?.objectForKey("UserID") as? String
        self.defaults?.synchronize()
        println(self.supplierID)
        println(self.UserID)
        
       
    }


    @IBAction func refresh() {
        checkLogin()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?{
        let today = NSDate()
        var formatDate = NSDateFormatter();
        formatDate.dateFormat = "yyyy-MM-dd";
        
        if(segueIdentifier == "today"){
            self.defaults?.setObject(formatDate.stringFromDate(today), forKey: "date")
            return ["date" : formatDate.stringFromDate(today)]
        }else if(segueIdentifier == "Yesterday"){
            let yesterday = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay,value: -1,toDate: today,options: NSCalendarOptions(0))
                self.defaults?.setObject(formatDate.stringFromDate(yesterday!), forKey: "date")
                //var convdate = formatDate.stringFromDate(yesterday!)
            return ["date" : formatDate.stringFromDate(yesterday!)]
        }else{
            return ["date" : ""]
        }
    }
}
