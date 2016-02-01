//
//  Alarm.swift
//  réveiller
//
//  Created by cwood on 1/8/16.
//  Copyright © 2016 caw. All rights reserved.
//

import Foundation
import AVFoundation
import CoreData

@objc(RealAlarm)
class RealAlarm : NSManagedObject {
    
    var callbackTarget: AnyObject?
    var callbackSelector: Selector?
    
    var time: ElasticDateTime? // this is the time the alarm fires
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var _snoozeTime: Int = 0
    var _snoozeDecay: Int = 0
    var _snoozeStart: Int = 0
    
    func initialize() -> RealAlarm? {
        _snoozeStart = Int(snoozeStart!)
        _snoozeDecay = Int(snoozeDecay!)
        _snoozeTime = _snoozeStart

        let dateFormatter = NSDateFormatter()
        let theDateFormat = NSDateFormatterStyle.ShortStyle
        let theTimeFormat = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = theDateFormat
        dateFormatter.timeStyle = theTimeFormat
        
        time = ElasticDateTime(dateTime: dateFormatter.dateFromString(targetTime!)!)
        
        do {
            let alarmSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(alarmName!, ofType: alarmType!)!)
            audioPlayer = try AVAudioPlayer(contentsOfURL: alarmSound)
            audioPlayer.prepareToPlay()
        } catch {
            // failed.
            return nil
        }
        
        return self
    }
    
    func setAlarmDate(alarmTime: NSDate) {
        time = ElasticDateTime(dateTime: alarmTime)
    }
    
    func setAlarmDateFromString(timeString: String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let targetDateTime = dateFormatter.dateFromString(timeString)!
        time = ElasticDateTime(dateTime: targetDateTime)
    }
    
    func alarmExpired() -> Bool {
        if (_snoozeTime < 1) {
            return false;
        } else {
            time!.addSeconds(Int(_snoozeTime * 60))
            _snoozeTime /= _snoozeDecay // TODO: this function should be configured in the EDIT alarm screen
        }
        
        return true;
    }
    
    func getTargetDateTime() -> ElasticDateTime {
        return time!
    }
    
    func activateAlarmTimer() {
        let targetTime = time!.getDateTime()
        let timer = NSTimer(fireDate: targetTime, interval: 0, target: callbackTarget!, selector: callbackSelector!, userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func getAlarmRange() -> [(ElasticDateTime, Double)] {
        let changingTime = ElasticDateTime(dateTime: time!.getDateTime())
        var timeRange: [(ElasticDateTime, Double)] = []
        
        var delta = _snoozeStart as Int
        while (delta >= 1) {
            timeRange += [(ElasticDateTime(dateTime: changingTime.getDateTime()), 1.0)]
            
            let newdelta = delta / (snoozeDecay as! Int)
            while delta > newdelta {
                changingTime.addMinutes(1)
                timeRange += [(ElasticDateTime(dateTime: changingTime.getDateTime()), 0.0)]
                delta--
            }
        }
        
        return timeRange
    }
    
    func activateAlarm() {
        _snoozeTime = _snoozeStart
    }
    
    func sound() {
        audioPlayer.play()
    }
}