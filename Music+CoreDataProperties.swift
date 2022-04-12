//
//  Music+CoreDataProperties.swift
//  SleepMuse
//
//  Created by William Chrisandy on 12/04/22.
//
//

import Foundation
import CoreData


extension Music
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Music>
    {
        return NSFetchRequest<Music>(entityName: "Music")
    }

    @NSManaged public var title: String?
    @NSManaged public var fileName: String?
    @NSManaged public var usedIn: NSSet?

}

// MARK: Generated accessors for usedIn
extension Music
{

    @objc(addUsedInObject:)
    @NSManaged public func addToUsedIn(_ value: Session)

    @objc(removeUsedInObject:)
    @NSManaged public func removeFromUsedIn(_ value: Session)

    @objc(addUsedIn:)
    @NSManaged public func addToUsedIn(_ values: NSSet)

    @objc(removeUsedIn:)
    @NSManaged public func removeFromUsedIn(_ values: NSSet)

}

extension Music : Identifiable
{

}
