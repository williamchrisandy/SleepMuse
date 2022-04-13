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
        
        //Dummy Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do
        {
            let session = Session(context: context)
            session.duration = 3600.00
            session.startTime = Date()
            
            let music = Music(context: context)
            music.title = musicDataArray[1].musicName
            music.fileName = musicDataArray[3].musicAudio
            
            session.with = music
            
            context.insert(session)
            try context.save()
        }
        catch let error
        {
            print(error.localizedDescription)
        }
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
}

/*
    //DUMP
 
 */
