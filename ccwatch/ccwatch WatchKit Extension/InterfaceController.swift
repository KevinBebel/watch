//
//  InterfaceController.swift
//  callcycle WatchKit Extension
//
//  Created by Boy Genius on 2015/04/09.
//  Copyright (c) 2015 Boy Genius. All rights reserved.
//

import WatchKit
import Foundation



class InterfaceController: WKInterfaceController {
    var date:String = ""
    var data:JSON = JSON.nullJSON
    var tableViewObject = [Dictionary<String,String>()]//[["name" : "Kevin" , "target" : "50" , "visted" : "49"]]
    var storeViewObject = [[Dictionary<String,String>()]]
    
    
    var metModel = [Dictionary<String,String>()]
    var notMetModel = [Dictionary<String,String>()]
    var underPlannedModel = [Dictionary<String,String>()]
    
    var metstoreModel = [[Dictionary<String,String>()]]
    var notMetstoreModel = [[Dictionary<String,String>()]]
    var underPlannedstoreModel = [[Dictionary<String,String>()]]
    //var tableViewObject:[Dictionary<String, String>]!
    @IBOutlet weak var displayTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.data = JSON(context!)
        if let items = self.data.array{

            var person  = ""
            var visited = 0
            var target  = 0
            var objectToAppend = Dictionary<String, String>()
            
            var store  = Dictionary<String, String>()
            var stores = [Dictionary<String, String>()]
            
            var oldPerson = ""
            var PersonCounter = 0
            for item in items {
                if let userID = item["UserID"].string{
                    if userID == person{
                        target++
                        if let currentStore = item["Store"].string{
                            store["store"] = currentStore
                        }
                        
                        if let vist = item["count"].int{
                            if vist > 0{
                                visited++
                                store["visited"] = "1"
                            }
                        }else{
                            store["visited"] = "0"
                        }
                        
                        stores.append(store)
                    }else{
                        oldPerson = person
                        if(!oldPerson.isEmpty){
                            objectToAppend["name"]    = oldPerson
                            objectToAppend["visited"] = String(visited)
                            objectToAppend["target"]  = String(target)
                            //objectToAppend["Stores"]  = stores
                            
                            var percentage = (((String(visited) as NSString).floatValue) / ((String(target) as NSString).floatValue)) * 100
                            
                            objectToAppend["percentage"] = String(Int(floor(percentage)))
                            //Deal with this code
                            stores.removeAtIndex(0)
                            if(percentage >= 70){
                                self.metModel.append(objectToAppend)
                                self.metstoreModel.append(stores)
                            }else{
                                self.notMetModel.append(objectToAppend)
                                self.notMetstoreModel.append(stores)
                            }
                            
                            if( target < 20){
                                self.underPlannedModel.append(objectToAppend)
                                self.underPlannedstoreModel.append(stores)
                            }
                            
                            stores.removeAll(keepCapacity: false)
                            //self.tableViewObject.insert(objectToAppend, atIndex:PersonCounter)
                            PersonCounter++
                            visited = 0
                            if let vist = item["count"].int{
                                if vist > 0{
                                    visited = 1
                                }
                            }
                            target  = 0
                            person = userID
                            
                        }else{
                            visited = 0
                            person = userID
                        }
                        
                    }
                }//checking userID
            }//Items Loop
        }//End of checking if Array
        self.metModel.removeAtIndex(0)
        self.notMetModel.removeAtIndex(0)
        self.underPlannedModel.removeAtIndex(0)
        
        self.metstoreModel.removeAtIndex(0)
        self.notMetstoreModel.removeAtIndex(0)
        self.underPlannedstoreModel.removeAtIndex(0)
        
        loadTableData()
        println(self.tableViewObject)
        // Configure interface objects here.*/
    }
    

    func loadTableData(){
        let defaults = NSUserDefaults(suiteName: "watchGrp")
        var opt = defaults?.objectForKey("optClicked") as? String

        if(opt == "met"){
            self.tableViewObject = self.metModel
            self.storeViewObject = self.metstoreModel
        }else if(opt == "notmet"){
            self.tableViewObject = self.notMetModel
            self.storeViewObject = self.notMetstoreModel
        }else if(opt == "underplanned"){
            self.tableViewObject = self.underPlannedModel
            self.storeViewObject = self.underPlannedstoreModel
        }
        
        
        displayTable.setNumberOfRows(self.tableViewObject.count, withRowType: "row")
        for(var idx = 0; idx < self.tableViewObject.count; idx++){
            let row = displayTable.rowControllerAtIndex(idx) as! RowController
            //row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            row.rowLabel.setText(self.tableViewObject[idx]["name"]!)
            row.achieved.setText(self.tableViewObject[idx]["visited"]!)
            row.Target.setText("Target : " + self.tableViewObject[idx]["target"]!)
            
            var percentage = (self.tableViewObject[idx]["percentage"])
            
            if(percentage?.toInt() >= 70){
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            }else{
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(217)/255.0, green: CGFloat(30)/255.0, blue: CGFloat(24)/255.0, alpha: 1.0))
            }
            
            row.percentage.setText(self.tableViewObject[idx]["percentage"]!+"%")
        }
    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        //println(self.storeViewObject[rowIndex])
        pushControllerWithName("stores", context: self.storeViewObject[rowIndex])
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //loadTableData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
