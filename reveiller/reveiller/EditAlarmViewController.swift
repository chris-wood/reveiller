//
//  EditAlarmViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit
import CoreData

class EditAlarmViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var decayStepper: UIStepper!
    @IBOutlet weak var startStepper: UIStepper!
    @IBOutlet weak var snoozeStart: UITextField!
    @IBOutlet weak var snoozeDecay: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmPicker: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    
    // TODO: pull the tuple out into a class
    let availableAlarms = ["Death Metal" : ["metal", "wav"], "Soft Jazz" : ["metal", "wav"]]
    var chosenAlarm = ["metal", "wav"]
    
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
            alarm.alarmName = self.chosenAlarm[0]
            alarm.alarmType = self.chosenAlarm[1]
            
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
    
    @IBAction func onSnoozeDecayPress(sender: UIStepper) {
        self.snoozeDecay.text = String(Int(sender.value))
    }
    
    @IBAction func onSnoozeStartPress(sender: UIStepper) {
        self.snoozeStart.text = String(Int(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.datePickerMode = UIDatePickerMode.Time
        self.datePicker.minimumDate = NSDate()
        self.alarmPicker.dataSource = self
        self.alarmPicker.delegate = self
        
        startStepper.minimumValue = 1
        startStepper.maximumValue = 30
        startStepper.value = 10.0
        self.snoozeStart.text = String(Int(startStepper.value))
        
        decayStepper.minimumValue = 2
        decayStepper.maximumValue = 10
        self.snoozeDecay.text = String(Int(decayStepper.value))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableAlarms.keys.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let key = Array(availableAlarms.keys)[row]
        return key
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let key = Array(availableAlarms.keys)[row]
        chosenAlarm = availableAlarms[key]! // it is guaranteed to be in the dictionary
    }
    
}

