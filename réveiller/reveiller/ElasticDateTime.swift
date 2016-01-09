//
//  ElasticDateTime.swift
//  réveiller
//
//  Created by cwood on 1/8/16.
//  Copyright © 2016 caw. All rights reserved.
//

import Foundation

public class ElasticDateTime {
    var time: NSDate = NSDate()
    
    init(dateTime: NSDate) {
        time = dateTime
    }
    
    public func addMinutes(n: Int) {
        let startTime = time.timeIntervalSinceNow
        let timeIntervalIncrease = NSTimeInterval(n * 60)
        let targetTime = startTime + timeIntervalIncrease
        time = NSDate(timeInterval: targetTime, sinceDate: time)
    }
    
    public func addSeconds(n: Int) {
        let startTime = time.timeIntervalSinceNow
        let timeIntervalIncrease = NSTimeInterval(n)
        let targetTime = startTime + timeIntervalIncrease
        time = NSDate(timeInterval: targetTime, sinceDate: time)
    }
    
    public func addHours(n: Int) {
        let startTime = time.timeIntervalSinceNow
        let timeIntervalIncrease = NSTimeInterval(n * 3600)
        let targetTime = startTime + timeIntervalIncrease
        time = NSDate(timeInterval: targetTime, sinceDate: time)
    }
    
    public func getDateTime() -> NSDate {
        return time
    }
}