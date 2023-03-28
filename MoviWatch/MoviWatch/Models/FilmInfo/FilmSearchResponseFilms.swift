//
//  FilmSearchResponseFilms.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct FilmSearchResponseFilms: Decodable {
    let filmId: Int?
    let nameRu: String?
    let nameEn: String?
    let type: String?
    let year: String?
    let description: String?
    let filmLength: String?
    let countries: Country?
    let genres: Genre?
    let rating: String?
    let posterUrl: String?
    let posterUrlPreview: String?
}
