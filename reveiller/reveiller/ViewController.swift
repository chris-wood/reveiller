//
//  ViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var activateButton: UIButton!
    
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var decayTimeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var alarm: Alarm = Alarm()
    var time: ElasticDateTime?
    var targetDate: NSDate = NSDate();
    
    func timerExpired() {
        if alarm.alarmExpired() {
            print("Snooze!")
        } else {
            print("Done!")
            backgroundView.backgroundColor = UIColor.blackColor()
        }
    }
    
    func initUI() {
        alarm = Alarm()
        targetTimeLabel.text = alarm.time?.getTimeString()
    }
    
    func snoozeTimeExpired() {
        // TODO: check to see if the alarm should halt, decrease the snooze time, and reset the timer
    }
    
    @IBAction func onActivatePress(sender: UIButton) {
//        let currentDate = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components([.Day , .Month , .Year, .Hour, .Minute, .Second], fromDate: currentDate)
//
//        var targetDateString = String(components.year) + "-";
//        targetDateString = targetDateString + String(format: "%02d", components.month) + "-";
//        targetDateString = targetDateString + String(format: "%02d", components.day) + " ";
//        targetDateString = targetDateString + String(format: "%02d", components.hour) + ":";
//        
//        if (components.second + 3 > 60) {
//            targetDateString = targetDateString + String(format: "%02d", components.minute + 1) + ":";
//            targetDateString = targetDateString + String(format: "%02d", (components.second + 3) % 60);
//        } else {
//            targetDateString = targetDateString + String(format: "%02d", components.minute) + ":";
//            targetDateString = targetDateString + String(format: "%02d", components.second + 3);
//        }
//        
//        print(targetDateString)
        
        alarm.time?.update()
        let alarmTime = alarm.time!
        alarmTime.addSeconds(3)
        alarm.setAlarmDate(alarmTime.getDateTime())
        
//        performSegueWithIdentifier("ShowActiveAlarm", sender: alarm)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowActiveAlarm" {
            if let activeAlarmViewController = segue.destinationViewController as? ActiveAlarmViewController {
                activeAlarmViewController.alarm = alarm
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

