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
            print("Cancelling the edit.")
        });
    }
    
    @IBAction func onSaveButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {            
            let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

            let entity =  NSEntityDescription.entityForName("Alarm",
                inManagedObjectContext: appDelegate.managedObjectContext)!
            
            let alarm: RealAlarm = RealAlarm(entity: entity, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
            
            alarm.snoozeStart = NSNumber(integer: Int(self.snoozeStart.text!)!)
            alarm.snoozeDecay = NSNumber(integer: Int(self.snoozeDecay.text!)!)
            
            let dateFormatter = NSDateFormatter()
            let theDateFormat = NSDateFormatterStyle.ShortStyle
            let theTimeFormat = NSDateFormatterStyle.ShortStyle
            
            dateFormatter.dateStyle = theDateFormat
            dateFormatter.timeStyle = theTimeFormat
            let dateString = dateFormatter.stringFromDate(self.datePicker.date)
            alarm.targetTime = dateString
            
            // TODO: set the target time from the date picker
            alarm.alarmName = "metal"
            alarm.alarmType = "wav"
            
            alarm.initialize()
            
            appDelegate.setAlarm(alarm)
            
            do {
                try alarm.managedObjectContext?.save()
//                print("SAVED SAVED")
//                print(alarm)
            } catch {
                print("WTF!")
            }
        });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.datePickerMode = UIDatePickerMode.Time
        self.datePicker.minimumDate = NSDate()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

