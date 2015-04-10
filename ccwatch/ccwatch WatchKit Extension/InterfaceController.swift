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
    @IBOutlet weak var displayTable: WKInterfaceTable!
    var arrayOfObjects = ["Paul","Peter","John","Luke","Matt"];
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    func loadTableData(){
        displayTable.setNumberOfRows(arrayOfObjects.count, withRowType: "row")
        for(index,content) in enumerate(arrayOfObjects){
            let row = displayTable.rowControllerAtIndex(index) as RowController
            if(content == "Luke"){
               row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(144)/255.0, green: CGFloat(198)/255.0, blue: CGFloat(149)/255.0, alpha: 1.0))
            }else{
                row.rowGroup.setBackgroundColor(UIColor(red: CGFloat(239)/255.0, green: CGFloat(72)/255.0, blue: CGFloat(54)/255.0, alpha: 1.0))
            }
            row.rowLabel.setText(content)
            row.achieved.setText("30")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        loadTableData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
