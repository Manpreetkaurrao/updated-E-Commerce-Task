//
//  Cartlist+CoreDataProperties.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 18/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import Foundation
import CoreData


extension Cartlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cartlist> {
        return NSFetchRequest<Cartlist>(entityName: "Cartlist");
    }

    @NSManaged public var productName: String?
    @NSManaged public var productPrice: String?

}
