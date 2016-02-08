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
//        let targetTime = startTime + timeIntervalIncrease
        time = NSDate(timeInterval: timeIntervalIncrease, sinceDate: time)
    }
    
    public func addSeconds(n: Int) {
        let startTime = time.timeIntervalSinceNow
        let timeIntervalIncrease = NSTimeInterval(n)
//        let targetTime = startTime + timeIntervalIncrease
        time = NSDate(timeInterval: timeIntervalIncrease, sinceDate: time)
    }
    
    public func addHours(n: Int) {
        let startTime = time.timeIntervalSinceNow
        let timeIntervalIncrease = NSTimeInterval(n * 3600)
//        let targetTime = startTime + timeIntervalIncrease
        time = NSDate(timeInterval: timeIntervalIncrease, sinceDate: time)
    }
    
    public func getDayOfWeek() -> Int {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(self.getDateString())
        let todayDate = formatter.dateFromString(self.getDateString())!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
        let weekDay = (myComponents.weekday % 7) + 1
        
        return weekDay
    }

    
    public func getDateTime() -> NSDate {
        return time
    }
    
    public func update() -> ElasticDateTime {
        time = NSDate()
        return self
    }
    
    public func getDateString() -> String {
        let currentDate = time
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: currentDate)
        
        var targetDateString = String(format: "%04d", components.year) + "-";
        targetDateString = targetDateString + String(format: "%02d", components.month) + "-";
        targetDateString = targetDateString + String(format: "%02d", components.day);
        
        return targetDateString
    }

    
    public func getTimeString() -> String {
        let currentDate = time
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: currentDate)
        
        var targetDateString = String(format: "%02d", components.hour) + ":";
        targetDateString = targetDateString + String(format: "%02d", components.minute) + ":";
        targetDateString = targetDateString + String(format: "%02d", components.second);
        
        return targetDateString
    }
}