//
//  ActiveAlarmViewController.swift
//  reveiller
//
//  Created by cwood on 1/11/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit
import Foundation

class ActiveAlarmViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var alarm: RealAlarm?
    var currentTime: ElasticDateTime?
    var backgroundColor: Bool = false
    
    func setCurrentTime() {
        let time = currentTime!.update().getTimeString()
        print(time)
        timeLabel.text = time
    }
    
    func flashScreen() {
        if (backgroundColor) {
            self.view!.backgroundColor = UIColor.blackColor()
            self.timeLabel.textColor = UIColor.whiteColor()
        } else {
            self.view!.backgroundColor = UIColor.whiteColor()
            self.timeLabel.textColor = UIColor.blackColor()
        }
        backgroundColor = !backgroundColor
    }
    
    func timerExpired() {
        if alarm!.alarmExpired() {
            print("Snooze!")
        } else {
            print("Done!")
            NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "flashScreen", userInfo: nil, repeats: true)
            alarm!.sound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make them transparent
        self.timeLabel.alpha = 1.0
        self.stackView.alpha = 1.0
        
        // Initialize and start updating the current time
        self.currentTime = ElasticDateTime(dateTime: NSDate())
        setCurrentTime();
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "setCurrentTime", userInfo: nil, repeats: true)
        
        UIView.transitionWithView(self.stackView, duration: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.backgroundColor = UIColor.blackColor()
                self.timeLabel.textColor = UIColor.whiteColor()
            }, completion: { finished in
                
            }
        )
        
        alarm!.snoozeStart = 10
        alarm!.snoozeDecay = 2 // half every time
        alarm!.activateAlarm(self, theSelector: Selector("timerExpired"));
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}