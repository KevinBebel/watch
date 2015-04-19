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
    var tableViewObject = [Dictionary<String,String>()]//[["name" : "Kevin" , "target" : "50" , "visted" : "49"]]
    
    var metModel = [Dictionary<String,String>()]
    var notMetModel = [Dictionary<String,String>()]
    var underPlannedModel = [Dictionary<String,String>()]
    
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
        var url = "http://www.super-trade.co.za:8083/rest/index.php/GetStoredProc?StoredProc=usp_callcycle_orders_dailyreport&params=(CONV|BERNICEMYERS|'2015-04-16')"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        println(url)
        request(.GET,url).responseJSON{ (_, _,json,_) in
            println(json)
            self.data = JSON(json!)
            if let items = self.data.array{
                var person  = ""
                var visited = 0
                var target  = 0
                var objectToAppend = Dictionary<String, String>()
                var oldPerson = ""
                var PersonCounter = 0
                for item in items {
                    if let userID = item["UserID"].string{
                        if userID == person{
                            target++
                            if let vist = item["count"].int{
                                if vist > 0{
                                    visited++
                                }
                            }
                        }else{
                            oldPerson = person
                            if(!oldPerson.isEmpty){
                                objectToAppend["name"]    = oldPerson
                                objectToAppend["visited"] = String(visited)
                                objectToAppend["target"]  = String(target)
                                
                                var percentage = (((String(visited) as NSString).floatValue) / ((String(target) as NSString).floatValue)) * 100
                                
                                self.tableViewObject.insert(objectToAppend, atIndex:PersonCounter)
                                PersonCounter++
                                visited = 0
                                if let vist = item["count"].int{
                                    if vist > 0{
                                        visited = 1
                                    }
                                }
                                target  = 1
                                person = userID
                                
                            }else{
                                visited = 0
                                person = userID
                            }
                            
                        }
                    }//checking userID
                }//Items Loop
            }//End of checking if Array
            println(self.tableViewObject)
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?{
        return self.data.arrayObject
    }
}
