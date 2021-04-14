//
//  Movie+CoreDataClass.swift
//  MovieWorld
//
//  Created by Alex on 12.04.21.
//
//

import UIKit
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

    func set(_ movie: MWMovie) {
        self.id = Int64(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.posterImage = movie.posterImage?.pngData()
    }

    func getMovie() -> MWMovie {
        let movie = MWMovie(id: Int(self.id), title: self.title ?? "")
        movie.overview = self.overview
        movie.posterPath = self.posterPath
        if let data = self.posterImage {
            movie.posterImage = UIImage(data: data)
        }

        return movie
    }
}
