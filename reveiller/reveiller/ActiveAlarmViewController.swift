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
    @IBOutlet weak var snoozeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var alarm: RealAlarm?
    var currentTime: ElasticDateTime?
    var backgroundColor: Bool = false
    
    func animateButtonWithAlpha(button: UIButton, alpha: CGFloat) {
        UIView.transitionWithView(button, duration: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.dismissButton.alpha = alpha
            }, completion: { finished in
                // nothing
            }
        )
        UIView.transitionWithView(button, duration: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.snoozeButton.alpha = alpha
            }, completion: { finished in
                // nothing
            }
        )
    }
    
    func showButtons() {
        animateButtonWithAlpha(self.snoozeButton, alpha: 1.0)
        animateButtonWithAlpha(self.dismissButton, alpha: 1.0)
    }
    
    func hideButtons() {
        animateButtonWithAlpha(self.snoozeButton, alpha: 0.0)
        animateButtonWithAlpha(self.dismissButton, alpha: 0.0)
    }
    
    @IBAction func onSnoozeButtonPress(sender: AnyObject) {
        hideButtons()
        activateAlarm()
    }
    
    @IBAction func onDismissButtonPress(sender: AnyObject) {
        hideButtons()
        self.dismissViewControllerAnimated(true, completion: {
            // TODO: maybe do some stat collection somewhere in here about the number of snoozes, etc.
        })
    }
    
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
        // Handle the alarm logic
        if alarm!.alarmExpired() {
            print("Snooze!")
            
            // Re-enable the buttons for interaction
            showButtons()
        } else {
            print("Done!")
            animateButtonWithAlpha(self.dismissButton, alpha: 1.0) // only show the dismiss button!
            NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "flashScreen", userInfo: nil, repeats: true)
            alarm!.sound()
        }
    }
    
    func activateAlarm() {
        let targetTime = alarm!.getTargetDateTime().getDateTime()
        let timer = NSTimer(fireDate: targetTime, interval: 0, target: self, selector: Selector("timerExpired"), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
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
        
        snoozeButton.alpha = 0
        dismissButton.alpha = 0
        
        // Turn off idle mode
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        activateAlarm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}