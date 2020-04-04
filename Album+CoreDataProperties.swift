//
//  Album+CoreDataProperties.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 11/3/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var thumbnailImage: Data?
//    @NSManaged public var createdAt: Date?

}
