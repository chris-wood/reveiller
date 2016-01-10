//
//  EditAlarmViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit

class EditAlarmViewController : UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func onCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
            let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.setAlarm(nil)
//            appDelegate.addAlarm(alarm)
        });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

