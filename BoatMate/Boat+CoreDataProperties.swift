//
//  Boat+CoreDataProperties.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 11.08.25.
//

import Foundation
import CoreData

extension Boat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Boat> {
        return NSFetchRequest<Boat>(entityName: "Boat")
    }

    @NSManaged public var name: String?
}

extension Boat: Identifiable {
    public var id: NSManagedObjectID { objectID }
}
