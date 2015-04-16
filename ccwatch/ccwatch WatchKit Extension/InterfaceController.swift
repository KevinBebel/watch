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
    @IBOutlet weak var displayTable: WKInterfaceTable!
    var arrayOfObjects = ["Paul Tsele","Peter","John"];
    var Str = ["_status" : true , "_items" : "[{name : 'Kevin' , target : 50},{name : 'Kevin' , target : 50}]"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.data = JSON(context!)
        let json = JSON(self.Str)
        println(json)
        println(self.data)
        // Configure interface objects here.
    }
    

    func loadTableData(){
        displayTable.setNumberOfRows(arrayOfObjects.count, withRowType: "row")
        for(index,content) in enumerate(arrayOfObjects){
            let row = displayTable.rowControllerAtIndex(index) as! RowController
            if(content == "Luke"){
               row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            }else{
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(217)/255.0, green: CGFloat(30)/255.0, blue: CGFloat(24)/255.0, alpha: 1.0))
            }
            
            if let name = data[index]["Name"].string{
                 row.rowLabel.setText(name)
            }
        
            row.percentage.setWidth(20.0)
            row.achieved.setText("30")
          
            row.percentage.setText("30%")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        /*request(.GET, "http://107.21.55.154/rest/index.php/Options/Sync2?supplierID=LAKATO&userID=%27LAKATO%27&version=0&skip=0&top=250&format=json").responseString{ (_, _,string,_)
            in //println(JSON)
            self.my = JSON(string!)
            println(self.my)
        }*/
        //self.my = self.my.stringValue as? [JSON]
        loadTableData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
