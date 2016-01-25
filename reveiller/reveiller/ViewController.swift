//
//  ViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var decayLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var activateButton: UIButton!
    
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var decayTimeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var alarm: RealAlarm?
    var targetDate: NSDate = NSDate();
    
    func timerExpired() {
        if alarm!.alarmExpired() {
            print("Snooze!")
        } else {
            print("Done!")
            backgroundView.backgroundColor = UIColor.blackColor()
        }
    }
    
    func initUI() {
        let targetDate = alarm!.time!.getDateTime()
        let targetTime = alarm!.time!.getTimeString()
        print("Target alarm time: ", targetDate, targetTime)
        targetTimeLabel.text = targetTime
        
        let decay = String(alarm!.snoozeStart!);
        decayLabel.text = decay
        
        let start = String(alarm!.snoozeDecay!)
        startLabel.text = start
    }
    
    func setViewAlarm(the_alarm: RealAlarm) {
        self.alarm = the_alarm
        initUI()
    }
    
    @IBAction func onActivatePress(sender: UIButton) {
        let alarmTime = alarm!.time!
    
        alarmTime.addSeconds(10)
        
        print("Setting the alarm at", alarm!.time?.getTimeString())
        alarm!.setAlarmDate(alarmTime.getDateTime())
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

