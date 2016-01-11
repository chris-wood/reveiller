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
        // Do any additional setup after loading the view, typically from a nib.
        
        setCurrentTime();
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "setCurrentTime", userInfo: nil, repeats: true)
        
        UIView.transitionWithView(self.stackView, duration: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.stackView.backgroundColor = UIColor.blackColor()
            }, completion: { finished in
                
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}