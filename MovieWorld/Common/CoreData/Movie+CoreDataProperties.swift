//
//  Movie+CoreDataProperties.swift
//  MovieWorld
//
//  Created by Alex on 12.04.21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var title: String?
    @NSManaged public var category: Category?

}

extension Movie : Identifiable {

}
