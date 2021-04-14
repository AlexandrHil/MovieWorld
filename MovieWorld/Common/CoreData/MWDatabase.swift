//
//  MWDatabase.swift
//  MovieWorld
//
//  Created by Alex on 12.04.21.
//

import Foundation
import CoreData

typealias MWDB = MWDatabase

class MWDatabase {
    static let sh = MWDatabase()

    // MARK: - properties

    private static let databaseContainerName = "MWDataModel"

    private let documentsDirectory: URL

    // MARK: - core data

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: MWDB.databaseContainerName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                Swift.debugPrint(error.localizedDescription)
            }
            Swift.debugPrint("Store description: \(description)")
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }

    // MARK: - initialization

    private init() {
        let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if docDirectory.count > 0 {
            self.documentsDirectory = docDirectory[0]
        } else {
            fatalError("Directory doesn't exist")
        }
    }

    // MARK: - core data functions

    func saveContext() {
        if self.context.hasChanges {
            Swift.debugPrint("Context inerted objects: \(self.context.insertedObjects)")
            Swift.debugPrint("Context deleted objects: \(self.context.deletedObjects)")

            do {
                try self.context.save()
                Swift.debugPrint("Context was saved")
            } catch {
                let nsError = error as NSError
                Swift.debugPrint("couldn't save data. reason: \(nsError.localizedDescription) \(nsError.userInfo))")
            }
        }
    }

    func save(movie: MWMovie) {
        // 1
        let coreDataMovie = Movie(context: self.context)
        // 2
        coreDataMovie.set(movie)
        // 3
        self.saveContext()
    }

    func loadMovies() -> [MWMovie] {
        // 1 - запрос к бд
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: #keyPath(Movie.title), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            // - 2 передаем реквест
            let movies = try self.context.fetch(fetchRequest)
            // - 3 трансформируем в обчный вид
            return movies.map { $0.getMovie() }
        } catch {
            Swift.debugPrint(error.localizedDescription)
            return []
        }
    }

    func delete(_ movies: [MWMovie]) {
        movies.forEach { movie in
            self.getCoreDataObject(from: movie)
        }

        self.saveContext()
    }
    
    @discardableResult
    private func getCoreDataObject(from movie: MWMovie) -> Movie {
        let coreDataMovie = Movie(context: self.context)
        coreDataMovie.set(movie)

        return coreDataMovie
    }
}
