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
    var dataArr = [" {'name': 'Eunice','store': 'REALMO','mon': 0,'tue': 0,'wen': 0,'thur': 1,'fri': 1}","{'name': 'Frost','store': 'FANFARE','mon': 1,'tue': 1,'wen': 0,'thur': 0,'fri': 0}","{'name': 'Giles','store': 'CORPULSE','mon': 0,'tue': 0,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Jodi','store': 'IRACK','mon': 1,'tue': 0,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Marla','store': 'MUSIX','mon': 1,'tue': 1,'wen': 1,'thur': 1,'fri': 0}","{'name': 'Horn','store': 'CHORIZON','mon': 0,'tue': 0,'wen': 0,'thur': 1,'fri': 0}","{'name': 'Boyle','store': 'TRANSLINK','mon': 0,'tue': 1,'wen': 0,'thur': 1,'fri': 1}","{'name': 'Erna','store': 'FLEETMIX','mon': 1,'tue': 1,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Jackson','store': 'VURBO','mon': 1,'tue': 0,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Perez','store': 'ZAYA','mon': 1,'tue': 1,'wen': 0,'thur': 0,'fri': 0}"]
    
    var data:JSON = JSON.nullJSON
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.date = (context as! NSDictionary)["date"] as! String;
        println("The Current Date is : \(self.date)" )
        //loadEventData()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        loadEventData()
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadEventData() {
        //www.super-trade.co.za:8083/rest/index.php/GetStoredProc?StoredProc=usp_callcycle_orders_dailyreport&params=(CONV|BERNICEMYERS)
        var url = "http://www.super-trade.co.za:8083/rest/index.php/GetStoredProc?StoredProc=usp_callcycle_orders_dailyreport&params=(CONV|BERNICEMYERS)"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        println(url)
        request(.GET,url).responseJSON{ (_, _,json,_) in
            println(json)
            self.data = JSON(json!)
            println(self.data.arrayObject)
        }
        self.data = JSON(self.dataArr)
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?{
        return self.data.arrayObject
    }
}
