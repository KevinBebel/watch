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
    var Str = ["_status" : true , "_items" : [" {'name': 'Eunice','store': 'REALMO','mon': 0,'tue': 0,'wen': 0,'thur': 1,'fri': 1}","{'name': 'Frost','store': 'FANFARE','mon': 1,'tue': 1,'wen': 0,'thur': 0,'fri': 0}","{'name': 'Giles','store': 'CORPULSE','mon': 0,'tue': 0,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Jodi','store': 'IRACK','mon': 1,'tue': 0,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Marla','store': 'MUSIX','mon': 1,'tue': 1,'wen': 1,'thur': 1,'fri': 0}","{'name': 'Horn','store': 'CHORIZON','mon': 0,'tue': 0,'wen': 0,'thur': 1,'fri': 0}","{'name': 'Boyle','store': 'TRANSLINK','mon': 0,'tue': 1,'wen': 0,'thur': 1,'fri': 1}","{'name': 'Erna','store': 'FLEETMIX','mon': 1,'tue': 1,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Jackson','store': 'VURBO','mon': 1,'tue': 0,'wen': 1,'thur': 0,'fri': 0}","{'name': 'Perez','store': 'ZAYA','mon': 1,'tue': 1,'wen': 0,'thur': 0,'fri': 0}"]]
    
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
        /*for(index,content) in enumerate(data["_items"]){
        
            if(content == "Luke"){
               row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            }else{
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(217)/255.0, green: CGFloat(30)/255.0, blue: CGFloat(24)/255.0, alpha: 1.0))
            }
            
            if let name = data["_items"][index]["Name"].string{
                 row.rowLabel.setText(name)
            }*/
       /* for(var i = 0; i < data["name"].count)
            let row = displayTable.rowControllerAtIndex(index) as! RowController
            row.percentage.setWidth(20.0)
            row.achieved.setText("30")
          
            row.percentage.setText("30%")*/
        
        for(index:String, subJSON:JSON) in self.data {
            println(self.data)
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
