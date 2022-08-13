//
//  Static Function.swift
//  SleepMuse
//
//  Created by William Chrisandy on 13/04/22.
//

import UIKit
import CoreData

class StaticFunction
{
    static func setUpCompleted()
    {
        UserDefaults.standard.set(true, forKey: keyFirstTime)
    }
    
    static func createDurationString(_ duration: Double) -> String
    {
        let hour = Int(duration/3600)
        let minute = Int(duration/60) % 60
        var durationString = ""
        if(hour > 0)
        {
            durationString += "\(hour)h "
        }
        if(minute > 0)
        {
            durationString += "\(minute)m"
        }
        
        return durationString
    }
    
    static func dateToTimeString(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        return dateFormatter.string(from:date)
    }
    
    static func dateToPartOfDayString(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hour = dateFormatter.string(from: date)
        if hour <= "06"
        {
            return "Night"
        }
        else if hour <= "12"
        {
            return "Morning"
        }
        else if hour <= "18"
        {
            return "Afternoon"
        }
        else if hour <= "22"
        {
            return "Evening"
        }
        else
        {
            return "Night"
        }
    }
    
    static func dateToHourString(_ date: Date) -> String
    {
        // 6 12 6 10
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: date)
    }
    
    static func dateToDayAndMonthString(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from:date)
    }
    
    static func dateToNameOfDay(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from:date)
    }
    
    static func secondToHHMMSS(_ totalSecond: Int) -> String
    {
        let hour = totalSecond / 3600
        let minute = (totalSecond % 3600) / 60
        let second = totalSecond % 60
        
        return String(format: "%.2d:%.2d:%.2d", hour, minute, second)
    }
}
