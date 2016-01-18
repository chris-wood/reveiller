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
    
    var alarm: RealAlarm?
    var time: ElasticDateTime?
    var targetDate: NSDate = NSDate();
    
    func timerExpired() {
        if alarm!.alarmExpired() {
            print("Snooze!")
        } else {
            print("Done!")
            backgroundView.backgroundColor = UIColor.blackColor()
        }
    }
    
    func setCurrentTime() {
        let timeString = time!.update().getTimeString()
        print(timeString)
        targetTimeLabel.text = timeString
    }
    
    func initUI() {
        time = ElasticDateTime(dateTime: NSDate())
        targetTimeLabel.text = alarm!.time?.getTimeString()
    }
    
    func setViewAlarm(the_alarm: RealAlarm) {
        self.alarm = the_alarm.initialize()
        initUI()
    }
    
    @IBAction func onActivatePress(sender: UIButton) {
        alarm!.time?.update()
        let alarmTime = alarm!.time!
        
        alarmTime.addSeconds(3)
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
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "setCurrentTime", userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

