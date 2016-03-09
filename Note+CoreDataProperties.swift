//
//  Note+CoreDataProperties.swift
//  iOSExperiments
//
//  Created by Serge Panev on 09/03/16.
//  Copyright © 2016 Serge Panev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var name: String?
    @NSManaged var content: String?
    @NSManaged var date: NSDate?

}
