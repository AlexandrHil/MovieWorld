//
//  MVPopularMoviesResponse.swift
//  MovieWorld
//
//  Created by Alex on 5.04.21.
//

import Foundation

// модель данных на сервер

struct MWPopularMoviesResponse: Decodable {
    let page: Int
    let results: [MWMovie]
    let total_results: Int
    let total_pages: Int
}
