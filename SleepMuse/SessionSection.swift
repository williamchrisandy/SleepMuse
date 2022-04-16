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
    var totalDuration: Double
    var startTime: [Int]
    var dataCount: Int
    
    init (startDate: Date)
    {
        self.startDate = startDate
        totalDuration = 0
        startTime = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        dataCount = 0
    }
}
