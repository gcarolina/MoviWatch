//
//  Film.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct Film: Decodable {
    let kinopoiskId: Int
    let nameRu: String?
    let nameOriginal: String?
    let posterUrl: String?
    let posterUrlPreview: String?
    let coverUrl: String?
    let logoUrl: String?
    let reviewsCount: Int?
    let webUrl: String?
    let year: Int?
    let filmLength: Int?
    let description: String?
    let countries: Country?
    let genres: Genre?
    let startYear: Int?
    let endYear: Int?
}
