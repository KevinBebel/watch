//
//  NavigationInterfaceController.swift
//  ccwatch
//
//  Created by Boy Genius on 2015/04/16.
//  Copyright (c) 2015 Boy Genius. All rights reserved.
//

import WatchKit
import Foundation


class NavigationInterfaceController: WKInterfaceController {
    var date:String = ""
    var data:JSON = JSON.nullJSON
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.date = (context as! NSDictionary)["date"] as! String;
        println("The Current Date is : \(self.date)" )
        loadEventData()
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
    
    func loadEventData() {
        var url = "http://www.dedicatedsolutions.co.za:8082/rest2/callcycle/GetReport?supplierID=conv&userID=bernicemyers&startdate=\(self.date)&format=json"
        request(.GET,url).responseJSON{ (_, _,json,_) in
            self.data = JSON(json!)
            //println(self.data.arrayObject)
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?{
        return self.data.arrayObject
    }
}
