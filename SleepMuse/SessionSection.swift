//
//  SessionSection.swift
//  SleepMuse
//
//  Created by William Chrisandy on 14/04/22.
//

import Foundation

class SessionSection
{
    var startDate: Date
    var endDate: Date
    var totalDuration: Int
    var startTime: [Int]
    var dataCount: Int
    
    init (startDate: Date, endDate: Date)
    {
        self.startDate = startDate
        self.endDate = endDate
        totalDuration = 0
        startTime = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        dataCount = 0
    }
}
