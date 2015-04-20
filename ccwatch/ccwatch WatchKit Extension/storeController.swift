//
//  storeController.swift
//  ccwatch
//
//  Created by Boy Genius on 2015/04/20.
//  Copyright (c) 2015 Boy Genius. All rights reserved.
//

import WatchKit
import Foundation


class storeController: WKInterfaceController {
    var stores : [Dictionary<String,String>]!
    
    @IBOutlet weak var displayTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.stores = context as! [Dictionary<String,String>]
        println("\(context)")
        loadtabledata()
        // Configure interface objects here.
    }
    
    func loadtabledata(){
        displayTable.setNumberOfRows(self.stores.count, withRowType: "storeRow")
        for(var idx = 0; idx < self.stores.count; idx++){
            let row = displayTable.rowControllerAtIndex(idx) as! StoreRowController
            
            row.rowLabel.setText(self.stores[idx]["store"])
            if(self.stores[idx]["visited"] == "1"){
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(46)/255.0, green: CGFloat(204)/255.0, blue: CGFloat(113)/255.0, alpha: 1.0))
            }else{
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(217)/255.0, green: CGFloat(30)/255.0, blue: CGFloat(24)/255.0, alpha: 1.0))
            }
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
