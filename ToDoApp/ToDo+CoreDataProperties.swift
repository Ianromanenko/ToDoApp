//
//  ToDo+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Yan on 2018-01-10.
//  Copyright © 2018 Centennial College. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String?
    @NSManaged public var notes: String?

}
