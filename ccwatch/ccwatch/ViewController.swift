//
//  ViewController.swift
//  ccwatch
//
//  Created by Boy Genius on 2015/04/10.
//  Copyright (c) 2015 Boy Genius. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var confirmation: UILabel!
    let sharedData = NSUserDefaults(suiteName: "group.watchGrp")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signinclicked(sender: AnyObject) {
        var url = "http://www.dedicatedsolutions.co.za:8082/rest2/Users/VerifyPassword?userID=\(username.text)&password=\(password.text)&format=json"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        println(url)
        request(.GET,url).responseJSON{ (_, _,json,_) in
            //println(json)
            var data = JSON(json!)
            if let status = data["Status"].bool{
                if(status){
                    if let UserID = data["UserInfo"]["UserID"].string{
                        //println(UserID)
                        self.sharedData?.setObject(UserID, forKey: "UserID")
                        
                    }
                    
                    if let SupplierID = data["UserInfo"]["SupplierID"].string{
                        //println(SupplierID)
                        self.sharedData?.setObject(SupplierID, forKey: "SupplierID")
                    }
                    self.confirmation.text = "Logged In Ok You Can Now Use The Watch App"
                }else{
                    self.confirmation.text = "Invalid login details"
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

