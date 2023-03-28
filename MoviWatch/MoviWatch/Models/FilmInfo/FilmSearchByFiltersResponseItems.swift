//
//  FilmSearchByFiltersResponseItems.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct FilmSearchByFiltersResponseItems: Decodable {
    let kinopoiskId: Int
    let imdbId: String?
    let nameRu: String?
    let nameEn: String?
    let nameOriginal: String?
    let countries: Country?
    let genres: Genre?
    let year: Int?
    let posterUrl: String?
    let posterUrlPreview: String?
}
