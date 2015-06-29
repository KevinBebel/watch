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
    @IBOutlet weak var image: WKInterfaceImage!
    
    @IBOutlet weak var metbtn: WKInterfaceButton!
    @IBOutlet weak var notmetbtn : WKInterfaceButton!
    @IBOutlet weak var unplannedbtn: WKInterfaceButton!
    
    var date:String = ""
    var data:JSON = JSON.nullJSON
    var tableViewObject = [Dictionary<String,String>()]//[["name" : "Kevin" , "target" : "50" , "visted" : "49"]]
    
    var metModel = [Dictionary<String,String>()]
    var notMetModel = [Dictionary<String,String>()]
    var underPlannedModel = [Dictionary<String,String>()]
    
    var metstoreModel = [[Dictionary<String,String>()]]
    var notMetstoreModel = [[Dictionary<String,String>()]]
    var underPlannedstoreModel = [[Dictionary<String,String>()]]
    let defaults = NSUserDefaults(suiteName: "watchGrp")
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        println(context)
        self.date = (context as! NSDictionary)["date"] as! String;
       image.startAnimatingWithImagesInRange(NSMakeRange(1, 145), duration: 2.41, repeatCount: 1)
        println(self.data)
        loadEventData()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        //loadEventData()
        super.willActivate()
        metbtn.setHidden(false)
        notmetbtn.setHidden(false)
        unplannedbtn.setHidden(false)
        
        image.setHidden(true)
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadEventData() {
        //www.super-trade.co.za:8083/rest/index.php/GetStoredProc?StoredProc=usp_callcycle_orders_dailyreport&params=(CONV|BERNICEMYERS)
        var date = self.defaults?.objectForKey("date") as! String
        println("The Current Date is : \(date)" )
        
        /*var url = "http://www.super-trade.co.za:8083/rest/index.php/GetStoredProc?StoredProc=usp_callcycle_orders_dailyreport&params=(CONV|BERNICEMYERS|'\(date)')"*/
        
        var url = "http://www.super-trade.co.za:8083/rest/index.php/GetStoredProc?StoredProc=usp_callcycle_orders_dailyreport&params=(CONV|BERNICEMYERS|'2015-04-16')"
        
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        println(url)
        request(.GET,url).responseJSON{ (_, _,json,_) in
            println(json)
            self.data = JSON(json!)
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?{
        if(segueIdentifier == "met" ){
            //println(self.metModel)
            self.defaults?.setObject("met", forKey: "optClicked")
        }else if(segueIdentifier == "notmet"){
            self.defaults?.setObject("notmet", forKey: "optClicked")
        }else if(segueIdentifier == "underplanned"){
            self.defaults?.setObject("underplanned", forKey: "optClicked")
        }
        return self.data.arrayObject
    }
}