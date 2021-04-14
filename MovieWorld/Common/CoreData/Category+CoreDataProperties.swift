//
//  Category+CoreDataProperties.swift
//  MovieWorld
//
//  Created by Alex on 12.04.21.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var movie: NSOrderedSet?

}

// MARK: Generated accessors for movie
extension Category {

    @objc(insertObject:inMovieAtIndex:)
    @NSManaged public func insertIntoMovie(_ value: Movie, at idx: Int)

    @objc(removeObjectFromMovieAtIndex:)
    @NSManaged public func removeFromMovie(at idx: Int)

    @objc(insertMovie:atIndexes:)
    @NSManaged public func insertIntoMovie(_ values: [Movie], at indexes: NSIndexSet)

    @objc(removeMovieAtIndexes:)
    @NSManaged public func removeFromMovie(at indexes: NSIndexSet)

    @objc(replaceObjectInMovieAtIndex:withObject:)
    @NSManaged public func replaceMovie(at idx: Int, with value: Movie)

    @objc(replaceMovieAtIndexes:withMovie:)
    @NSManaged public func replaceMovie(at indexes: NSIndexSet, with values: [Movie])

    @objc(addMovieObject:)
    @NSManaged public func addToMovie(_ value: Movie)

    @objc(removeMovieObject:)
    @NSManaged public func removeFromMovie(_ value: Movie)

    @objc(addMovie:)
    @NSManaged public func addToMovie(_ values: NSOrderedSet)

    @objc(removeMovie:)
    @NSManaged public func removeFromMovie(_ values: NSOrderedSet)

}

extension Category : Identifiable {

}
