//
//  EditAlarmViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit
import CoreData

class EditAlarmViewController : UIViewController {
    
    @IBOutlet weak var snoozeStart: UITextField!
    @IBOutlet weak var snoozeDecay: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func onCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
            let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let entity =  NSEntityDescription.entityForName("Alarm",
                inManagedObjectContext: appDelegate.managedObjectContext)
            
            let thealarm = RealAlarm(entity: entity!, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
            thealarm.snoozeStart = NSNumber(integer: Int(self.snoozeStart.text!)!)
            thealarm.snoozeDecay = NSNumber(integer: Int(self.snoozeDecay.text!)!)
            // TODO: set the target time from the date picker 
            thealarm.alarmName = "metal"
            thealarm.alarmType = "wav"
            
            appDelegate.setAlarm(thealarm)
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

