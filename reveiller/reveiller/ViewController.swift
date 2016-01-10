//
//  ViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var activateButton: UIButton!
    
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
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
    
    func snoozeTimeExpired() {
        // TODO: check to see if the alarm should halt, decrease the snooze time, and reset the timer
    }
    
    func setCurrentTime() {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: currentDate)
        
        var targetDateString = String(components.hour) + ":";
        targetDateString = targetDateString + String(components.minute) + ":";
        targetDateString = targetDateString + String(format: "%02d", components.second);
        
        timeLabel.text = targetDateString;
    }
    
    @IBAction func onActivatePress(sender: UIButton) {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year, .Hour, .Minute, .Second], fromDate: currentDate)
        
        //         TODO: this is temporary until the date picker is set (that's in the second view)
        var targetDateString = String(components.year) + "-";
        targetDateString = targetDateString + String(format: "%02d", components.month) + "-";
        targetDateString = targetDateString + String(format: "%02d", components.day) + " ";
        targetDateString = targetDateString + String(format: "%02d", components.hour) + ":";
        
        if (components.second + 3 > 60) {
            targetDateString = targetDateString + String(format: "%02d", components.minute + 1) + ":";
            targetDateString = targetDateString + String(format: "%02d", (components.second + 3) % 60);
        } else {
            targetDateString = targetDateString + String(format: "%02d", components.minute) + ":";
            targetDateString = targetDateString + String(format: "%02d", components.second + 3);
        }
        
        print(targetDateString)
        
        alarm.setSnoozeTime(20)
        alarm.setSnoozeDecay(2) // half every time
        alarm.setAlarmDate(targetDateString)
        alarm.activateAlarm(self, theSelector: Selector("timerExpired"));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setCurrentTime();
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "setCurrentTime", userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

