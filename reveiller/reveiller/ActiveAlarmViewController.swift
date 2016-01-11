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
    
    var alarm: Alarm?
    
    func setCurrentTime() {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: currentDate)
        
        var targetDateString = String(components.hour) + ":";
        targetDateString = targetDateString + String(components.minute) + ":";
        targetDateString = targetDateString + String(format: "%02d", components.second);
        
        timeLabel.text = targetDateString;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make them transparent
        self.timeLabel.alpha = 1.0
        self.stackView.alpha = 1.0
        
        setCurrentTime();
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "setCurrentTime", userInfo: nil, repeats: true)
        
        UIView.transitionWithView(self.stackView, duration: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.backgroundColor = UIColor.blackColor()
                self.timeLabel.textColor = UIColor.whiteColor()
            }, completion: { finished in
                
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}