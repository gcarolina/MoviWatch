//
//  FilmSearchResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct FilmSearchResponse: Decodable {
    let keyword: String?
    let searchFilmsCountResult: Int?
    let films: [FilmSearchResponseFilms]?
}
