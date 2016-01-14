//
//  Alarm.swift
//  réveiller
//
//  Created by cwood on 1/8/16.
//  Copyright © 2016 caw. All rights reserved.
//

import Foundation

public class Alarm {
    var snoozeStart: Int = 0
    var snoozeTime: Int = 0
    var snoozeDecay: Int = 0
    
    var callbackTarget: AnyObject?
    var callbackSelector: Selector?
    var time: ElasticDateTime?
    
    init() {
        time = ElasticDateTime(dateTime: NSDate())
    }
    
    public func setAlarmDate(alarmTime: NSDate) {
        time = ElasticDateTime(dateTime: alarmTime)
    }
    
    public func setAlarmDateFromString(timeString: String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let targetDateTime = dateFormatter.dateFromString(timeString)!
        time = ElasticDateTime(dateTime: targetDateTime)
    }
    
    public func setSnoozeTime(time: Int) {
        snoozeStart = time
    }
    
    public func setSnoozeDecay(time: Int) {
        snoozeDecay = time
    }
    
    func alarmExpired() -> Bool {
        if (snoozeTime < 1) {
            return false;
        } else {
            time!.addSeconds(snoozeTime) // TODO: this should be minutes
            snoozeTime /= snoozeDecay
            activateAlarmTimer()
        }
        
        return true;
    }
    
    func activateAlarmTimer() {
        let targetTime = time!.getDateTime()
        let timer = NSTimer(fireDate: targetTime, interval: 0, target: callbackTarget!, selector: callbackSelector!, userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    public func activateAlarm(theTarget: AnyObject, theSelector: Selector) {
        callbackTarget = theTarget
        callbackSelector = theSelector
        snoozeTime = snoozeStart
        activateAlarmTimer()
    }
    
    
}