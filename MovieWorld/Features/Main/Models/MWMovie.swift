//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

class MWMovie: Decodable {
    let id: Int
    let title: String
    var overview: String?
    var adult: Bool?
    var voteCount: Int?
    var popularity: Double?
    var genreIds: [Int]?
    var releaseDate: String?
    // let release_date: Date
    var posterPath: String?

    var posterImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteCount = "vote_count"
        case popularity
        case adult
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case overview
    }

    // MARK: - initializators

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        self.releaseDate = (try? container.decodeIfPresent(String.self, forKey: .releaseDate)) ?? "02.02.2021"
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
    }
}
