//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

//содержание данных в одной ячейке movie

class MWMovie: Decodable {
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String?
    let release_date: String
//    let release_date: Date

}
