//
//  Session+CoreDataProperties.swift
//  SleepMuse
//
//  Created by William Chrisandy on 12/04/22.
//
//

import Foundation
import CoreData


extension Session
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session>
    {
        return NSFetchRequest<Session>(entityName: "Session")
    }
    
    @nonobjc public class func fetchRequest(since: Date) -> NSFetchRequest<Session>
    {
        let fetchRequest = NSFetchRequest<Session>(entityName: "Session")
        fetchRequest.predicate = NSPredicate(format: "startTime >= %@", since as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: false)]
        return fetchRequest
    }

    @NSManaged public var duration: Int16
    @NSManaged public var startTime: Date?
    @NSManaged public var with: Music?

}

extension Session : Identifiable
{

}
