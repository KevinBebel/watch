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
    var data:JSON = JSON.nullJSON
    //Object that the table view will use to display data
    var tableViewObject = [["name" : "Kevin" , "target" : "50" , "visted" : "49"]]
    @IBOutlet weak var displayTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context) 
        self.data = JSON(context!)
        //var count = 15

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
        loadTableData()
        println(self.tableViewObject)
        // Configure interface objects here.
    }
    

    func loadTableData(){
        displayTable.setNumberOfRows(self.tableViewObject.count, withRowType: "row")
        for(var idx = 0; idx < self.tableViewObject.count - 1; idx++){
            let row = displayTable.rowControllerAtIndex(idx) as! RowController
            //row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            row.rowLabel.setText(self.tableViewObject[idx]["name"]!)
            row.achieved.setText(self.tableViewObject[idx]["visited"]!)
            row.Target.setText("Target : " + self.tableViewObject[idx]["target"]!)
            
            var percentage = (((self.tableViewObject[idx]["visited"]! as NSString).floatValue) / ((self.tableViewObject[idx]["target"]! as NSString).floatValue)) * 100
            
            if(Int(percentage) >= 70){
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            }else{
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(217)/255.0, green: CGFloat(30)/255.0, blue: CGFloat(24)/255.0, alpha: 1.0))
            }
            
            row.percentage.setText("\(Int(floor(percentage)))%")
        }

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
