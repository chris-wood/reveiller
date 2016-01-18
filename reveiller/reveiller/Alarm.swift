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

        // TODO: intiialzie this from the targetTime String
        time = ElasticDateTime(dateTime: NSDate())
        
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
            time!.addSeconds(Int(_snoozeTime)) // TODO: this should be minutes
            _snoozeTime /= _snoozeDecay
            activateAlarmTimer()
        }
        
        return true;
    }
    
    func activateAlarmTimer() {
        let targetTime = time!.getDateTime()
        let timer = NSTimer(fireDate: targetTime, interval: 0, target: callbackTarget!, selector: callbackSelector!, userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func activateAlarm(theTarget: AnyObject, theSelector: Selector) {
        callbackTarget = theTarget
        callbackSelector = theSelector
        _snoozeTime = _snoozeStart
        activateAlarmTimer()
    }
    
    func sound() {
        audioPlayer.play()
    }
}